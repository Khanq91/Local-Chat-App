import 'dart:convert';
import 'package:realm/realm.dart';
import '../../../core/utils/connection.dart';
import '../../../data/realm/realm_services/realm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:nhan_tin_noi_bo/config/IPconfig.dart';
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
  late IO.Socket socketConnect;
  bool _isSocketConnected = false;
  final _realmService = RealmService();

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _selectedImage = File(picked.path));
  }

  Future<void> _createAccount() async {
    final password = _passwordController.text.trim();
    final fullName = _fullNameController.text.trim();
    print("chạy hàm _createAccount");
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

    // final newUser = NguoiDung(
    //   ObjectId(),
    //   widget.phoneNumber,
    //   password,
    //   true,
    //   "user",
    //   DateTime.now(),
    //   hoTen: fullName.isEmpty ? null : fullName,
    //   anhDaiDien: _selectedImage?.path,
    // );
    // _realmService.add<NguoiDung>(newUser);
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (_) => Home_Screen(currentUser: newUser)),
    // );

    final uri = Uri.parse("http://${AppConfig.baseUrl}:5000/routes/register");

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "phoneNumber": widget.phoneNumber,
          "password": password,
          "fullName": fullName,
          "avatarUrl": _selectedImage?.path, // Gửi URL hoặc upload trước lên server nếu cần
        }),
      );

      if (response.statusCode == 201) {
        final result = jsonDecode(response.body);
        // Ghi xuống Realm nếu muốn lưu offline
        final userData = result['user'];
        final newUser = NguoiDung(
          ObjectId(),
          userData['phoneNumber'],
          userData['password'],
          true,
          "user",
          DateTime.now(),
          hoTen: userData['fullName'],
          anhDaiDien: userData['avatarUrl'],
        );


        _realmService.add<NguoiDung>(newUser);
        print("Thêm tài khoản user \"${newUser.maNguoiDung}\" thành công");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Home_Screen(currentUser: newUser)),
        );
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("⚠️ ${error['message']}")),
        );
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    }
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
