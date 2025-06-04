import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/features/chat/widgets/CustomCard.dart';
import 'package:realm/realm.dart';
import '../../../data/model/chatmodel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../data/realm/realm_models/models.dart';

class Chatpages extends StatelessWidget {
  Chatpages({
    super.key,
    required this.chats,
    required this.currentUserId,
    required this.socket,
    required this.onReturnFromChat,
  });

  final List<ChatModel> chats;
  final ObjectId currentUserId;
  final IO.Socket socket;
  final VoidCallback onReturnFromChat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder:
          (context, index) => Customcard(
            chatModel: chats[index],
            sourchat: chats[index],
            currentUserId: currentUserId,
            // Người gửi
            receiverId: chats[index].id,
            socket: socket, // Người nhận (id của bạn bè)
            currentMessage: chats[index].currentMessage,
            onReturnFromChat: onReturnFromChat,
          ),
      ),
    );
  }
}
