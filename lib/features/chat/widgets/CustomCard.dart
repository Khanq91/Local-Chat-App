import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/core/utils/connection.dart';
import 'package:nhan_tin_noi_bo/features/chat/screens/IndividualPage.dart';
import 'package:realm/realm.dart';
import '../../../data/model/chatmodel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../data/realm/realm_models/models.dart';

class Customcard extends StatefulWidget {
  Customcard({
    Key? key,
    required this.chatModel,
    required this.sourchat,
    required this.currentUserId,
    required this.receiverId,
    required this.socket,
    required this.currentMessage,
    required this.onReturnFromChat,
  }) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;
  final ObjectId currentUserId;
  final ObjectId receiverId;
  final IO.Socket socket;
  final String currentMessage;
  final VoidCallback onReturnFromChat;

  @override
  State<Customcard> createState() => _CustomcardState();
}

class _CustomcardState extends State<Customcard> {
  late String displayedMessage;

  @override
  void initState() {
    super.initState();
    displayedMessage = widget.currentMessage;
  }

  @override
  void didUpdateWidget(covariant Customcard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentMessage != widget.currentMessage) {
      setState(() {
        displayedMessage = widget.currentMessage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formatTime(String input) {
      try {
        List<String> parts = input.split(' ');
        if (parts.length >= 2) {
          String time = parts[1];
          return '${parts[0]} ${time.substring(0, 5)}';
        }
      } catch (_) {}
      return input;
    }
    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder:
              (context) => Individualpage(
                chatModel: widget.chatModel,
                sourchat: widget.sourchat,
                currentUserId: widget.currentUserId,
                receiverId: widget.receiverId,
                socket: widget.socket,
              ),
          ),
        );
        if(result == 'refresh'){
          widget.onReturnFromChat();
        }
      },
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(widget.chatModel.avatar),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          widget.chatModel.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          displayedMessage,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        trailing: Text(formatTime(widget.chatModel.time.toString())),
      ),
    );
  }
}
