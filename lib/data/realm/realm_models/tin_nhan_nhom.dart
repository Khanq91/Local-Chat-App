part of models;

@RealmModel()
abstract class _TinNhanNhom {
  @PrimaryKey()
  late ObjectId maTinNhanNhom;
  late _NhomChat? nhom;
  late _NguoiDung? nguoiGui;
  late String noiDung;
  late String kieuTinNhan;
  late bool ghim = false;
  late DateTime thoiGianGui;

  @Backlink(#tinNhan)
  late Iterable<_TepDinhKemNhom> tepDinhKem;
}