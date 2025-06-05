import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/features/user/screens/AddFriendScreen.dart';
import 'package:nhan_tin_noi_bo/features/auth/screens/SignIn.dart';
import 'package:realm/realm.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../core/utils/connection.dart';
import '../../../data/model/assets.dart';
import '../../../data/model/chatmodel.dart';
import '../../../data/realm/realm_models/models.dart';
import '../../../data/realm/realm_services/realm.dart';
import '../../chat/screens/CreateGroupPages.dart';
import '../../chat/screens/IndividualPage.dart';
import '../../chat/widgets/CustomCard.dart';

class SearchGrouporfriendScreen extends StatefulWidget {
  final NguoiDung currentUser;
  final IO.Socket socket;
  const SearchGrouporfriendScreen({super.key, required this.currentUser, required this.socket,});

  @override
  State<SearchGrouporfriendScreen> createState() => _SearchGrouporfriendScreenState();
}

class _SearchGrouporfriendScreenState extends State<SearchGrouporfriendScreen> {
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  late Realm realm;
  List<ChatModel> chats = [];
  List<KetBan> danhSachKetBan = [];
  List<NguoiDung> danhSachBanBe = [];
  List<NguoiDung> filteredUsers = [];
  late ObjectId currentUserId;
  @override
  void initState() {
    super.initState();
    realm = RealmService().realm;

    final ObjectId currentUserId = widget.currentUser.maNguoiDung;
    danhSachKetBan = realm.all<KetBan>().where((ketBan) =>
    ketBan.trangThai == 'accepted' &&
        (ketBan.nguoiGui?.maNguoiDung == widget.currentUser.maNguoiDung ||
            ketBan.nguoiNhan?.maNguoiDung == widget.currentUser.maNguoiDung)
    ).toList();

    danhSachBanBe = danhSachKetBan.map((ketBan) {
      if (ketBan.nguoiGui?.maNguoiDung == currentUserId) {
        return ketBan.nguoiNhan!;
      } else {
        return ketBan.nguoiGui!;
      }
    }).toList();
    // filteredUsers = List.from(danhSachBanBe);
    filteredUsers = [];

    chats = danhSachBanBe.map((nguoiDung) {
      String avatarCheck = nguoiDung.anhDaiDien == null ? nguoiDung.hoTen!.substring(0, 1).toUpperCase() : nguoiDung.anhDaiDien!;
      return ChatModel(
        name: nguoiDung.hoTen!,
        avatar: avatarCheck, // Có thể thay bằng ảnh đại diện thật nếu có
        isGroup: false,
        time: "", // Có thể cập nhật thời gian tin nhắn cuối cùng nếu cần
        currentMessage: "", // Có thể cập nhật tin nhắn cuối cùng nếu cần
        id: nguoiDung.maNguoiDung, // Có thể lấy id phù hợp nếu cần
      );
    }).toList();

    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() async {
    String keyword = searchController.text.trim().toLowerCase();

    setState(() {
      isLoading = true;
    });
    // await Future.delayed(Duration(milliseconds: 500));
    Future.delayed(Duration(milliseconds: 300), () {
      final List<NguoiDung> results = keyword.isEmpty
          ? []
          : danhSachBanBe.where((nguoiDung) {
        final name = nguoiDung.hoTen?.toLowerCase() ?? "";
        final phone = nguoiDung.tenDangNhap ?? "";
        return name.contains(keyword) || phone.contains(keyword);
      }).toList();

      setState(() {
        filteredUsers = results;
        isLoading = false;
      });
    });
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbarBG,
        title: Container(
          padding: EdgeInsets.only(left: 7, right: 7),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm',
              icon: Icon(Icons.search, color: Colors.grey,),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
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
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddFriendScreen(currentUser: widget.currentUser, socket: widget.socket,)),
                );
              },
              icon: Icon(Icons.person_add_alt_1, color: Colors.white,)
          ),
          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateGroupPages(currentUserId:currentUserId, socket: widget.socket,)),
                );
              },
              icon: Icon(Icons.group_add, color: Colors.white,)
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            isLoading
                ? Padding(padding: EdgeInsets.only(top: 15), child: Center(child: CircularProgressIndicator(),),)
                : Expanded(
              child: filteredUsers.isEmpty
                  ? Center(child: Text('Không có kết quả'))
                  : ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text(user.hoTen ?? ""),
                    subtitle: Text(user.tenDangNhap ?? ""),
                    trailing: IconButton(
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Individualpage(
                                chatModel: chats[index],
                                sourchat: chats[index],
                                currentUserId: widget.currentUser.maNguoiDung,
                                receiverId: user.maNguoiDung,
                                socket: widget.socket,
                              )));
                        },
                        icon: Icon(Icons.chat_bubble_outline_rounded)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Individualpage(
                            chatModel: chats[index],
                            sourchat: chats[index],
                            currentUserId: widget.currentUser.maNguoiDung,
                            receiverId: user.maNguoiDung,
                            socket: widget.socket,
                          ),)
                      );
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
