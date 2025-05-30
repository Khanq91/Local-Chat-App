import 'package:flutter/material.dart';
import '../../../data/model/Message/MessageModel.dart';
import '../../../data/model/assets.dart';


class PinnedMessagesScreen extends StatelessWidget {
  final List<MessageModel> pinnedMessages;

  const PinnedMessagesScreen({super.key, required this.pinnedMessages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbarBG,
        title: Text(
          "Tin nhắn đã ghim",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white
          ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
            icon: Icon(Icons.arrow_back, color: Colors.white,)
        ),
      ),
      body: Container(
        color: AppColors.bodyBG,
        child: ListView.builder(
          itemCount: pinnedMessages.length,
          itemBuilder: (context, index) {
            final msg = pinnedMessages[index];
            return ListTile(
              title: Text(msg.message),
              subtitle: Text(msg.time),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () {
                  Navigator.pop(context);
                  msg.isPinned = false;
                },
              ),
            );
          },
        ),
      )
    );
  }
}

