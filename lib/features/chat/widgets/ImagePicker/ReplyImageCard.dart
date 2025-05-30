import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/config/IPconfig.dart';

class ReplyImageCard extends StatelessWidget {
  const ReplyImageCard({super.key, required this.path, required this.time});
  final List<String> path;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: MediaQuery.of(context).size.height / 2.3,
            width: MediaQuery.of(context).size.width / 1.8,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: path.length,
                    itemBuilder: (context, index) {
                      final fullUrl = "http://${AppConfig.baseUrl}:5000${path[index]}";
                      print(time);
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          fullUrl,
                          height: 350,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Center(child: Text("Ảnh lỗi")),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding:EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child:
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
