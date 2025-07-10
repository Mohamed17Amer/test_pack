import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class UserEntityWithPhone extends HiveObject {
  UserEntityWithPhone({this.phone, this.uid});
  @HiveField(0)
  String? phone;
  @HiveField(1)
  String? uid;
}

// flutter packages pub run build_runner build
// dart run build_runner build
