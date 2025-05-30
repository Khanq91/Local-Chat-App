part of models;

@RealmModel()
abstract class _TepDinhKemNhom {
  @PrimaryKey()
  late ObjectId maTepNhom;
  late _TinNhanNhom? tinNhan;
  late String tenTep;
  late String duongDan;
}