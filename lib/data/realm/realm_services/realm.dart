import 'package:realm/realm.dart';
import '../realm_models/models.dart';

class RealmService {
  static final RealmService _instance = RealmService._internal();
  late final Realm _realm;

  RealmService._internal() {
    final config = Configuration.local(
      [
        NguoiDung.schema,
        TinNhanNhom.schema,
        TinNhanCaNhan.schema,
        NhomChat.schema,
        ThanhVienNhom.schema,
        TepDinhKemNhom.schema,
        TepDinhKemCaNhan.schema,
        KetBan.schema,
      ],
      schemaVersion: 5,
      migrationCallback: _migrationHandler,
    );

    _realm = Realm(config);
  }

  factory RealmService() => _instance;

  Realm get realm => _realm;

  void _migrationHandler(Migration migration, int oldVersion) {
    print('Realm migrating from $oldVersion...');
  }

  // Thêm object (Add)
  void add<T extends RealmObject>(T object) {
    _realm.write(() => _realm.add(object));
  }

  // ️ Xóa object (Delete)
  void delete<T extends RealmObject>(T object) {
    _realm.write(() => _realm.delete(object));
  }

  // Cập nhật object (Update)
  void update(void Function() action) {
    _realm.write(action);
  }

  // Query object
  Iterable<T> query<T extends RealmObject>([String? filter, List<Object?> args = const []]) {
    if (filter == null) {
      return _realm.all<T>();
    }
    return _realm.query<T>(filter, args);
  }

  void close() {
    _realm.close();
  }
}
