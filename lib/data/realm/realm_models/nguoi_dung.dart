part of models;

@RealmModel()
abstract class _NguoiDung {
  @PrimaryKey()
  late ObjectId maNguoiDung;
  late String tenDangNhap;
  late String matKhau;
  String? hoTen;
  String? anhDaiDien;
  late bool trangThai;
  late String vaiTro;
  late DateTime ngayTao;

  @Backlink(#nguoiGui)
  late Iterable<_TinNhanNhom> tinNhanNhomGui;

  @Backlink(#nguoiGui)
  late Iterable<_TinNhanCaNhan> tinNhanCaNhanGui;

  @Backlink(#nguoiNhan)
  late Iterable<_TinNhanCaNhan> tinNhanCaNhanNhan;

  @Backlink(#nguoiTao)
  late Iterable<_NhomChat> nhomTao;

  @Backlink(#thanhVien)
  late Iterable<_ThanhVienNhom> danhSachNhomThamGia;

  @Backlink(#nguoiGui)
  late Iterable<_KetBan> loiMoiKetBanDaGui;

  @Backlink(#nguoiNhan)
  late Iterable<_KetBan> loiMoiKetBanDaNhan;
}