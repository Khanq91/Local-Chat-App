part of models;

@RealmModel()
abstract class _KetBan {
  @PrimaryKey()
  late ObjectId id;

  late _NguoiDung? nguoiGui;
  late _NguoiDung? nguoiNhan;

  late String trangThai; // 'pending', 'accepted', 'rejected'
  late DateTime ngayTao;
}