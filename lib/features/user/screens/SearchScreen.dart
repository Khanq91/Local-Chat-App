import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/features/user/screens/AddFriendScreen.dart';
import 'package:nhan_tin_noi_bo/features/auth/screens/SignIn.dart';

import '../../../data/model/assets.dart';
import '../../chat/screens/CreateGroupPages.dart';

class SearchGrouporfriendScreen extends StatefulWidget {
  const SearchGrouporfriendScreen({super.key});

  @override
  State<SearchGrouporfriendScreen> createState() => _SearchGrouporfriendScreenState();
}

class _SearchGrouporfriendScreenState extends State<SearchGrouporfriendScreen> {
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> allUsers = [
    {"name": "Khang Dương", "phone": "0787933111"},
    {"name": "Cẩm Duyên", "phone": "0703158111"},
    {"name": "Tuấn Trần", "phone": "0939123456"},
    {"name": "Mai Phương", "phone": "0971122334"},
  ];
  List<Map<String, String>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = [];

    searchController.addListener(_onSearchChanged);

  }

  void _onSearchChanged() async {
    String keyword = searchController.text.trim().toLowerCase();

    setState(() {
      isLoading = true;
    });

    // await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      if (keyword.isEmpty) {
        filteredUsers = [];
      }
      else {
        filteredUsers = allUsers.where((user) {
          final name = user["name"]!.toLowerCase();
          final phone = user["phone"]!;
          return name.contains(keyword) || phone.contains(keyword);
        }).toList();
      }
      isLoading = false;
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
                MaterialPageRoute(builder: (context) => AddFriendScreen()),
              );
            },
            icon: Icon(Icons.person_add_alt_1, color: Colors.white,)
          ),
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateGroupPages()),
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
                    title: Text(user["name"] ?? ""),
                    subtitle: Text(user["phone"] ?? ""),
                    trailing: IconButton(
                      onPressed: (){
                        // TODO: Gửi lời mời kết bạn...
                      },
                      icon: Icon(Icons.chat_bubble_outline_rounded)),
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
