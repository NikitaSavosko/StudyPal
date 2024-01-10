import 'package:hive_flutter/hive_flutter.dart';
import 'task_list.dart';

part 'subjects_list.g.dart';

@HiveType(typeId: 1)

class Subject {

  @HiveField(0)
  final String name;

  @HiveField(1)
  bool pressed;

  @HiveField(2)
  final List<Tasks> tasks;

  Subject({
      required this.name,
      required this.pressed,
      required this.tasks
  });

    
}
