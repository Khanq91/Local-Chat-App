import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:realm/realm.dart';
import 'package:nhan_tin_noi_bo/data/realm/realm_services/realm.dart';
import 'package:nhan_tin_noi_bo/data/realm/realm_models/models.dart';
import 'package:nhan_tin_noi_bo/features/user/screens/HomeScreen.dart';

class CreateAccountScreen extends StatefulWidget {
  final String phoneNumber;
  CreateAccountScreen({required this.phoneNumber});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  File? _selectedImage;

  final _realmService = RealmService();

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _selectedImage = File(picked.path));
  }

  void _createAccount() {
    final password = _passwordController.text.trim();
    final fullName = _fullNameController.text.trim();

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập mật khẩu")),
      );
      return;
    }

    final existing = _realmService.query<NguoiDung>("tenDangNhap == \$0", [widget.phoneNumber]);
    if (existing.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Số điện thoại đã được đăng ký")),
      );
      return;
    }

    final newUser = NguoiDung(
      ObjectId(),
      widget.phoneNumber,
      password,
      true,
      "user",
      DateTime.now(),
      hoTen: fullName.isEmpty ? null : fullName,
      anhDaiDien: _selectedImage?.path,
    );

    _realmService.add<NguoiDung>(newUser);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Home_Screen(currentUser: newUser)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tạo tài khoản")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                child: _selectedImage == null ? Icon(Icons.camera_alt) : null,
              ),
            ),
            SizedBox(height: 24),
            Text("Tên đăng nhập: ${widget.phoneNumber}"),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Mật khẩu", border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: "Họ tên (không bắt buộc)", border: OutlineInputBorder()),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _createAccount,
              child: Text("Tạo tài khoản & Vào app"),
            ),
          ],
        ),
      ),
    );
  }
}
