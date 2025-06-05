import 'package:realm/realm.dart';

class User {
  final ObjectId maNguoiDung;
  final String name;
  final String time;
  final String avatar;

  User({
    required this.maNguoiDung,
    required this.name,
    required this.time,
    required this.avatar,
  });
}
