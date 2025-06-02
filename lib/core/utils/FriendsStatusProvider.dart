import 'package:flutter/cupertino.dart';
import 'package:realm/realm.dart';

import '../../data/realm/realm_models/models.dart';
import 'FriendWithStatus.dart';

class FriendsProvider with ChangeNotifier {
  final NguoiDung currentUser;
  final Realm realm;
  final List<FriendWithStatus> _friends = [];

  List<FriendWithStatus> get friends => _friends;

  FriendsProvider({required this.currentUser, required this.realm}) {
    Future.microtask(() => loadFriends());
  }

  void loadFriends() {
    final allKetBans = realm.all<KetBan>();
    final accepted = allKetBans.where(
          (kb) =>
      kb.trangThai == 'accepted' &&
          (kb.nguoiGui?.maNguoiDung == currentUser.maNguoiDung ||
              kb.nguoiNhan?.maNguoiDung == currentUser.maNguoiDung),
    );

    _friends.clear();
    _friends.addAll(
      accepted
          .map((kb) {
        if (kb.nguoiGui?.maNguoiDung == currentUser.maNguoiDung) {
          return kb.nguoiNhan;
        } else {
          return kb.nguoiGui;
        }
      })
          .whereType<NguoiDung>()
          .map((u) => FriendWithStatus(nguoiDung: u)),
    );
    notifyListeners();
  }

  void updateOnlineStatus(ObjectId userId, bool isOnline) {
    final index =
    _friends.indexWhere((f) => f.nguoiDung.maNguoiDung == userId);
    if (index != -1) {
      _friends[index].isOnline = isOnline;
      notifyListeners();
    }
  }
}
