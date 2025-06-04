// import 'dart:io';
// import 'package:realm/realm.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import '../../config/IPconfig.dart';
// IO.Socket? socket;
//
// class SocketService {
//   late IO.Socket socket;
//
//   IO.Socket connect(ObjectId currentUserId) {
//     socket = IO.io("http://${AppConfig.baseUrl}:5000", <String, dynamic>{
//       "transports": ["websocket"],
//       "autoConnect": true,
//     });
//
//     socket.connect();
//
//     socket.onConnect((_) {
//       socket.emit("signin", currentUserId.toString());
//       print("Socket connected");
//     });
//
//     return socket;
//   }
// }

import 'package:realm/realm.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../config/IPconfig.dart';
import '../../data/realm/realm_models/models.dart';

class SocketService {
  late IO.Socket socket;

  void connect(ObjectId currentUserId, Realm realm) {
    socket = IO.io("http://${AppConfig.baseUrl}:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": true,
    });

    socket.connect();

    socket.onConnect((_) {
      socket.emit("signin", currentUserId.toString());
      print("Socket connected");
    });

    socket.on("message", (data) {
      print("Received message: $data");

      final maNguoiGui = ObjectId.fromHexString(data["sourceId"]);
      final maNguoiNhan = ObjectId.fromHexString(data["targetId"]);

      final nguoiGui = realm.find<NguoiDung>(maNguoiGui);
      final nguoiNhan = realm.find<NguoiDung>(maNguoiNhan);

      if (nguoiGui == null || nguoiNhan == null) {
        print("Không tìm thấy người gửi hoặc nhận");
        return;
      }

      realm.write(() {
        final tinNhan = TinNhanCaNhan(
          ObjectId(),
          data["message"],
          "text",
          DateTime.now(),
          data["path"] ?? '',
          maNguoiGui,
          maNguoiNhan,
        );
        tinNhan.nguoiGui = nguoiGui;
        tinNhan.nguoiNhan = nguoiNhan;
        tinNhan.ghim = false;
        tinNhan.thoiGianGui = DateTime.now();
        realm.add(tinNhan);
      });
    });
  }

  void sendMessage(Map<String, dynamic> messageData) {
    socket.emit("message", messageData);
  }
}

