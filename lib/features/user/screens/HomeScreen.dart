import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nhan_tin_noi_bo/features/user/screens/AddFriendScreen.dart';
import 'package:nhan_tin_noi_bo/features/user/screens/SearchScreen.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import '../../../core/utils/connection.dart';
import '../../../core/utils/FriendsStatusProvider.dart';
import '../../../data/model/assets.dart';
import '../../../data/model/chatmodel.dart';
import '../../../data/realm/realm_models/models.dart';
import '../../../data/realm/realm_services/realm.dart';
import '../../chat/NotificationServiceManager.dart';
import '../../chat/screens/CreateGroupPages.dart';
import '../../chat/screens/ChatPages.dart';
import 'FriendsListScreen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Home_Screen extends StatefulWidget {
  final NguoiDung currentUser;
  const Home_Screen({super.key, required this.currentUser});

  @override
  State<Home_Screen> createState() => _DsTinnhanState();
}

// class _DsTinnhanState extends State<Home_Screen> {
class _DsTinnhanState extends State<Home_Screen> with WidgetsBindingObserver {
  int _currentIndex = 0;
  List<ChatModel> chats = [];
  bool _isSocketConnected = false;
  late IO.Socket socketConnect;

  void updateChatsWithNewMessage(ObjectId sourceID, String newMessage) {
    final ObjectId sourceId = sourceID;
    final int index = chats.indexWhere((chat) => chat.id == sourceId);
    if (index != -1) {
      final updatedChat = ChatModel(
        name: chats[index].name,
        avatar: chats[index].avatar,
        isGroup: chats[index].isGroup,
        time: DateTime.now().toString(),
        currentMessage: newMessage,
        id: chats[index].id,
      );

      setState(() {
        chats[index] = updatedChat;
      });
    } else {
    }
  }
  void reloadData() {
    // Load lại dữ liệu nếu cần
    print("💥 HomeScreen đang được rebuild...");
    loads();
    setState(() {});
  }

  void loads() {
    final ObjectId currentUserId = widget.currentUser.maNguoiDung;
    final socketService = SocketService();
    final Realm realm = RealmService().realm;
    var danhSachKetBan = realm.all<KetBan>().where((ketBan) =>
    ketBan.trangThai == 'accepted' &&
        (ketBan.nguoiGui?.maNguoiDung == currentUserId || ketBan.nguoiNhan?.maNguoiDung == currentUserId)
    ).toList();

    final ObjectId maNguoiNhan;

    var danhSachBanBe = danhSachKetBan.map((ketBan) {
      if (ketBan.nguoiGui?.maNguoiDung == currentUserId) {
        return ketBan.nguoiNhan!;
      } else {
        return ketBan.nguoiGui!;
      }
    }).toList();
    print('Số lượng bạn bè đã kết bạn: ${danhSachBanBe.length}');

    chats = danhSachBanBe.map((nguoiDung) {
      final tinNhanMoiNhat = realm
          .all<TinNhanCaNhan>()
          .query(
          '((maNguoiGui == \$0 AND maNguoiNhan == \$1) OR (maNguoiGui == \$1 AND maNguoiNhan == \$0)) SORT(thoiGianGui DESC)',
          [currentUserId, nguoiDung.maNguoiDung]
      ).firstOrNull;
      String noiDungHienThi = "";
      if (tinNhanMoiNhat == null) {
        noiDungHienThi = "";
      } else {
        noiDungHienThi = tinNhanMoiNhat.noiDung;
      }
      return ChatModel(
        name: nguoiDung.hoTen!,
        avatar: "assets/images/meme.jpg", // Có thể thay bằng ảnh đại diện thật nếu có
        isGroup: false,
        time: "", // Có thể cập nhật thời gian tin nhắn cuối cùng nếu cần
        currentMessage: noiDungHienThi, // Có thể cập nhật tin nhắn cuối cùng nếu cần
        id: nguoiDung.maNguoiDung, // Có thể lấy id phù hợp nếu cần
      );
    }).toList();
  }


