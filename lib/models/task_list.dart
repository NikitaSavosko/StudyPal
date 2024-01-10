
import 'package:hive_flutter/adapters.dart';

part 'task_list.g.dart';

@HiveType(typeId: 2)
class Tasks {

  @HiveField(0)
  final String description;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String difficulty;

  @HiveField(3)
  bool finished;

  Tasks({
      required this.description,
      required this.name,
      required this.difficulty,
      required this.finished,
  });

}