part of models;

@RealmModel()
abstract class _TinNhanCaNhan {
  @PrimaryKey()
  late ObjectId maTinNhanCaNhan;
  late _NguoiDung? nguoiGui;
  late _NguoiDung? nguoiNhan;
  late String noiDung;
  late String kieuTinNhan;
  late bool ghim = false;
  late DateTime thoiGianGui;

  @Backlink(#tinNhan)
  late Iterable<_TepDinhKemCaNhan> tepDinhKem;
}