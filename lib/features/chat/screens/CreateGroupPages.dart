import 'dart:io';
import 'dart:io' as IO;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realm/realm.dart';

import '../../../data/model/User.dart';
import '../../../data/model/assets.dart';
import '../../../data/realm/realm_models/models.dart';
import '../../../data/realm/realm_services/realm.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'Grouppage.dart';

class CreateGroupPages extends StatefulWidget {
  const CreateGroupPages({super.key, required this.currentUserId, required this.socket,});
  final ObjectId currentUserId;
  final IO.Socket socket;
  @override
  State<CreateGroupPages> createState() => _CreateGroupPagesState();
}

class _CreateGroupPagesState extends State<CreateGroupPages> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isRecentTab = true;
  bool isNumericKeyboard = false;

  Set<User> selectedUsers = {};
  List<String> selectedFriends = [];
  List<String> filteredFriends = [];
  List<User> danhSachUser = [];
  late List<String> AddtoGroupID_ToString=[];
  File? groupAvatar;
  String? _assetAvatar;
  List<ObjectId> AddToGroupId = [];
  late String NamePage="";
  final Realm realm = RealmService().realm;

  void _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        groupAvatar = File(picked.path);
        _assetAvatar = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    AddToGroupId.add(widget.currentUserId);
    List<KetBan> Ds_KetBan =
    realm
        .all<KetBan>()
        .where(
          (ketBan) =>
      ketBan.trangThai == 'accepted' &&
          (ketBan.nguoiGui?.maNguoiDung == widget.currentUserId ||
              ketBan.nguoiNhan?.maNguoiDung == widget.currentUserId),
    ).toList();
    danhSachUser =
      Ds_KetBan.map((ketBan) {
        final isNguoiGui =
            ketBan.nguoiGui?.maNguoiDung == widget.currentUserId;
        final otherUser = isNguoiGui ? ketBan.nguoiNhan : ketBan.nguoiGui;
        ObjectId id = isNguoiGui ? ketBan.maNguoiNhan : ketBan.maNguoiGui;
        return User(
          maNguoiDung: id,
          name: otherUser?.hoTen ?? 'Không tên',
          time:
          '1 phút trước', // Tuỳ Khai muốn xử lý thời gian hay để cố định
          avatar: otherUser?.anhDaiDien ?? 'assets/images/con-meo-3.jpg',
        );
      }
    ).toList();
  }

  void CheckNameGroup(){
    if(_groupNameController.text.trim().isNotEmpty){
      NamePage=_groupNameController.text.trim();
    }
    else {
      List<String> memberNames = selectedUsers.map((user) => user.name).toList();
      NamePage = memberNames.take(3).join(", ");
      if (selectedUsers.length > 3) {
        NamePage += ", ${selectedUsers.length - 3} người khác";
      }
    }
  }

  void _showAvatarPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chọn ảnh nhóm",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),

              // Hàng hiển thị các ảnh mặc định
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    String assetPath =
                        '${AppImages.baseAvatarPath}group_${index + 1}.png';
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          groupAvatar = null;
                          _assetAvatar = assetPath;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: ClipOval(
                          child: Image.asset(
                            assetPath,
                            width: 50,
                            height: 50,
                            fit:
                            BoxFit
                                .contain, // hoặc try BoxFit.fitWidth nếu ảnh cân
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Spacer(),

              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage();
                  },
                  icon: Icon(Icons.photo),
                  label: Text("Chọn từ thư viện"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentList = danhSachUser;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nhóm mới",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Đã chọn: ${selectedUsers.length}",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.bodyBG,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Container(
        color: AppColors.bodyBG,
        child: Column(
          children: [
            // Tên nhóm

            // Padding(
            //   padding: EdgeInsets.all(12),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 12),
            //     decoration: BoxDecoration(
            //       color: Colors.grey[200],
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: Row(
            //       children: [
            //         Icon(Icons.camera_alt_outlined, size: 24, color: Colors.grey),
            //         SizedBox(width: 12),
            //         Expanded(
            //           child: TextField(
            //             controller: _groupNameController,
            //             decoration: InputDecoration(
            //               hintText: "Đặt tên nhóm",
            //               border: InputBorder.none,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            //Tên nhóm
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _showAvatarPicker(context),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: AppColors.bodyBG,
                      backgroundImage:
                      groupAvatar != null
                          ? FileImage(groupAvatar!)
                          : _assetAvatar != null
                          ? AssetImage(_assetAvatar!) as ImageProvider
                          : null,
                      child:
                      (groupAvatar == null && _assetAvatar == null)
                          ? Icon(Icons.camera_alt, color: Colors.grey[300])
                          : null,
                    ),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: TextField(
                      controller: _groupNameController,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(color: Colors.grey),
                        labelText: "Tên nhóm",
                        labelStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tìm kiếm
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                keyboardType:
                isNumericKeyboard
                    ? TextInputType.number
                    : TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Tìm tên hoặc số điện thoại",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isNumericKeyboard = !isNumericKeyboard;
                      });
                      _searchFocusNode.unfocus();
                      Future.delayed(Duration(milliseconds: 100), () {
                        FocusScope.of(context).requestFocus(_searchFocusNode);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 12),
                      child: Text(
                        isNumericKeyboard ? "ABC" : "123",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Tabs
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isRecentTab = true;
                          });
                        },
                        child: Text(
                          "DANH BẠ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight:
                            _isRecentTab
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 2,
                      //   color: _isRecentTab ? Colors.blue : Colors.transparent,
                      // ),
                    ],
                  ),
                ),
                // Expanded(
                //   child: Column(
                //     children: [
                //       TextButton(
                //         onPressed: () {
                //           setState(() {
                //             _isRecentTab = false;
                //           });
                //         },
                //         child: Text(
                //           "DANH BẠ",
                //           style: TextStyle(
                //             color: Colors.black54,
                //             fontWeight:
                //             _isRecentTab
                //                 ? FontWeight.normal
                //                 : FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //       Container(
                //         height: 2,
                //         color: !_isRecentTab ? Colors.blue : Colors.transparent,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            // Danh sách người dùng
            Expanded(
              child: ListView.builder(
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  final user = currentList[index];
                  final isSelected = selectedUsers.contains(user);
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      child: ClipOval(
                        child: Image.asset(
                          user.avatar,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.time),
                    trailing: Icon(
                      isSelected
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: isSelected ? Colors.blue : Colors.grey,
                    ),
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedUsers.remove(user);
                        } else {
                          selectedUsers.add(user);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            // Danh sách người đã chọn
            if (selectedUsers.isNotEmpty)
              Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: Offset(0, -2),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedUsers.length,
                        itemBuilder: (context, i) {
                          final user = selectedUsers.elementAt(i);
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: Image.asset(
                                      user.avatar,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedUsers.remove(user);
                                      });
                                    },
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.black54,
                                        child: Icon(
                                          Icons.close,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        CheckNameGroup();
                        if (selectedUsers.length < 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Vui lòng chọn ít nhất 2 thành viên"))
                          );
                          return;
                        }
                        NhomChat nhomChat = NhomChat(ObjectId(), NamePage, false, DateTime.now(),widget.currentUserId,);
                        final receiverIds = selectedUsers.map((u) => u.maNguoiDung.toString()).toList();
                        realm.write(() {realm.add(nhomChat);
                          for (var user in selectedUsers) {
                            final nguoiDung = realm.find<NguoiDung>(user.maNguoiDung);
                            if (nguoiDung != null) {
                              final isAdmin = user.maNguoiDung == widget.currentUserId;
                              final tv = ThanhVienNhom(ObjectId(), isAdmin, DateTime.now());
                              tv.nhom = nhomChat;
                              tv.thanhVien = nguoiDung;
                              realm.add(tv);
                            }
                          }
                          final nguoiTao = realm.find<NguoiDung>(widget.currentUserId);
                          if (nguoiTao != null) {
                            final tvTao = ThanhVienNhom(ObjectId(), true, DateTime.now());
                            tvTao.nhom = nhomChat;
                            tvTao.thanhVien = nguoiTao;
                            realm.add(tvTao);
                          }
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => Grouppage(currentUserId: widget.currentUserId, receiverId_ToString: receiverIds, socket: widget.socket, manhom: nhomChat.maNhom,
                            ),
                          ),
                        );
                      },
                      mini: true,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
