import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key, required this.message,required this.time});
  final  String message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 85,
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(2),
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Color(0xFFE1F0FF),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 20,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),

              Positioned(
                bottom: 4,
                right: 10,
                child: Row(children: [Text(time, style: TextStyle(fontSize: 12, color: Colors.grey),)]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
