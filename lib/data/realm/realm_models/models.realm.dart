// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class NguoiDung extends _NguoiDung
    with RealmEntity, RealmObjectBase, RealmObject {
  NguoiDung(
    ObjectId maNguoiDung,
    String tenDangNhap,
    String matKhau,
    bool trangThai,
    String vaiTro,
    DateTime ngayTao, {
    String? hoTen,
    String? anhDaiDien,
  }) {
    RealmObjectBase.set(this, 'maNguoiDung', maNguoiDung);
    RealmObjectBase.set(this, 'tenDangNhap', tenDangNhap);
    RealmObjectBase.set(this, 'matKhau', matKhau);
    RealmObjectBase.set(this, 'hoTen', hoTen);
    RealmObjectBase.set(this, 'anhDaiDien', anhDaiDien);
    RealmObjectBase.set(this, 'trangThai', trangThai);
    RealmObjectBase.set(this, 'vaiTro', vaiTro);
    RealmObjectBase.set(this, 'ngayTao', ngayTao);
  }

  NguoiDung._();

  @override
  ObjectId get maNguoiDung =>
      RealmObjectBase.get<ObjectId>(this, 'maNguoiDung') as ObjectId;
  @override
  set maNguoiDung(ObjectId value) =>
      RealmObjectBase.set(this, 'maNguoiDung', value);

  @override
  String get tenDangNhap =>
      RealmObjectBase.get<String>(this, 'tenDangNhap') as String;
  @override
  set tenDangNhap(String value) =>
      RealmObjectBase.set(this, 'tenDangNhap', value);

  @override
  String get matKhau => RealmObjectBase.get<String>(this, 'matKhau') as String;
  @override
  set matKhau(String value) => RealmObjectBase.set(this, 'matKhau', value);

  @override
  String? get hoTen => RealmObjectBase.get<String>(this, 'hoTen') as String?;
  @override
  set hoTen(String? value) => RealmObjectBase.set(this, 'hoTen', value);

  @override
  String? get anhDaiDien =>
      RealmObjectBase.get<String>(this, 'anhDaiDien') as String?;
  @override
  set anhDaiDien(String? value) =>
      RealmObjectBase.set(this, 'anhDaiDien', value);

  @override
  bool get trangThai => RealmObjectBase.get<bool>(this, 'trangThai') as bool;
  @override
  set trangThai(bool value) => RealmObjectBase.set(this, 'trangThai', value);

  @override
  String get vaiTro => RealmObjectBase.get<String>(this, 'vaiTro') as String;
  @override
  set vaiTro(String value) => RealmObjectBase.set(this, 'vaiTro', value);

  @override
  DateTime get ngayTao =>
      RealmObjectBase.get<DateTime>(this, 'ngayTao') as DateTime;
  @override
  set ngayTao(DateTime value) => RealmObjectBase.set(this, 'ngayTao', value);

  @override
  RealmResults<TinNhanNhom> get tinNhanNhomGui {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<TinNhanNhom>(this, 'tinNhanNhomGui')
        as RealmResults<TinNhanNhom>;
  }

  @override
  set tinNhanNhomGui(covariant RealmResults<TinNhanNhom> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmResults<TinNhanCaNhan> get tinNhanCaNhanGui {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<TinNhanCaNhan>(this, 'tinNhanCaNhanGui')
        as RealmResults<TinNhanCaNhan>;
  }

  @override
  set tinNhanCaNhanGui(covariant RealmResults<TinNhanCaNhan> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmResults<TinNhanCaNhan> get tinNhanCaNhanNhan {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<TinNhanCaNhan>(this, 'tinNhanCaNhanNhan')
        as RealmResults<TinNhanCaNhan>;
  }

  @override
  set tinNhanCaNhanNhan(covariant RealmResults<TinNhanCaNhan> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmResults<NhomChat> get nhomTao {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<NhomChat>(this, 'nhomTao')
        as RealmResults<NhomChat>;
  }

  @override
  set nhomTao(covariant RealmResults<NhomChat> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmResults<ThanhVienNhom> get danhSachNhomThamGia {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<ThanhVienNhom>(this, 'danhSachNhomThamGia')
        as RealmResults<ThanhVienNhom>;
  }

  @override
  set danhSachNhomThamGia(covariant RealmResults<ThanhVienNhom> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmResults<KetBan> get loiMoiKetBanDaGui {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<KetBan>(this, 'loiMoiKetBanDaGui')
        as RealmResults<KetBan>;
  }

  @override
  set loiMoiKetBanDaGui(covariant RealmResults<KetBan> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmResults<KetBan> get loiMoiKetBanDaNhan {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<KetBan>(this, 'loiMoiKetBanDaNhan')
        as RealmResults<KetBan>;
  }

  @override
  set loiMoiKetBanDaNhan(covariant RealmResults<KetBan> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<NguoiDung>> get changes =>
      RealmObjectBase.getChanges<NguoiDung>(this);

  @override
  Stream<RealmObjectChanges<NguoiDung>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<NguoiDung>(this, keyPaths);

  @override
  NguoiDung freeze() => RealmObjectBase.freezeObject<NguoiDung>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'maNguoiDung': maNguoiDung.toEJson(),
      'tenDangNhap': tenDangNhap.toEJson(),
      'matKhau': matKhau.toEJson(),
      'hoTen': hoTen.toEJson(),
      'anhDaiDien': anhDaiDien.toEJson(),
      'trangThai': trangThai.toEJson(),
      'vaiTro': vaiTro.toEJson(),
      'ngayTao': ngayTao.toEJson(),
    };
  }

  static EJsonValue _toEJson(NguoiDung value) => value.toEJson();
  static NguoiDung _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'maNguoiDung': EJsonValue maNguoiDung,
        'tenDangNhap': EJsonValue tenDangNhap,
        'matKhau': EJsonValue matKhau,
        'trangThai': EJsonValue trangThai,
        'vaiTro': EJsonValue vaiTro,
        'ngayTao': EJsonValue ngayTao,
      } =>
        NguoiDung(
          fromEJson(maNguoiDung),
          fromEJson(tenDangNhap),
          fromEJson(matKhau),
          fromEJson(trangThai),
          fromEJson(vaiTro),
          fromEJson(ngayTao),
          hoTen: fromEJson(ejson['hoTen']),
          anhDaiDien: fromEJson(ejson['anhDaiDien']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(NguoiDung._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, NguoiDung, 'NguoiDung', [
      SchemaProperty(
        'maNguoiDung',
        RealmPropertyType.objectid,
        primaryKey: true,
      ),
      SchemaProperty('tenDangNhap', RealmPropertyType.string),
      SchemaProperty('matKhau', RealmPropertyType.string),
      SchemaProperty('hoTen', RealmPropertyType.string, optional: true),
      SchemaProperty('anhDaiDien', RealmPropertyType.string, optional: true),
      SchemaProperty('trangThai', RealmPropertyType.bool),
      SchemaProperty('vaiTro', RealmPropertyType.string),
      SchemaProperty('ngayTao', RealmPropertyType.timestamp),
      SchemaProperty(
        'tinNhanNhomGui',
        RealmPropertyType.linkingObjects,
        linkOriginProperty: 'nguoiGui',
        collectionType: RealmCollectionType.list,
        linkTarget: 'TinNhanNhom',
      ),
      SchemaProperty(
        'tinNhanCaNhanGui',
        RealmPropertyType.linkingObjects,
        linkOriginProperty: 'nguoiGui',
        collectionType: RealmCollectionType.list,
        linkTarget: 'TinNhanCaNhan',
      ),
      SchemaProperty(
        'tinNhanCaNhanNhan',
        RealmPropertyType.linkingObjects,
        linkOriginProperty: 'nguoiNhan',
        collectionType: RealmCollectionType.list,
        linkTarget: 'TinNhanCaNhan',
      ),
      SchemaProperty(
        'nhomTao',
        RealmPropertyType.linkingObjects,
        linkOriginProperty: 'nguoiTao',
        collectionType: RealmCollectionType.list,
        linkTarget: 'NhomChat',
      ),
      SchemaProperty(
        'danhSachNhomThamGia',
        RealmPropertyType.linkingObjects,
        linkOriginProperty: 'thanhVien',
        collectionType: RealmCollectionType.list,
        linkTarget: 'ThanhVienNhom',
      ),
      SchemaProperty(
        'loiMoiKetBanDaGui',
        RealmPropertyType.linkingObjects,
        linkOriginProperty: 'nguoiGui',
        collectionType: RealmCollectionType.list,
        linkTarget: 'KetBan',
      ),
      SchemaProperty(
        'loiMoiKetBanDaNhan',
        RealmPropertyType.linkingObjects,
        linkOriginProperty: 'nguoiNhan',
        collectionType: RealmCollectionType.list,
        linkTarget: 'KetBan',
      ),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TinNhanNhom extends _TinNhanNhom
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  TinNhanNhom(
    ObjectId maTinNhanNhom,
    String noiDung,
    String kieuTinNhan,
    DateTime thoiGianGui,
    String duongDanAnh, {
    NhomChat? nhom,
    NguoiDung? nguoiGui,
    bool ghim = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<TinNhanNhom>({'ghim': false});
    }
    RealmObjectBase.set(this, 'maTinNhanNhom', maTinNhanNhom);
    RealmObjectBase.set(this, 'nhom', nhom);
    RealmObjectBase.set(this, 'nguoiGui', nguoiGui);
    RealmObjectBase.set(this, 'noiDung', noiDung);
    RealmObjectBase.set(this, 'kieuTinNhan', kieuTinNhan);
    RealmObjectBase.set(this, 'ghim', ghim);
    RealmObjectBase.set(this, 'thoiGianGui', thoiGianGui);
    RealmObjectBase.set(this, 'duongDanAnh', duongDanAnh);
  }

  TinNhanNhom._();

  @override
  ObjectId get maTinNhanNhom =>
      RealmObjectBase.get<ObjectId>(this, 'maTinNhanNhom') as ObjectId;
  @override
  set maTinNhanNhom(ObjectId value) =>
      RealmObjectBase.set(this, 'maTinNhanNhom', value);

  @override
  NhomChat? get nhom =>
      RealmObjectBase.get<NhomChat>(this, 'nhom') as NhomChat?;
  @override
  set nhom(covariant NhomChat? value) =>
      RealmObjectBase.set(this, 'nhom', value);

  @override
  NguoiDung? get nguoiGui =>
      RealmObjectBase.get<NguoiDung>(this, 'nguoiGui') as NguoiDung?;
  @override
  set nguoiGui(covariant NguoiDung? value) =>
      RealmObjectBase.set(this, 'nguoiGui', value);

  @override
  String get noiDung => RealmObjectBase.get<String>(this, 'noiDung') as String;
  @override
  set noiDung(String value) => RealmObjectBase.set(this, 'noiDung', value);

  @override
  String get kieuTinNhan =>
      RealmObjectBase.get<String>(this, 'kieuTinNhan') as String;
  @override
  set kieuTinNhan(String value) =>
      RealmObjectBase.set(this, 'kieuTinNhan', value);

  @override
  bool get ghim => RealmObjectBase.get<bool>(this, 'ghim') as bool;
  @override
  set ghim(bool value) => RealmObjectBase.set(this, 'ghim', value);

  @override
  DateTime get thoiGianGui =>
      RealmObjectBase.get<DateTime>(this, 'thoiGianGui') as DateTime;
  @override
  set thoiGianGui(DateTime value) =>
      RealmObjectBase.set(this, 'thoiGianGui', value);

  @override
  String get duongDanAnh =>
      RealmObjectBase.get<String>(this, 'duongDanAnh') as String;
  @override
  set duongDanAnh(String value) =>
      RealmObjectBase.set(this, 'duongDanAnh', value);

  @override
  RealmResults<TepDinhKemNhom> get tepDinhKem {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<TepDinhKemNhom>(this, 'tepDinhKem')
        as RealmResults<TepDinhKemNhom>;
  }

  @override
  set tepDinhKem(covariant RealmResults<TepDinhKemNhom> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<TinNhanNhom>> get changes =>
      RealmObjectBase.getChanges<TinNhanNhom>(this);

  @override
  Stream<RealmObjectChanges<TinNhanNhom>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<TinNhanNhom>(this, keyPaths);

  @override
  TinNhanNhom freeze() => RealmObjectBase.freezeObject<TinNhanNhom>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'maTinNhanNhom': maTinNhanNhom.toEJson(),
      'nhom': nhom.toEJson(),
      'nguoiGui': nguoiGui.toEJson(),
      'noiDung': noiDung.toEJson(),
      'kieuTinNhan': kieuTinNhan.toEJson(),
      'ghim': ghim.toEJson(),
      'thoiGianGui': thoiGianGui.toEJson(),
      'duongDanAnh': duongDanAnh.toEJson(),
    };
  }

  static EJsonValue _toEJson(TinNhanNhom value) => value.toEJson();
  static TinNhanNhom _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'maTinNhanNhom': EJsonValue maTinNhanNhom,
        'noiDung': EJsonValue noiDung,
        'kieuTinNhan': EJsonValue kieuTinNhan,
        'thoiGianGui': EJsonValue thoiGianGui,
        'duongDanAnh': EJsonValue duongDanAnh,
      } =>
        TinNhanNhom(
          fromEJson(maTinNhanNhom),
          fromEJson(noiDung),
          fromEJson(kieuTinNhan),
          fromEJson(thoiGianGui),
          fromEJson(duongDanAnh),
          nhom: fromEJson(ejson['nhom']),
          nguoiGui: fromEJson(ejson['nguoiGui']),
          ghim: fromEJson(ejson['ghim'], defaultValue: false),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TinNhanNhom._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      TinNhanNhom,
      'TinNhanNhom',
      [
        SchemaProperty(
          'maTinNhanNhom',
          RealmPropertyType.objectid,
          primaryKey: true,
        ),
        SchemaProperty(
          'nhom',
          RealmPropertyType.object,
          optional: true,
          linkTarget: 'NhomChat',
        ),
        SchemaProperty(
          'nguoiGui',
          RealmPropertyType.object,
          optional: true,
          linkTarget: 'NguoiDung',
        ),
        SchemaProperty('noiDung', RealmPropertyType.string),
        SchemaProperty('kieuTinNhan', RealmPropertyType.string),
        SchemaProperty('ghim', RealmPropertyType.bool),
        SchemaProperty('thoiGianGui', RealmPropertyType.timestamp),
        SchemaProperty('duongDanAnh', RealmPropertyType.string),
        SchemaProperty(
          'tepDinhKem',
          RealmPropertyType.linkingObjects,
          linkOriginProperty: 'tinNhan',
          collectionType: RealmCollectionType.list,
          linkTarget: 'TepDinhKemNhom',
        ),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TinNhanCaNhan extends _TinNhanCaNhan
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  TinNhanCaNhan(
    ObjectId maTinNhanCaNhan,
    String noiDung,
    String kieuTinNhan,
    DateTime thoiGianGui,
    String duongDanAnh, {
    NguoiDung? nguoiGui,
    NguoiDung? nguoiNhan,
    bool ghim = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<TinNhanCaNhan>({
        'ghim': false,
      });
    }
    RealmObjectBase.set(this, 'maTinNhanCaNhan', maTinNhanCaNhan);
    RealmObjectBase.set(this, 'nguoiGui', nguoiGui);
    RealmObjectBase.set(this, 'nguoiNhan', nguoiNhan);
    RealmObjectBase.set(this, 'noiDung', noiDung);
    RealmObjectBase.set(this, 'kieuTinNhan', kieuTinNhan);
    RealmObjectBase.set(this, 'ghim', ghim);
    RealmObjectBase.set(this, 'thoiGianGui', thoiGianGui);
    RealmObjectBase.set(this, 'duongDanAnh', duongDanAnh);
  }

  TinNhanCaNhan._();

  @override
  ObjectId get maTinNhanCaNhan =>
      RealmObjectBase.get<ObjectId>(this, 'maTinNhanCaNhan') as ObjectId;
  @override
  set maTinNhanCaNhan(ObjectId value) =>
      RealmObjectBase.set(this, 'maTinNhanCaNhan', value);

  @override
  NguoiDung? get nguoiGui =>
      RealmObjectBase.get<NguoiDung>(this, 'nguoiGui') as NguoiDung?;
  @override
  set nguoiGui(covariant NguoiDung? value) =>
      RealmObjectBase.set(this, 'nguoiGui', value);

  @override
  NguoiDung? get nguoiNhan =>
      RealmObjectBase.get<NguoiDung>(this, 'nguoiNhan') as NguoiDung?;
  @override
  set nguoiNhan(covariant NguoiDung? value) =>
      RealmObjectBase.set(this, 'nguoiNhan', value);

  @override
  String get noiDung => RealmObjectBase.get<String>(this, 'noiDung') as String;
  @override
  set noiDung(String value) => RealmObjectBase.set(this, 'noiDung', value);

  @override
  String get kieuTinNhan =>
      RealmObjectBase.get<String>(this, 'kieuTinNhan') as String;
  @override
  set kieuTinNhan(String value) =>
      RealmObjectBase.set(this, 'kieuTinNhan', value);

  @override
  bool get ghim => RealmObjectBase.get<bool>(this, 'ghim') as bool;
  @override
  set ghim(bool value) => RealmObjectBase.set(this, 'ghim', value);

  @override
  DateTime get thoiGianGui =>
      RealmObjectBase.get<DateTime>(this, 'thoiGianGui') as DateTime;
  @override
  set thoiGianGui(DateTime value) =>
      RealmObjectBase.set(this, 'thoiGianGui', value);

  @override
  String get duongDanAnh =>
      RealmObjectBase.get<String>(this, 'duongDanAnh') as String;
  @override
  set duongDanAnh(String value) =>
      RealmObjectBase.set(this, 'duongDanAnh', value);

  @override
  RealmResults<TepDinhKemCaNhan> get tepDinhKem {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<TepDinhKemCaNhan>(this, 'tepDinhKem')
        as RealmResults<TepDinhKemCaNhan>;
  }

  @override
  set tepDinhKem(covariant RealmResults<TepDinhKemCaNhan> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<TinNhanCaNhan>> get changes =>
      RealmObjectBase.getChanges<TinNhanCaNhan>(this);

  @override
  Stream<RealmObjectChanges<TinNhanCaNhan>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<TinNhanCaNhan>(this, keyPaths);

  @override
  TinNhanCaNhan freeze() => RealmObjectBase.freezeObject<TinNhanCaNhan>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'maTinNhanCaNhan': maTinNhanCaNhan.toEJson(),
      'nguoiGui': nguoiGui.toEJson(),
      'nguoiNhan': nguoiNhan.toEJson(),
      'noiDung': noiDung.toEJson(),
      'kieuTinNhan': kieuTinNhan.toEJson(),
      'ghim': ghim.toEJson(),
      'thoiGianGui': thoiGianGui.toEJson(),
      'duongDanAnh': duongDanAnh.toEJson(),
    };
  }

  static EJsonValue _toEJson(TinNhanCaNhan value) => value.toEJson();
  static TinNhanCaNhan _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'maTinNhanCaNhan': EJsonValue maTinNhanCaNhan,
        'noiDung': EJsonValue noiDung,
        'kieuTinNhan': EJsonValue kieuTinNhan,
        'thoiGianGui': EJsonValue thoiGianGui,
        'duongDanAnh': EJsonValue duongDanAnh,
      } =>
        TinNhanCaNhan(
          fromEJson(maTinNhanCaNhan),
          fromEJson(noiDung),
          fromEJson(kieuTinNhan),
          fromEJson(thoiGianGui),
          fromEJson(duongDanAnh),
          nguoiGui: fromEJson(ejson['nguoiGui']),
          nguoiNhan: fromEJson(ejson['nguoiNhan']),
          ghim: fromEJson(ejson['ghim'], defaultValue: false),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TinNhanCaNhan._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      TinNhanCaNhan,
      'TinNhanCaNhan',
      [
        SchemaProperty(
          'maTinNhanCaNhan',
          RealmPropertyType.objectid,
          primaryKey: true,
        ),
        SchemaProperty(
          'nguoiGui',
          RealmPropertyType.object,
          optional: true,
          linkTarget: 'NguoiDung',
        ),
        SchemaProperty(
          'nguoiNhan',
          RealmPropertyType.object,
          optional: true,
          linkTarget: 'NguoiDung',
        ),
        SchemaProperty('noiDung', RealmPropertyType.string),
        SchemaProperty('kieuTinNhan', RealmPropertyType.string),
        SchemaProperty('ghim', RealmPropertyType.bool),
        SchemaProperty('thoiGianGui', RealmPropertyType.timestamp),
        SchemaProperty('duongDanAnh', RealmPropertyType.string),
        SchemaProperty(
          'tepDinhKem',
          RealmPropertyType.linkingObjects,
          linkOriginProperty: 'tinNhan',
          collectionType: RealmCollectionType.list,
          linkTarget: 'TepDinhKemCaNhan',
        ),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class NhomChat extends _NhomChat
    with RealmEntity, RealmObjectBase, RealmObject {
  NhomChat(
    ObjectId maNhom,
    String tenNhom,
    bool riengTu,
    DateTime ngayTao, {
    NguoiDung? nguoiTao,
    String? anhNhom,
  }) {
    RealmObjectBase.set(this, 'maNhom', maNhom);
    RealmObjectBase.set(this, 'tenNhom', tenNhom);
    RealmObjectBase.set(this, 'riengTu', riengTu);
    RealmObjectBase.set(this, 'nguoiTao', nguoiTao);
    RealmObjectBase.set(this, 'ngayTao', ngayTao);
    RealmObjectBase.set(this, 'anhNhom', anhNhom);
  }

  NhomChat._();

  @override
  ObjectId get maNhom =>
      RealmObjectBase.get<ObjectId>(this, 'maNhom') as ObjectId;
  @override
  set maNhom(ObjectId value) => RealmObjectBase.set(this, 'maNhom', value);

  @override
  String get tenNhom => RealmObjectBase.get<String>(this, 'tenNhom') as String;
  @override
  set tenNhom(String value) => RealmObjectBase.set(this, 'tenNhom', value);

  @override
  bool get riengTu => RealmObjectBase.get<bool>(this, 'riengTu') as bool;
  @override
  set riengTu(bool value) => RealmObjectBase.set(this, 'riengTu', value);

  @override
  NguoiDung? get nguoiTao =>
      RealmObjectBase.get<NguoiDung>(this, 'nguoiTao') as NguoiDung?;
  @override
  set nguoiTao(covariant NguoiDung? value) =>
      RealmObjectBase.set(this, 'nguoiTao', value);

  @override
  DateTime get ngayTao =>
      RealmObjectBase.get<DateTime>(this, 'ngayTao') as DateTime;
  @override
  set ngayTao(DateTime value) => RealmObjectBase.set(this, 'ngayTao', value);

  @override
  String? get anhNhom =>
      RealmObjectBase.get<String>(this, 'anhNhom') as String?;
  @override
  set anhNhom(String? value) => RealmObjectBase.set(this, 'anhNhom', value);

  @override
  RealmResults<ThanhVienNhom> get danhSachThanhVien {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<ThanhVienNhom>(this, 'danhSachThanhVien')
        as RealmResults<ThanhVienNhom>;
  }

  @override
  set danhSachThanhVien(covariant RealmResults<ThanhVienNhom> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmResults<TinNhanNhom> get danhSachTinNhan {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<TinNhanNhom>(this, 'danhSachTinNhan')
        as RealmResults<TinNhanNhom>;
  }

  @override
  set danhSachTinNhan(covariant RealmResults<TinNhanNhom> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<NhomChat>> get changes =>
      RealmObjectBase.getChanges<NhomChat>(this);

  @override
  Stream<RealmObjectChanges<NhomChat>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<NhomChat>(this, keyPaths);

  @override
  NhomChat freeze() => RealmObjectBase.freezeObject<NhomChat>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'maNhom': maNhom.toEJson(),
      'tenNhom': tenNhom.toEJson(),
      'riengTu': riengTu.toEJson(),
      'nguoiTao': nguoiTao.toEJson(),
      'ngayTao': ngayTao.toEJson(),
      'anhNhom': anhNhom.toEJson(),
    };
  }

  static EJsonValue _toEJson(NhomChat value) => value.toEJson();
  static NhomChat _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'maNhom': EJsonValue maNhom,
        'tenNhom': EJsonValue tenNhom,
        'riengTu': EJsonValue riengTu,
        'ngayTao': EJsonValue ngayTao,
      } =>
        NhomChat(
          fromEJson(maNhom),
          fromEJson(tenNhom),
          fromEJson(riengTu),
          fromEJson(ngayTao),
          nguoiTao: fromEJson(ejson['nguoiTao']),
          anhNhom: fromEJson(ejson['anhNhom']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(NhomChat._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, NhomChat, 'NhomChat', [
      SchemaProperty('maNhom', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('tenNhom', RealmPropertyType.string),
      SchemaProperty('riengTu', RealmPropertyType.bool),
      SchemaProperty(
        'nguoiTao',
        RealmPropertyType.object,
        optional: true,
        linkTarget: 'NguoiDung',
      ),
      SchemaProperty('ngayTao', RealmPropertyType.timestamp),
      SchemaProperty('anhNhom', RealmPropertyType.string, optional: true),
      SchemaProperty(
        'danhSachThanhVien',
        RealmPropertyType.linkingObjects,
        linkOriginProperty: 'nhom',
        collectionType: RealmCollectionType.list,
        linkTarget: 'ThanhVienNhom',
      ),
      SchemaProperty(
        'danhSachTinNhan',
        RealmPropertyType.linkingObjects,
        linkOriginProperty: 'nhom',
        collectionType: RealmCollectionType.list,
        linkTarget: 'TinNhanNhom',
      ),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class ThanhVienNhom extends _ThanhVienNhom
    with RealmEntity, RealmObjectBase, RealmObject {
  ThanhVienNhom(
    ObjectId id,
    bool quanTriVien,
    DateTime ngayThamGia, {
    NhomChat? nhom,
    NguoiDung? thanhVien,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'nhom', nhom);
    RealmObjectBase.set(this, 'thanhVien', thanhVien);
    RealmObjectBase.set(this, 'quanTriVien', quanTriVien);
    RealmObjectBase.set(this, 'ngayThamGia', ngayThamGia);
  }

  ThanhVienNhom._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  NhomChat? get nhom =>
      RealmObjectBase.get<NhomChat>(this, 'nhom') as NhomChat?;
  @override
  set nhom(covariant NhomChat? value) =>
      RealmObjectBase.set(this, 'nhom', value);

  @override
  NguoiDung? get thanhVien =>
      RealmObjectBase.get<NguoiDung>(this, 'thanhVien') as NguoiDung?;
  @override
  set thanhVien(covariant NguoiDung? value) =>
      RealmObjectBase.set(this, 'thanhVien', value);

  @override
  bool get quanTriVien =>
      RealmObjectBase.get<bool>(this, 'quanTriVien') as bool;
  @override
  set quanTriVien(bool value) =>
      RealmObjectBase.set(this, 'quanTriVien', value);

  @override
  DateTime get ngayThamGia =>
      RealmObjectBase.get<DateTime>(this, 'ngayThamGia') as DateTime;
  @override
  set ngayThamGia(DateTime value) =>
      RealmObjectBase.set(this, 'ngayThamGia', value);

  @override
  Stream<RealmObjectChanges<ThanhVienNhom>> get changes =>
      RealmObjectBase.getChanges<ThanhVienNhom>(this);

  @override
  Stream<RealmObjectChanges<ThanhVienNhom>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<ThanhVienNhom>(this, keyPaths);

  @override
  ThanhVienNhom freeze() => RealmObjectBase.freezeObject<ThanhVienNhom>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'nhom': nhom.toEJson(),
      'thanhVien': thanhVien.toEJson(),
      'quanTriVien': quanTriVien.toEJson(),
      'ngayThamGia': ngayThamGia.toEJson(),
    };
  }

  static EJsonValue _toEJson(ThanhVienNhom value) => value.toEJson();
  static ThanhVienNhom _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'quanTriVien': EJsonValue quanTriVien,
        'ngayThamGia': EJsonValue ngayThamGia,
      } =>
        ThanhVienNhom(
          fromEJson(id),
          fromEJson(quanTriVien),
          fromEJson(ngayThamGia),
          nhom: fromEJson(ejson['nhom']),
          thanhVien: fromEJson(ejson['thanhVien']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ThanhVienNhom._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      ThanhVienNhom,
      'ThanhVienNhom',
      [
        SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
        SchemaProperty(
          'nhom',
          RealmPropertyType.object,
          optional: true,
          linkTarget: 'NhomChat',
        ),
        SchemaProperty(
          'thanhVien',
          RealmPropertyType.object,
          optional: true,
          linkTarget: 'NguoiDung',
        ),
        SchemaProperty('quanTriVien', RealmPropertyType.bool),
        SchemaProperty('ngayThamGia', RealmPropertyType.timestamp),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TepDinhKemNhom extends _TepDinhKemNhom
    with RealmEntity, RealmObjectBase, RealmObject {
  TepDinhKemNhom(
    ObjectId maTepNhom,
    String tenTep,
    String duongDan, {
    TinNhanNhom? tinNhan,
  }) {
    RealmObjectBase.set(this, 'maTepNhom', maTepNhom);
    RealmObjectBase.set(this, 'tinNhan', tinNhan);
    RealmObjectBase.set(this, 'tenTep', tenTep);
    RealmObjectBase.set(this, 'duongDan', duongDan);
  }

  TepDinhKemNhom._();

  @override
  ObjectId get maTepNhom =>
      RealmObjectBase.get<ObjectId>(this, 'maTepNhom') as ObjectId;
  @override
  set maTepNhom(ObjectId value) =>
      RealmObjectBase.set(this, 'maTepNhom', value);

  @override
  TinNhanNhom? get tinNhan =>
      RealmObjectBase.get<TinNhanNhom>(this, 'tinNhan') as TinNhanNhom?;
  @override
  set tinNhan(covariant TinNhanNhom? value) =>
      RealmObjectBase.set(this, 'tinNhan', value);

  @override
  String get tenTep => RealmObjectBase.get<String>(this, 'tenTep') as String;
  @override
  set tenTep(String value) => RealmObjectBase.set(this, 'tenTep', value);

  @override
  String get duongDan =>
      RealmObjectBase.get<String>(this, 'duongDan') as String;
  @override
  set duongDan(String value) => RealmObjectBase.set(this, 'duongDan', value);

  @override
  Stream<RealmObjectChanges<TepDinhKemNhom>> get changes =>
      RealmObjectBase.getChanges<TepDinhKemNhom>(this);

  @override
  Stream<RealmObjectChanges<TepDinhKemNhom>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<TepDinhKemNhom>(this, keyPaths);

  @override
  TepDinhKemNhom freeze() => RealmObjectBase.freezeObject<TepDinhKemNhom>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'maTepNhom': maTepNhom.toEJson(),
      'tinNhan': tinNhan.toEJson(),
      'tenTep': tenTep.toEJson(),
      'duongDan': duongDan.toEJson(),
    };
  }

  static EJsonValue _toEJson(TepDinhKemNhom value) => value.toEJson();
  static TepDinhKemNhom _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'maTepNhom': EJsonValue maTepNhom,
        'tenTep': EJsonValue tenTep,
        'duongDan': EJsonValue duongDan,
      } =>
        TepDinhKemNhom(
          fromEJson(maTepNhom),
          fromEJson(tenTep),
          fromEJson(duongDan),
          tinNhan: fromEJson(ejson['tinNhan']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TepDinhKemNhom._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      TepDinhKemNhom,
      'TepDinhKemNhom',
      [
        SchemaProperty(
          'maTepNhom',
          RealmPropertyType.objectid,
          primaryKey: true,
        ),
        SchemaProperty(
          'tinNhan',
          RealmPropertyType.object,
          optional: true,
          linkTarget: 'TinNhanNhom',
        ),
        SchemaProperty('tenTep', RealmPropertyType.string),
        SchemaProperty('duongDan', RealmPropertyType.string),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TepDinhKemCaNhan extends _TepDinhKemCaNhan
    with RealmEntity, RealmObjectBase, RealmObject {
  TepDinhKemCaNhan(
    ObjectId maTepCaNhan,
    String tenTep,
    String duongDan, {
    TinNhanCaNhan? tinNhan,
  }) {
    RealmObjectBase.set(this, 'maTepCaNhan', maTepCaNhan);
    RealmObjectBase.set(this, 'tinNhan', tinNhan);
    RealmObjectBase.set(this, 'tenTep', tenTep);
    RealmObjectBase.set(this, 'duongDan', duongDan);
  }

  TepDinhKemCaNhan._();

  @override
  ObjectId get maTepCaNhan =>
      RealmObjectBase.get<ObjectId>(this, 'maTepCaNhan') as ObjectId;
  @override
  set maTepCaNhan(ObjectId value) =>
      RealmObjectBase.set(this, 'maTepCaNhan', value);

  @override
  TinNhanCaNhan? get tinNhan =>
      RealmObjectBase.get<TinNhanCaNhan>(this, 'tinNhan') as TinNhanCaNhan?;
  @override
  set tinNhan(covariant TinNhanCaNhan? value) =>
      RealmObjectBase.set(this, 'tinNhan', value);

  @override
  String get tenTep => RealmObjectBase.get<String>(this, 'tenTep') as String;
  @override
  set tenTep(String value) => RealmObjectBase.set(this, 'tenTep', value);

  @override
  String get duongDan =>
      RealmObjectBase.get<String>(this, 'duongDan') as String;
  @override
  set duongDan(String value) => RealmObjectBase.set(this, 'duongDan', value);

  @override
  Stream<RealmObjectChanges<TepDinhKemCaNhan>> get changes =>
      RealmObjectBase.getChanges<TepDinhKemCaNhan>(this);

  @override
  Stream<RealmObjectChanges<TepDinhKemCaNhan>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<TepDinhKemCaNhan>(this, keyPaths);

  @override
  TepDinhKemCaNhan freeze() =>
      RealmObjectBase.freezeObject<TepDinhKemCaNhan>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'maTepCaNhan': maTepCaNhan.toEJson(),
      'tinNhan': tinNhan.toEJson(),
      'tenTep': tenTep.toEJson(),
      'duongDan': duongDan.toEJson(),
    };
  }

  static EJsonValue _toEJson(TepDinhKemCaNhan value) => value.toEJson();
  static TepDinhKemCaNhan _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'maTepCaNhan': EJsonValue maTepCaNhan,
        'tenTep': EJsonValue tenTep,
        'duongDan': EJsonValue duongDan,
      } =>
        TepDinhKemCaNhan(
          fromEJson(maTepCaNhan),
          fromEJson(tenTep),
          fromEJson(duongDan),
          tinNhan: fromEJson(ejson['tinNhan']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TepDinhKemCaNhan._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      TepDinhKemCaNhan,
      'TepDinhKemCaNhan',
      [
        SchemaProperty(
          'maTepCaNhan',
          RealmPropertyType.objectid,
          primaryKey: true,
        ),
        SchemaProperty(
          'tinNhan',
          RealmPropertyType.object,
          optional: true,
          linkTarget: 'TinNhanCaNhan',
        ),
        SchemaProperty('tenTep', RealmPropertyType.string),
        SchemaProperty('duongDan', RealmPropertyType.string),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class KetBan extends _KetBan with RealmEntity, RealmObjectBase, RealmObject {
  KetBan(
    ObjectId id,
    String trangThai,
    DateTime ngayTao, {
    NguoiDung? nguoiGui,
    NguoiDung? nguoiNhan,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'nguoiGui', nguoiGui);
    RealmObjectBase.set(this, 'nguoiNhan', nguoiNhan);
    RealmObjectBase.set(this, 'trangThai', trangThai);
    RealmObjectBase.set(this, 'ngayTao', ngayTao);
  }

  KetBan._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  NguoiDung? get nguoiGui =>
      RealmObjectBase.get<NguoiDung>(this, 'nguoiGui') as NguoiDung?;
  @override
  set nguoiGui(covariant NguoiDung? value) =>
      RealmObjectBase.set(this, 'nguoiGui', value);

  @override
  NguoiDung? get nguoiNhan =>
      RealmObjectBase.get<NguoiDung>(this, 'nguoiNhan') as NguoiDung?;
  @override
  set nguoiNhan(covariant NguoiDung? value) =>
      RealmObjectBase.set(this, 'nguoiNhan', value);

  @override
  String get trangThai =>
      RealmObjectBase.get<String>(this, 'trangThai') as String;
  @override
  set trangThai(String value) => RealmObjectBase.set(this, 'trangThai', value);

  @override
  DateTime get ngayTao =>
      RealmObjectBase.get<DateTime>(this, 'ngayTao') as DateTime;
  @override
  set ngayTao(DateTime value) => RealmObjectBase.set(this, 'ngayTao', value);

  @override
  Stream<RealmObjectChanges<KetBan>> get changes =>
      RealmObjectBase.getChanges<KetBan>(this);

  @override
  Stream<RealmObjectChanges<KetBan>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<KetBan>(this, keyPaths);

  @override
  KetBan freeze() => RealmObjectBase.freezeObject<KetBan>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'nguoiGui': nguoiGui.toEJson(),
      'nguoiNhan': nguoiNhan.toEJson(),
      'trangThai': trangThai.toEJson(),
      'ngayTao': ngayTao.toEJson(),
    };
  }

  static EJsonValue _toEJson(KetBan value) => value.toEJson();
  static KetBan _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'trangThai': EJsonValue trangThai,
        'ngayTao': EJsonValue ngayTao,
      } =>
        KetBan(
          fromEJson(id),
          fromEJson(trangThai),
          fromEJson(ngayTao),
          nguoiGui: fromEJson(ejson['nguoiGui']),
          nguoiNhan: fromEJson(ejson['nguoiNhan']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(KetBan._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, KetBan, 'KetBan', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty(
        'nguoiGui',
        RealmPropertyType.object,
        optional: true,
        linkTarget: 'NguoiDung',
      ),
      SchemaProperty(
        'nguoiNhan',
        RealmPropertyType.object,
        optional: true,
        linkTarget: 'NguoiDung',
      ),
      SchemaProperty('trangThai', RealmPropertyType.string),
      SchemaProperty('ngayTao', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
