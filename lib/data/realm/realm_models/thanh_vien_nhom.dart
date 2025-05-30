part of models;

@RealmModel()
abstract class _ThanhVienNhom {
  @PrimaryKey()
  late ObjectId id;

  late _NhomChat? nhom;
  late _NguoiDung? thanhVien;
  late bool quanTriVien;
  late DateTime ngayThamGia;
}