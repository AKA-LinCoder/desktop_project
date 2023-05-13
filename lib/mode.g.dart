// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mode.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class People extends _People with RealmEntity, RealmObjectBase, RealmObject {
  People(
    String name,
    int age,
  ) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'age', age);
  }

  People._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get age => RealmObjectBase.get<int>(this, 'age') as int;
  @override
  set age(int value) => RealmObjectBase.set(this, 'age', value);

  @override
  Stream<RealmObjectChanges<People>> get changes =>
      RealmObjectBase.getChanges<People>(this);

  @override
  People freeze() => RealmObjectBase.freezeObject<People>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(People._);
    return const SchemaObject(ObjectType.realmObject, People, 'People', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('age', RealmPropertyType.int),
    ]);
  }
}

class Car extends _Car with RealmEntity, RealmObjectBase, RealmObject {
  Car(
    int id,
    String brand, {
    People? owner,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'brand', brand);
    RealmObjectBase.set(this, 'owner', owner);
  }

  Car._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get brand => RealmObjectBase.get<String>(this, 'brand') as String;
  @override
  set brand(String value) => RealmObjectBase.set(this, 'brand', value);

  @override
  People? get owner => RealmObjectBase.get<People>(this, 'owner') as People?;
  @override
  set owner(covariant People? value) =>
      RealmObjectBase.set(this, 'owner', value);

  @override
  Stream<RealmObjectChanges<Car>> get changes =>
      RealmObjectBase.getChanges<Car>(this);

  @override
  Car freeze() => RealmObjectBase.freezeObject<Car>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Car._);
    return const SchemaObject(ObjectType.realmObject, Car, 'Car', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('brand', RealmPropertyType.string),
      SchemaProperty('owner', RealmPropertyType.object,
          optional: true, linkTarget: 'People'),
    ]);
  }
}
