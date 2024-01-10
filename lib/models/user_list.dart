
import 'package:hive_flutter/adapters.dart';

part 'user_list.g.dart';

@HiveType(typeId: 3)
class User {

  @HiveField(0)
  String name;

  @HiveField(1)
  String password;

  User({required this.name, required this.password});
}