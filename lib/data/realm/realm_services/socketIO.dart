import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect(String userId) {
    socket = IO.io(
      'http://localhost:3000', // Đổi thành IP máy chủ nếu dùng thật
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // tự connect sau khi cấu hình xong
          .setQuery({'userId': userId}) // gửi ID người dùng lên server
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print("✅ Socket connected");
    });

    socket.onDisconnect((_) => print("❌ Socket disconnected"));

    socket.on("receive_message", (data) {
      print("📩 Message received: $data");
      // TODO: insert vào Realm tại đây
    });
  }

  void sendMessage(Map<String, dynamic> messageData) {
    socket.emit("send_message", messageData);
  }

  void dispose() {
    socket.dispose();
  }
}
