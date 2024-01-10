// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_pal/models/task_list.dart';
import '../Data/data_base.dart';

class DoneTask extends StatefulWidget {
  const DoneTask({Key? key}) : super(key: key);

  @override
  State<DoneTask> createState() => _DoneTaskState();
}

class _DoneTaskState extends State<DoneTask> {
  final _myBox = Hive.box('myBox');
  late toDoDataBase db = toDoDataBase();

  @override
  void initState() {
    super.initState();

    if (_myBox.get('subjectList') == null || _myBox.get('userList') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void pressedButton(int index) {
    setState(() {
      for (int i = 0; i < db.subjects.length; i++) {
        db.subjects[i].pressed = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 100),
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20, top: 20, left: 30),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: db.subjects.length,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 6),
                      width: 188,
                      child: OutlinedButton(
                        onPressed: () {
                          pressedButton(index);
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: db.subjects[index].pressed
                              ? Theme.of(context).colorScheme.primary
                              : const Color.fromARGB(245, 245, 245, 245),
                          side: BorderSide(
                              color: db.subjects[index].pressed
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black26),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                        ),
                        child: Text(
                          db.subjects[index].name,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                color: db.subjects[index].pressed
                                    ? Colors.white
                                    : Colors.grey[900],
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: db.subjects.length,
                itemBuilder: (BuildContext context, subjectIndex) {
                  final subject = db.subjects[subjectIndex];
                  final List<Tasks> finishedTasks = subject.tasks.where((task) => task.finished).toList();

                  return Visibility(
                    visible: subject.pressed,
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: finishedTasks.length,
                      itemBuilder: (BuildContext context, taskIndex) {
                        final task = finishedTasks[taskIndex];

                        return Container(
                          padding: const EdgeInsets.only(right: 5, left: 20, top: 20, bottom: 20),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                blurRadius: 10,
                                spreadRadius: 2
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                task.name,
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                              Text(
                                task.description,
                                style: Theme.of(context).textTheme.labelSmall,
                                softWrap: false,
                              ),
                              Text(
                                "Сложность: ${task.difficulty}",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
