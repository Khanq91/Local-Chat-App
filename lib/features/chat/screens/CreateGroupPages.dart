import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/model/User.dart';
import '../../../data/model/assets.dart';

class CreateGroupPages extends StatefulWidget {
  const CreateGroupPages({super.key});

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

  File? groupAvatar;
  String? _assetAvatar;

  List<User> users = [
    User(
      name: 'Trần Tiến',
      time: '1 phút trước',
      avatar: 'assets/images/meme.jpg',
    ),
    User(name: 'Nhi', time: '31 phút trước', avatar: 'assets/images/meme.jpg'),
    User(
      name: 'Văn Liêm',
      time: '1 giờ trước',
      avatar: 'assets/images/meme.jpg',
    ),
    User(
      name: 'Hải Nam',
      time: '1 giờ trước',
      avatar: 'assets/images/meme.jpg',
    ),
    User(
      name: 'Thành Trần',
      time: '2 giờ trước',
      avatar: 'assets/images/meme.jpg',
    ),
    User(name: 'Huy', time: '2 giờ trước', avatar: 'assets/images/meme.jpg'),
    User(
      name: 'Nhật Nguyễn',
      time: '2 giờ trước',
      avatar: 'assets/images/meme.jpg',
    ),
    User(name: 'Khang', time: '3 giờ trước', avatar: 'assets/images/meme.jpg'),
    User(name: 'Xuân', time: '3 giờ trước', avatar: 'assets/images/meme.jpg'),
  ];

  List<User> friends = [
    User(name: 'Bình', time: '3 ngày trước', avatar: 'assets/images/meme.jpg'),
    User(
      name: 'Anh Tuấn',
      time: '2 ngày trước',
      avatar: 'assets/images/meme.jpg',
    ),
    User(
      name: 'Hải Nam',
      time: '1 giờ trước',
      avatar: 'assets/images/meme.jpg',
    ),
    User(name: 'Cường', time: '1 tuần trước', avatar: 'assets/images/meme.jpg'),
    User(name: 'Dũng', time: '1 tháng trước', avatar: 'assets/images/meme.jpg'),
    User(
      name: 'Văn Liêm',
      time: '1 giờ trước',
      avatar: 'assets/images/meme.jpg',
    ),
  ];

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
              Text("Chọn ảnh nhóm", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),

              // Hàng hiển thị các ảnh mặc định
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    // String assetPath = 'assets/default_avatars/group_${index + 1}.png';
                    String assetPath = '${AppImages.baseAvatarPath}group_${index + 1}.png';
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
                            fit: BoxFit.contain, // hoặc try BoxFit.fitWidth nếu ảnh cân
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
  void initState() {
    super.initState();
    friends.sort(
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentList = _isRecentTab ? users : friends;

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
                      backgroundImage: groupAvatar != null
                          ? FileImage(groupAvatar!)
                          : _assetAvatar != null
                          ? AssetImage(_assetAvatar!) as ImageProvider
                          : null,
                      child: (groupAvatar == null && _assetAvatar == null)
                          ? Icon(Icons.camera_alt, color: Colors.grey[300])
                          : null,
                    ),
                  ),

                  SizedBox(width: 18,),

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
                  )
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
                isNumericKeyboard ? TextInputType.number : TextInputType.text,
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
                          "GẦN ĐÂY",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight:
                            _isRecentTab
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        color: _isRecentTab ? Colors.blue : Colors.transparent,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isRecentTab = false;
                          });
                        },
                        child: Text(
                          "DANH BẠ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight:
                            _isRecentTab
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        color: !_isRecentTab ? Colors.blue : Colors.transparent,
                      ),
                    ],
                  ),
                ),
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
                        // TODO: Tạo nhóm tại đây
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
      )
    );
  }
}
