import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nhan_tin_noi_bo/features/user/screens/AddFriendScreen.dart';
import 'package:nhan_tin_noi_bo/features/user/screens/SearchScreen.dart';
import 'package:realm/realm.dart';

import '../../../core/utils/connection.dart';
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

class _DsTinnhanState extends State<Home_Screen> {
  int _currentIndex = 0;
  List<ChatModel> chats = [];
  bool _isSocketConnected = false;
  late IO.Socket socketConnect;

  @override
  void initState() {
    super.initState();

    final ObjectId currentUserId = widget.currentUser.maNguoiDung;
    final socketService = SocketService();
    final Realm realm = RealmService().realm;
    socketConnect = socketService.connect(currentUserId);
    var danhSachKetBan = realm.all<KetBan>().where((ketBan) =>
    ketBan.trangThai == 'accepted' &&
        (ketBan.nguoiGui?.maNguoiDung == currentUserId ||
            ketBan.nguoiNhan?.maNguoiDung == currentUserId)
    ).toList();

    var danhSachBanBe = danhSachKetBan.map((ketBan) {
      if (ketBan.nguoiGui?.maNguoiDung == currentUserId) {
        return ketBan.nguoiNhan!;
      } else {
        return ketBan.nguoiGui!;
      }
    }).toList();
    print('Số lượng bạn bè đã kết bạn: ${danhSachBanBe.length}');
    chats = danhSachBanBe.map((nguoiDung) {
      return ChatModel(
        name: nguoiDung.hoTen!,
        avatar: "assets/images/meme.jpg",
        // Có thể thay bằng ảnh đại diện thật nếu có
        isGroup: false,
        time: "",
        // Có thể cập nhật thời gian tin nhắn cuối cùng nếu cần
        currentMessage: "",
        // Có thể cập nhật tin nhắn cuối cùng nếu cần
        id: nguoiDung.maNguoiDung, // Có thể lấy id phù hợp nếu cần
      );
    }).toList();

    socketConnect.onConnect((_) {
      print("✅ Socket connected");
      if (mounted) {
        setState(() {
          _isSocketConnected = true;
        });
      }
    });

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
      ),
      FriendsListScreen(currentUser: widget.currentUser,)
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbarBG,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchGrouporfriendScreen()),
              );
            },
            icon: Icon(Icons.search, color: AppColors.bodyBG,)
        ),
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchGrouporfriendScreen()),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddFriendScreen()));
              } else if (value == "create_group") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupPages()));
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