  @override
  void initState() {
    super.initState();
    final ObjectId currentUserId = widget.currentUser.maNguoiDung;
    final Realm realm = RealmService().realm;
    // final socketService = SocketService();
    // socketConnect = socketService.connect(currentUserId);
    // final socketService = Provider.of<SocketService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketConnect = socketService.socket;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      // Có thể làm gì đó nếu cần, ví dụ in trạng thái kết nối:
      print('SocketService đã khởi tạo: ${socketService.socket.connected}');
    });

    loads();
    if(_isSocketConnected == false) {
      socketConnect.onConnect((_) {
        print("✅ Socket connected");
        if (mounted) {
          setState(() {
            _isSocketConnected = true;
          });
        }
        socketConnect.emit("capNhatTrangThai", {
          "userId": widget.currentUser.maNguoiDung,
          "trangThai": true,
        });
      });
    }

    socketConnect.onDisconnect((_) {
      print("❌ Socket disconnected");
      if (mounted) {
        setState(() {
          _isSocketConnected = false;
        });
      }
    });
    socketConnect.on("message", (msg) {
      if (msg["targetId"] == currentUserId.toString()) {
        final sourceId = ObjectId.fromHexString(msg["sourceId"]);
        String newMessage = msg["message"] ?? "";
        updateChatsWithNewMessage(sourceId, newMessage);

        final nguoiGui = realm
            .all<NguoiDung>()
            .query("maNguoiDung == \$0", [sourceId])
            .firstOrNull
            ?.hoTen ?? "Người lạ";
        NotificationDetails details = NotificationServiceManager()
            .getNotificationDetail(
          channelId: "hoc hoc",
          channelName: "Day la test",
        );
        String mess = '';
        String path = msg["path"] ?? "";
        String rawMessage = msg["message"] ?? "";

        if (rawMessage.isNotEmpty && path.isEmpty) {
          mess = rawMessage; // Văn bản thuần
        } else if (rawMessage.isEmpty && path.isNotEmpty) {
          // Xác định loại file từ path
          final lowerPath = path.toLowerCase();
          if (lowerPath.endsWith(".jpg") || lowerPath.endsWith(".jpeg") ||
              lowerPath.endsWith(".png") || lowerPath.endsWith(".gif")) {
            mess = "[📷 Hình ảnh đã gửi]";
          } else
          if (lowerPath.endsWith(".pdf") || lowerPath.endsWith(".docx") ||
              lowerPath.endsWith(".zip") || lowerPath.endsWith(".xlsx")) {
            mess = "[📎 Tệp tin đã gửi]";
          } else {
            mess = "[📁 Nội dung đã gửi]";
          }
        } else if (rawMessage.isNotEmpty && path.isNotEmpty) {
          // Tin nhắn có cả văn bản và tệp
          mess = "$rawMessage + đính kèm tệp";
        } else {
          mess = "[🔔 Tin nhắn mới]";
        }

        NotificationServiceManager().show(
            title: nguoiGui,
            body: mess,
            notificationDetails: details);
      }
    });
    socketConnect.on("capNhatTrangThai", (data) {
      final userId = ObjectId.fromHexString(data["userId"]);
      final status = data["trangThai"] == true;

      final provider = Provider.of<FriendsProvider>(context, listen: false);
      provider.updateOnlineStatus(userId, status);
      // UserService().capNhatTrangThai(userId, status);
      setState(() {}); // Cập nhật UI nếu cần
    });

    setState(() {});

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // disconnectTimer?.cancel();
    socketConnect.emit("capNhatTrangThai", {
      "userId": widget.currentUser.maNguoiDung,
      "trangThai": false,
    });
    socketConnect.off("capNhatTrangThai");

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
        socketConnect.emit("capNhatTrangThai", {
          "userId": widget.currentUser.maNguoiDung,
          "trangThai": false,
        });
      // });
    } else if (state == AppLifecycleState.resumed) {
      // disconnectTimer?.cancel();
      socketConnect.emit("capNhatTrangThai", {
        "userId": widget.currentUser.maNguoiDung,
        "trangThai": true,
      });
    }
  }

  void _onLoginSuccess(NguoiDung user, IO.Socket socket) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => FriendsProvider(
                currentUser: user,
                realm: RealmService().realm,
              ),
            ),
          ],
          child: FriendsListScreen(currentUser: user, socket: socket),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final ObjectId currentUserId = widget.currentUser.maNguoiDung;

    if (!_isSocketConnected) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final List<Widget> _screens = [
      Chatpages(
        chats: chats,
        currentUserId:currentUserId,
        socket: socketConnect,
        onReturnFromChat: reloadData,
      ),
      FriendsListScreen(currentUser: widget.currentUser, socket: socketConnect)
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbarBG,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchGrouporfriendScreen(currentUser: widget.currentUser, socket: socketConnect,)),
              );
            },
            icon: Icon(Icons.search, color: AppColors.bodyBG,)
        ),
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchGrouporfriendScreen(currentUser: widget.currentUser, socket: socketConnect,)),
            );
          },
          child: Text(
            "Tìm kiếm",
            style: TextStyle(
                fontSize: 19,
                color: AppColors.bodyBG
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.add, color: Colors.white),
            onSelected: (value) {
              if (value == "add_friend") {
                print("add_friend");
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddFriendScreen(currentUser: widget.currentUser, socket: socketConnect,)));
              } else if (value == "create_group") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupPages(currentUserId:currentUserId,  socket: socketConnect,)));
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: "add_friend",
                child: Row(
                  children: [
                    Icon(Icons.person_outline, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Thêm bạn"),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: "create_group",
                child: Row(
                  children: [
                    Icon(Icons.group_add_outlined, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Tạo nhóm"),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      // body: _screens[_currentIndex],
      body: !_isSocketConnected
          ? const Center(child: CircularProgressIndicator())
          : _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Tin nhắn"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page_rounded),
              label: "Danh bạ"
          ),
        ],
      ),
    );
  }
}
