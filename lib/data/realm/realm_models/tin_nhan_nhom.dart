part of models;

@RealmModel()
abstract class _TinNhanNhom {
  @PrimaryKey()
  late ObjectId maTinNhanNhom;
  late _NhomChat? nhom;
  late _NguoiDung? nguoiGui;
  late String noiDung;
  late String kieuTinNhan;  //text or image
  late bool ghim = false;
  late DateTime thoiGianGui;
  late String duongDanAnh;  //Nếu kiểu tin nhắn là image thì đây là đường dẫn của ảnh

  late ObjectId maNhom;
  late ObjectId maNguoiGui;

  @Backlink(#tinNhan)
  late Iterable<_TepDinhKemNhom> tepDinhKem;
}