import 'package:flutter/material.dart';

import 'CreateAccountScreen.dart';

class OTPScreen extends StatelessWidget {
  final String phoneNumber;

  OTPScreen({required this.phoneNumber});

  final TextEditingController _otpController = TextEditingController();

  void _verifyOTP(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CreateAccountScreen(phoneNumber: phoneNumber),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Xác thực OTP")),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Mã xác thực đã gửi đến $phoneNumber"),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Nhập mã OTP"),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _verifyOTP(context),
              child: Text("Xác nhận"),
            ),
          ],
        ),
      ),
    );
  }
}
