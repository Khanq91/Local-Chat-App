import 'package:realm/realm.dart';

class ChatModel {
  String name;
  String avatar;
  bool isGroup;
  String time;
  String currentMessage;
  bool select=false;
  ObjectId id;
  ChatModel({
    required this.name,
    required this.avatar,
    required this.isGroup,
    required this.time,
    required this.currentMessage,
    this.select=false,
    required this.id,
  });
}
