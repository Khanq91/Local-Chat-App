import 'package:flutter/material.dart';
import 'OTPScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _goToOTP() {
    String phone = _phoneController.text.trim();
    if (phone.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => OTPScreen(phoneNumber: phone)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nhập số điện thoại")),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Số điện thoại"),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _goToOTP,
              child: Text("Tiếp tục"),
            ),
          ],
        ),
      ),
    );
  }
}
