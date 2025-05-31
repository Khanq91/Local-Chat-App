part of models;

@RealmModel()
abstract class _NhomChat {
  @PrimaryKey()
  late ObjectId maNhom;
  late String tenNhom;
  late bool riengTu;
  late _NguoiDung? nguoiTao;
  late DateTime ngayTao;
  String? anhNhom;

  late ObjectId maNguoiTao;

  @Backlink(#nhom)
  late Iterable<_ThanhVienNhom> danhSachThanhVien;

  @Backlink(#nhom)
  late Iterable<_TinNhanNhom> danhSachTinNhan;
}