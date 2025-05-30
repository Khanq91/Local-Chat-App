import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/features/chat/widgets/CustomCard.dart';
import 'package:realm/realm.dart';
import '../../../data/model/chatmodel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chatpages extends StatelessWidget {
  const Chatpages({
    super.key,
    required this.chats,
    required this.currentUserId,
    required this.socket,
  });

  final List<ChatModel> chats;
  final ObjectId currentUserId;
  final IO.Socket socket;

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
          ),
      ),
    );
  }
}
