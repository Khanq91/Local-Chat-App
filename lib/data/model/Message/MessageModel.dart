import 'package:nhan_tin_noi_bo/data/model/Message/FileModel.dart';

class MessageModel{
  String type;
  String message;
  String time;
  String path;
  bool isPinned;
  MessageModel({required this.message,required this.type,required this.time,required this.path, required this.isPinned, FileModel? fileModel});
}