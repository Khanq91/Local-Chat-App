import 'package:flutter/material.dart';

import '../../../data/model/assets.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Text(
          "Đăng kí tài khoản mới",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
        backgroundColor: AppColors.appbarBG,
      ),
      body: Center(
        child: Text("Sign Up"),
      ),
    );
  }
}
