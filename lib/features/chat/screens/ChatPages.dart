import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/features/chat/widgets/CustomCard.dart';
import 'package:realm/realm.dart';

import '../../../data/model/chatmodel.dart';
class Chatpages  extends StatelessWidget {
  const Chatpages ({super.key,required this.chats, required this.currentUserId});
  final List<ChatModel> chats;
  final ObjectId currentUserId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
          itemBuilder: (context,index)=>Customcard(
              chatModel: chats[index],
              sourchat: chats[index],
                currentUserId: currentUserId,   // Người gửi
                receiverId: chats[index].id,           // Người nhận (id của bạn bè)
          ))
    );
  }
}
