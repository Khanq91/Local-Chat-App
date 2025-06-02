import 'package:realm/realm.dart';
import '../../data/realm/realm_models/models.dart';
import '../../data/realm/realm_services/realm.dart';

class UserService {
  void capNhatTrangThai(ObjectId userId, bool status) {
    final realm = RealmService().realm;

    final user = realm.find<NguoiDung>(userId);
    if (user != null) {
      realm.write(() {
        user.trangThai = status;
      });
    }
  }
}
