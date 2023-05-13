import 'package:realm/realm.dart';
part 'mode.g.dart';

/**
 * flutter pub run realm generate
 */
@RealmModel()
class _People{
  late String name;
  late int age;
}
//Realm 本地数据库一般用于缓存数据
@RealmModel()
class _Car{
  @PrimaryKey()
  late int id;
  late String brand;
  _People? owner;
}