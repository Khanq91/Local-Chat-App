import 'package:flutter/material.dart';

import '../../../data/model/assets.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> allUsers = [
    {"name": "Khang Dương", "phone": "0787933111"},
    {"name": "Cẩm Duyên", "phone": "0703158111"},
    {"name": "Tuấn Trần", "phone": "0939123456"},
    {"name": "Mai Phương", "phone": "0971122334"},
  ];
  List<Map<String, String>> filteredUsers = [];
  void searchUser() {
    String keyword = searchController.text.trim();
    if (keyword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng nhập tên hoặc số điện thoại!')),
      );
      return;
    }
    keyword = searchController.text.trim().toLowerCase();
    setState(() {
      filteredUsers = allUsers.where((user) {
        final name = user["name"]!.toLowerCase();
        final phone = user["phone"]!;
        return name.contains(keyword) || phone.contains(keyword);
      }).toList();
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
                  return ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text(user["name"] ?? ""),
                    subtitle: Text(user["phone"] ?? ""),
                    trailing: IconButton(
                      onPressed: (){
                        // TODO: Gửi lời mời kết bạn...
                      },
                    icon: Icon(Icons.add)),
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
