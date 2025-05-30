import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key, required this.message,required this.time});
  final String message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          // color: Color(0xFFE5E5EA),
          child: Stack(
            children: [
              Padding(padding: EdgeInsets.only(
                left: 10,
                right: 20,
                top: 5,
                bottom: 20,
              ),
                  child: Text(message,
                    style:TextStyle(fontSize: 16,color: Colors.black),)
              ),
              Positioned(
                bottom: 1,
                right: 10,
                child: Row(children: [Text(time)]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

