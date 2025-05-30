import 'package:flutter/material.dart';

import '../widgets/SettingItem.dart';

class SettingsOwn extends StatefulWidget {
  const SettingsOwn({super.key});

  @override
  State<SettingsOwn> createState() => _SettingsOwnState();
}
class _SettingsOwnState extends State<SettingsOwn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder:
              (BuildContext context) =>
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 25),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
        ),
        backgroundColor: Colors.blue,
        title: Text(
          "Tùy chọn",
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/meme.jpg"),
              ),
              SizedBox(height: 10),
              Text("Nhat Nguyen",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(12),
                              backgroundColor: Colors.grey[300]
                          ),
                          child: Icon(
                            Icons.search, color: Colors.black45, size: 20,)
                      ),
                      SizedBox(height: 10,),
                      Text("Tìm\ntin nhắn", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(12),
                              backgroundColor: Colors.grey[300]
                          ),
                          child: Icon(
                            Icons.person_outline, color: Colors.black45,
                            size: 20,)
                      ),
                      SizedBox(height: 10,),
                      Text("Trang\ncá nhân", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(12),
                              backgroundColor: Colors.grey[300]
                          ),
                          child: Icon(
                            Icons.palette_outlined, color: Colors.black45,
                            size: 20,)
                      ),
                      SizedBox(height: 10,),
                      Text("Đổi\nhình nền", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder:  (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Tắt thông  báo trò chuyện",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                    content: Text("Zalo sẽ ngừng gửi thông báo tin nhắn mới về trò chuyện này,ngoại trừ các tin quan trọn như nhắc tên @,nhắc hẹn."),
                                    actionsPadding: EdgeInsets.symmetric(horizontal: 16),
                                    actions: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Divider(),
                                          TextButton(
                                            onPressed: (){
                                              print("Trong vòng 1 giờ");
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Trong vòng 1 giờ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),),
                                          ),
                                          TextButton(
                                            onPressed: (){
                                              print("Trong vòng 4 giờ");

                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Trong vòng 4 giờ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),),
                                          ),
                                          TextButton(
                                            onPressed: (){
                                              print("Trong vòng 8 giờ");
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Trong vòng 8 giờ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),),
                                          ),
                                          TextButton(
                                            onPressed: (){
                                              print("Cho đến khi được mở lại");
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Cho đến khi được mở lại ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),),
                                          ),
                                          SizedBox(height: 10,)
                                        ],
                                      )

                                    ],
                                  );
                                });
                          },
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(12),
                              backgroundColor: Colors.grey[300]
                          ),
                          child: Icon(
                            Icons.notifications_none, color: Colors.black45,
                            size: 20,)
                      ),
                      SizedBox(height: 10,),
                      Text("Tắt\nthông báo", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              SettingItem(
                icon: Icons.edit,
                title: "Đổi tên gợi nhớ",
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(

                        );
                      });
                  // Xử lý khi nhấn vào
                  print("Đổi tên gợi nhớ được chọn");
                },
              ),
              SettingItem(
                icon: Icons.factory,
                title: "Ảnh, file, link",
                onTap: () {
                  // Xử lý khi nhấn vào
                  print("Đổi tên gợi nhớ được chọn");
                },
              ),
              SettingItem(
                icon: Icons.group_outlined,
                title: "Xem nhóm chung",
                onTap: () {
                  // Xử lý khi nhấn vào
                  print("Đổi tên gợi nhớ được chọn");
                },
              ),
              SettingItem(
                icon: Icons.delete_outline ,
                title: "Xóa lịch sử trò chuyện",
                color: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.only(top: 20, left: 24, right: 24), // bỏ padding mặc định ở dưới
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Bạn có muốn xóa trò chuyện ai ?"),
                            SizedBox(height: 20),
                            Divider(height: 1, color: Colors.grey[300]), // đường line
                          ],
                        ),
                        actionsPadding: EdgeInsets.only(bottom: 8, right: 8), // spacing cho nút
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Hủy"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // xử lý xóa
                            },
                            child: Text("Xóa", style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      );
                    },
                  );
                  print("Đổi tên gợi nhớ được chọn");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
