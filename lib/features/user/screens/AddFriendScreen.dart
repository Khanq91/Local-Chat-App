import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/core/utils/firstWhereOrNull.dart';
import 'package:realm/realm.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../data/model/assets.dart';
import '../../../data/model/chatmodel.dart';
import '../../../data/realm/realm_models/models.dart';
import '../../../data/realm/realm_services/realm.dart';
import '../../chat/screens/IndividualPage.dart';

class AddFriendScreen extends StatefulWidget {
  final NguoiDung currentUser;
  final IO.Socket socket;
  const AddFriendScreen({super.key, required this.currentUser, required this.socket,});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  TextEditingController searchController = TextEditingController();
  late Realm realm;
  List<NguoiDung> filteredUsers = [];
  List<ChatModel> chats = [];

  KetBan? checkKetBan(NguoiDung currentUser, NguoiDung otherUser) {
    final allRequests = realm.all<KetBan>();
    return allRequests.firstWhereOrNull((k) =>
    ((k.maNguoiGui == currentUser.maNguoiDung && k.maNguoiNhan == otherUser.maNguoiDung) ||
        (k.maNguoiNhan == currentUser.maNguoiDung && k.maNguoiGui == otherUser.maNguoiDung))
    );
  }

  void searchUser() {
    final keyword = searchController.text.trim().toLowerCase();

    if (keyword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng nhập số điện thoại hoặc họ tên!')),
      );
      return;
    }

    final results = realm.all<NguoiDung>().where((nguoiDung) {
      if (nguoiDung.maNguoiDung == widget.currentUser.maNguoiDung) return false;
      final hoTen = nguoiDung.hoTen?.toLowerCase() ?? "";
      final tenDangNhap = nguoiDung.tenDangNhap.toLowerCase();
      return hoTen.contains(keyword) || tenDangNhap.contains(keyword);
    }).toList();

    setState(() {
      filteredUsers = results;
    });
  }

  void guiLoiMoiKetBan(NguoiDung currentUser, NguoiDung targetUser) {
    realm.write(() {
      final newRequest = KetBan(
        ObjectId(),
        currentUser.maNguoiDung,
        targetUser.maNguoiDung,
          'pending',
        DateTime.now()
      )
        ..nguoiGui = currentUser
        ..nguoiNhan = targetUser
        ..maNguoiGui = currentUser.maNguoiDung
        ..maNguoiNhan = targetUser.maNguoiDung
        ..trangThai = 'pending'
        ..ngayTao = DateTime.now();

      realm.add(newRequest);
    });

    widget.socket.emit("loiMoiKetBan", {
      "maNguoiGui": currentUser.maNguoiDung.toString(),
      "maNguoiNhan": targetUser.maNguoiDung.toString(),
      "trangThai": "pending",
      "ngayTao": DateTime.now().toIso8601String(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("📨 Đã gửi lời mời kết bạn!")),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    realm = RealmService().realm;

    widget.socket.on("nhanLoiMoiKetBan", (data) {
      print("📩 Nhận lời mời kết bạn từ: ${data["maNguoiGui"]}");

      // TODO: Bạn có thể hiển thị snackbar, badge thông báo, hoặc load lại UI
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbarBG,
        title: Text(
          "Thêm bạn",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => LoginScreen()),
            // );
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(flex: 2, child: Icon(Icons.person_add_alt_1)),
                Expanded(
                  flex: 11,
                  child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Nhập tên hoặc số điện thoại",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )),
                Expanded(flex: 2, child: IconButton(onPressed: searchUser, icon: Icon(Icons.arrow_forward))),
              ],
            ),
            Expanded(
              child: filteredUsers.isEmpty
                  ? Center(child: Text('Không có kết quả'))
                  : ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  final friendStatus = checkKetBan(widget.currentUser, user);
                  String statusLabel;
                  IconData statusIcon;
                  Color statusColor;
                  if (friendStatus == null) {
                    statusLabel = "Kết bạn";
                    statusIcon = Icons.person_add;
                    statusColor = Colors.blue;
                  } else if (friendStatus.trangThai == 'pending') {
                    statusLabel = "Đã gửi lời mời";
                    statusIcon = Icons.hourglass_top;
                    statusColor = Colors.orange;
                  } else if (friendStatus.trangThai == 'accepted') {
                    statusLabel = "Đã là bạn";
                    statusIcon = Icons.check_circle;
                    statusColor = Colors.green;
                  } else {
                    statusLabel = "Từ chối"; // optional
                    statusIcon = Icons.block;
                    statusColor = Colors.red;
                  }

                  return ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text(user.hoTen ?? ""),
                    subtitle: Text(user.tenDangNhap ?? ""),
                    trailing: IconButton(
                      onPressed: (){
                        // TODO: Gửi lời mời kết bạn...
                        if(friendStatus == null) {
                          guiLoiMoiKetBan(widget.currentUser, user);
                        } else if(friendStatus.trangThai == 'pending'){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Đã gửi lời mời kết bạn rồi!")),
                          );
                        } else if(friendStatus.trangThai == 'accepted'){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Các bạn đã là bạn bè!")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Bạn đã bị chặn!")),
                          );
                        }
                      },
                    icon: Icon(statusIcon, color: statusColor,)),
                    onTap: () {
                      // TODO: Mở hồ sơ bạn bè
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
