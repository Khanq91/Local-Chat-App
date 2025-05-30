part of models;

@RealmModel()
abstract class _TinNhanCaNhan {
  @PrimaryKey()
  late ObjectId maTinNhanCaNhan;
  late _NguoiDung? nguoiGui;
  late _NguoiDung? nguoiNhan;
  late String noiDung;
  late String kieuTinNhan;  //text or image
  late bool ghim = false;
  late DateTime thoiGianGui;
  late String duongDanAnh;  //Nếu kiểu tin nhắn là image thì đây là đường dẫn của ảnh

  @Backlink(#tinNhan)
  late Iterable<_TepDinhKemCaNhan> tepDinhKem;
}