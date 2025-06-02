import '../../data/realm/realm_models/models.dart';

class FriendWithStatus {
  final NguoiDung nguoiDung;
  bool isOnline;

  FriendWithStatus({required this.nguoiDung, this.isOnline = false});
}
