import 'dart:convert';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nhan_tin_noi_bo/features/chat/widgets/OwnMessageCard.dart';
import 'package:nhan_tin_noi_bo/features/settings/screens/SettingsOwn.dart';
import 'package:nhan_tin_noi_bo/config/IPconfig.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:realm/realm.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../data/model/Message/MessageModel.dart';
import '../../../data/model/chatmodel.dart';
import '../../../data/realm/realm_models/models.dart';
import '../../../data/realm/realm_services/realm.dart';
import '../widgets/ImagePicker/ImagePickerSheet.dart';
import '../widgets/ImagePicker/OwnImageCard .dart';
import '../widgets/ImagePicker/ReplyImageCard.dart';
import '../widgets/ReplyCard.dart';

class Individualpage extends StatefulWidget {
  const Individualpage({
    super.key,
    required this.chatModel,
    required this.sourchat,
    required this.currentUserId,
    required this.receiverId,
    required this.socket,
  });

  final ChatModel chatModel;
  final ChatModel sourchat;
  final ObjectId  currentUserId;
  final ObjectId  receiverId;
  final IO.Socket socket;

  @override
  State<Individualpage> createState() => _IndividualpageState();
}

class _IndividualpageState extends State<Individualpage> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();

  String? selectedFileName;
  bool ShowEmoji = false;
  bool CheckValueInput = false;
  bool isImagePickerShown = false;
  bool IsLoadImages = false;
  bool IsLoadFiles = false;
  bool SentButton = false;

  double bottomInset = 0;
  double bottomSheetHeight = 0.3;

  List<XFile> ImagePath = [];
  List<AssetEntity> allImages = [];
  List<MessageModel> messages = [];
  List<AssetEntity> selectedImagesFromSheet = [];
  late RealmResults<TinNhanCaNhan> results;
  final realm = RealmService().realm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.socket.on("message", _handleIncomingMessage);
    final NguoiDung? nguoiGui = realm.find<NguoiDung>(widget.currentUserId);
    final NguoiDung? nguoiNhan = realm.find<NguoiDung>(widget.receiverId);

    results = realm.query<TinNhanCaNhan>(
        '((nguoiGui == \$0 AND nguoiNhan == \$1) OR (nguoiGui == \$1 AND nguoiNhan == \$0)) SORT(thoiGianGui ASC)',
        [nguoiGui, nguoiNhan]
    );

    _controller.addListener(() {
      setState(() {
        CheckValueInput = _controller.text.trim().isNotEmpty;
      });
    });

  }
  @override
  void dispose() {
    widget.socket.off("message", _handleIncomingMessage);
    super.dispose();
  }


  void _showMessageOptionsDialog(BuildContext context, MessageModel message) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.push_pin),
                title: Text('Ghim tin nhắn'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    // chỉ cho phép tối đa 3 tin nhắn được ghim
                    if (messages.where((m) => m.isPinned).length < 3) {
                      message.isPinned = true;
                    }
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Xóa tin nhắn'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    messages.remove(message);
                  });
                },
              ),
            ],
          ),
    );
  }

  void ControllerNewMessage() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // void connect() {
  //   socket = IO.io("http://${AppConfig.baseUrl}:5000", <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": true,
  //   });
  //   socket?.connect();
  //   socket?.onConnect((data) {
  //     socket?.emit("signin", widget.currentUserId.toString());
  //     print("Connected");
  //     // socket?.on("message", (msg) {
  //     //   print(msg);
  //     //   // setMessage("destination", msg["message"], msg["path"]);
  //     //   setMessage(msg["sourceId"], msg["message"], msg["path"]);
  //     //   ControllerNewMessage();
  //     // });
  //     socket?.on("message", (msg) {
  //       final isMe = msg["sourceId"] == widget.currentUserId.toString();
  //
  //       setMessage(
  //         isMe ? "source" : "destination",
  //         msg["message"],
  //         msg["path"],
  //       );
  //
  //       ControllerNewMessage();
  //     });
  //   });
  //   print(socket?.connected);
  // }

  void _handleIncomingMessage(dynamic msg) {
    bool isMe = msg["senderId"] == widget.currentUserId.toString();

    setMessage(
      isMe ? "source" : "destination",
      msg["message"],
      msg["path"],
    );
    saveMessageToDB(msg);
    ControllerNewMessage();
  }

  void sendMessage(String message, ObjectId sourceId, ObjectId targetId, String path) {
    if (widget.socket != null && widget.socket!.connected) {
      setMessage("source", message, path);
      widget.socket!.emit("message", {
        "message": message,
        "sourceId": sourceId.toString(),
        "targetId": targetId.toString(),
        "path": path,
      });
    } else {
      // Có thể báo lỗi hoặc lưu lại tin nhắn chờ gửi
      print("Socket not connected!");
    }
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
      message: message,
      type: type,
      path: path,
      time: DateTime.now().toString().substring(10, 16),
      isPinned: false,
    );
    setState(() {
      messages.add(messageModel);
    });
  }

  void saveMessageToDB(Map<String, dynamic> data) {

    final NguoiDung? nguoiGui = realm.find<NguoiDung>(ObjectId.fromHexString(data["sourceId"]));
    final NguoiDung? nguoiNhan = realm.find<NguoiDung>(ObjectId.fromHexString(data["targetId"]));

    if (nguoiGui == null || nguoiNhan == null) {
      print("❌ Không tìm thấy người gửi hoặc người nhận.");
      return;
    }

    realm.write(() {
      final tinNhan = TinNhanCaNhan(
          ObjectId(),
          data["message"],
          "text",
          DateTime.now(),
          ''
      );
      tinNhan.nguoiGui = nguoiGui;
      tinNhan.nguoiNhan = nguoiNhan;
      tinNhan.ghim = false;
      tinNhan.thoiGianGui = DateTime.now();

      realm.add(tinNhan, update: true);
    });

    print("✅ Tin nhắn [message: ${data["message"]}] [id: ${data["sourceId"].toString()} to id: ${data["sourceId"].toString()}] đã lưu vào Realm");
  }

  Future<List<String>> sendImageSend(
    List<AssetEntity> selectedImagesFromSheet,
  ) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("http://${AppConfig.baseUrl}:5000/routes/addimage"),
    );

    for (AssetEntity asset in selectedImagesFromSheet) {
      File? file = await asset.file;
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath("img", file.path));
      }
    }

    request.headers.addAll({"Content-type": "multipart/form-data"});

    http.StreamedResponse response = await request.send();
    var httResponse = await http.Response.fromStream(response);
    var data = json.decode(httResponse.body);

    if (response.statusCode == 200 && data['path'] != null) {
      List<String> serverPaths = List<String>.from(data['path']);
      return serverPaths;
    } else {
      return [];
    }
  }

  // Load Ảnh
  Future<void> LoadAllImages() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> albums = [];

    if (ps.isAuth || ps.hasAccess) {
      albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.all,
      );
    }

    if (albums.isNotEmpty) {
      List<AssetEntity> media = await albums[0].getAssetListPaged(
        page: 0,
        size: 100,
      );
      setState(() {
        allImages = media;
      });
    } else {
      PhotoManager.openSetting();
    }
  }

  void pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedFileName = image.name;
        ImagePath = [image];
        IsLoadFiles = true;
      });

      print('Đường dẫn ảnh: ${image.path}');
    } else {
      print('Không chọn ảnh nào');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.currentUserId);
    // print(widget.receiverId);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFD9E2ED),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chatModel.name,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              "Đang hoạt động",
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.phone, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.videocam, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder:
                      (context, animation, secondaryAnimation) => SettingsOwn(),
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    final tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
            icon: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            ShowEmoji = false;
            IsLoadImages = false;
          });
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == messages.length) {
                    return Container(height: 70);
                  }
                  //TODO: Vừa sửa lại 1 ít để nhấn vô hiện menu ghim
                  // if (messages[index].type == "source") {
                  //   if (messages[index].path.isNotEmpty) {
                  //     return GestureDetector(
                  //       onLongPress:
                  //           () => _showMessageOptionsDialog(
                  //             context,
                  //             messages[index],
                  //           ),
                  //       child: OwnImageCard(
                  //         path: [messages[index].path],
                  //         time: messages[index].time,
                  //       ),
                  //     );
                  //   } else {
                  //     return GestureDetector(
                  //       onLongPress:
                  //           () => _showMessageOptionsDialog(
                  //             context,
                  //             messages[index],
                  //           ),
                  //       child: OwnMessageCard(
                  //         message: messages[index].message,
                  //         time: messages[index].time,
                  //       ),
                  //     );
                  //   }
                  // } else {
                  //   if (messages[index].path.isNotEmpty) {
                  //     return ReplyImageCard(
                  //       path: [messages[index].path],
                  //       time: messages[index].time,
                  //     );
                  //   } else {
                  //     return GestureDetector(
                  //       onLongPress:
                  //           () => _showMessageOptionsDialog(
                  //             context,
                  //             messages[index],
                  //           ),
                  //       child: ReplyCard(
                  //         message: messages[index].message,
                  //         time: messages[index].time,
                  //       ),
                  //     );
                  //   }
                  // }
                  final message = messages[index];
                  final isSource = message.type == "source";
                  final hasImage = message.path.isNotEmpty;

                  Widget messageWidget;

                  if (isSource) {
                    messageWidget = hasImage
                        ? OwnImageCard(
                      path: [message.path],
                      time: message.time,
                    )
                        : OwnMessageCard(
                      message: message.message,
                      time: message.time,
                    );
                  } else {
                    messageWidget = hasImage
                        ? ReplyImageCard(
                      path: [message.path],
                      time: message.time,
                    )
                        : ReplyCard(
                      message: message.message,
                      time: message.time,
                    );
                  }

                  return GestureDetector(
                    onLongPress: () => _showMessageOptionsDialog(context, message),
                    child: messageWidget,
                  );
                },
              ),
            ),
            // Thanh nhập tin nhắn
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: Colors.white,
              child: Row(
                children: [
                  if (ImagePath.isEmpty) ...[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          ControllerNewMessage();
                          ShowEmoji = !ShowEmoji;
                          IsLoadImages = false;
                          if (ShowEmoji) {
                            _focusNode.unfocus();
                          } else {
                            _focusNode.requestFocus();
                          }
                        });
                      },
                      icon: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        focusNode: _focusNode,
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (value) {
                          if (value.length > 0) {
                            setState(() {
                              SentButton = true;
                            });
                          } else {
                            setState(() {
                              SentButton = false;
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Tin nhắn",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 16),
                        onTap: () {
                          setState(() {
                            ShowEmoji = false;
                            IsLoadImages = false;
                          });
                        },
                      ),
                    ),
                  ] else ...[
                    Expanded(child: Row()),
                  ],
                  if (CheckValueInput ||
                      ImagePath.length > 0 ||
                      selectedImagesFromSheet.length > 0)
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: () async {
                        if (selectedImagesFromSheet.isNotEmpty) {
                          List<String> serverPaths = await sendImageSend(
                            selectedImagesFromSheet,
                          );
                          for (String serverPath in serverPaths) {
                            sendMessage(
                              "",
                              widget.currentUserId,
                              widget.receiverId,
                              serverPath,
                            );
                          }
                        }

                        if (_controller.text.trim().isNotEmpty) {
                          sendMessage(
                            _controller.text.trim(),
                            widget.currentUserId,
                            widget.receiverId,
                            "",
                          );
                        }
                        setState(() {
                          _controller.clear();
                          selectedImagesFromSheet.clear();
                          ImagePath.clear();
                          selectedFileName = null;
                          CheckValueInput = false;
                          SentButton = false;
                          IsLoadImages = false;
                          IsLoadFiles = false;
                        });

                        ControllerNewMessage();
                      },
                    )
                  else ...[
                    IconButton(
                      icon: const Icon(Icons.mic_outlined, color: Colors.grey),
                      onPressed: () {
                        // Ghi âm
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.file_copy, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          ShowEmoji = false;
                          IsLoadFiles = !IsLoadFiles;
                          _focusNode.unfocus();
                        });
                        pickImageFromGallery();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.image, color: Colors.orange),
                      onPressed: () async {
                        await LoadAllImages();
                        setState(() {
                          ControllerNewMessage();
                          ShowEmoji = false;
                          IsLoadImages = !IsLoadImages;
                          _focusNode.unfocus();
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
            // Emoji picker
            if (ShowEmoji) emojiSelect(),
            if (IsLoadImages)
              Imagepickersheet(
                allImages: allImages,
                onImageSelectionChanged: (
                  List<AssetEntity> selectedImages,
                ) async {
                  setState(() {
                    selectedImagesFromSheet = selectedImages;
                  });
                  List<File?> files = await Future.wait(
                    selectedImages.map((e) => e.file),
                  );
                  List<String> paths =
                      files.whereType<File>().map((file) => file.path).toList();
                  print("Đã chọn ${paths.length} ảnh với đường dẫn:");
                  for (var path in paths) {
                    print(path);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        setState(() {
          _controller.text += emoji.emoji;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
        });
      },
    );
  }
}
