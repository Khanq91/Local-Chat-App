part of models;

@RealmModel()
abstract class _TepDinhKemCaNhan {
  @PrimaryKey()
  late ObjectId maTepCaNhan;
  late _TinNhanCaNhan? tinNhan;
  late String LoaiTep;
  late String tenTep;
  late String duongDan;
}