import 'dart:io';
import 'package:realm/realm.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../config/IPconfig.dart';
IO.Socket? socket;

class SocketService {
  late IO.Socket socket;

  IO.Socket connect(ObjectId currentUserId) {
    socket = IO.io("http://${AppConfig.baseUrl}:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": true,
    });

    socket.connect();

    socket.onConnect((_) {
      socket.emit("signin", currentUserId.toString());
      print("Socket connected");
    });

    return socket;
  }
}
