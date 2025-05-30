import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/core/utils/connection.dart';
import 'package:nhan_tin_noi_bo/features/chat/screens/IndividualPage.dart';
import 'package:realm/realm.dart';
import '../../../data/model/chatmodel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Customcard extends StatelessWidget {
  const Customcard({Key? key, required this.chatModel, required this.sourchat,required this.currentUserId,required this.receiverId, required this.socket})
    : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;
  final ObjectId  currentUserId;
  final ObjectId  receiverId;
  final IO.Socket socket;
  @override
  Widget build(BuildContext context) {

  print(currentUserId);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    Individualpage(chatModel: chatModel, sourchat: sourchat, currentUserId: currentUserId, receiverId: receiverId, socket: socket,),
          ),
        );
      },
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(chatModel.avatar),
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
          chatModel.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          chatModel.currentMessage,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        trailing: Text(chatModel.time),
      ),
    );
  }
}
