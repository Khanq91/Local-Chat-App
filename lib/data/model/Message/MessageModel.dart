class MessageModel{
  String type;
  String message;
  String time;
  String path;
  bool isPinned;
  MessageModel({required this.message,required this.type,required this.time,required this.path, required this.isPinned});
}