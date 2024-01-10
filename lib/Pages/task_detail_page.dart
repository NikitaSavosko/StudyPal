import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:study_pal/models/subjects_list.dart';
import 'package:study_pal/models/task_list.dart';

import '../Data/data_base.dart';

class TaskDetailPage extends StatefulWidget {

  final Tasks task;
  final Subject subject;
  final int taskIndex;
  final int subjectIndex;

  const TaskDetailPage({Key? key, required this.task, required this.subject, required this.taskIndex, required this.subjectIndex}) : super(key: key);

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {

  final _myBox = Hive.box('myBox');
  late toDoDataBase db = toDoDataBase();
  bool isDone = true;

  @override
  void initState() {
    super.initState();

    if (_myBox.get('subjectList') == null || _myBox.get('userList') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void changeTask(bool done, int taskIndex, int subjectIndex) {
    setState(() {
      db.subjects[subjectIndex].tasks[taskIndex].finished = done;
    });

    db.updateDataBase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
              
                    IconButton(
                      onPressed:() {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)
                    ),
              
                    const SizedBox(
                      width: 20,
                    ),
              
                    Expanded(
                      child: Text(
                        widget.subject.name,
                        softWrap: true,
                        // overflow: TextOverflow.clip,
                        maxLines: 3,
                    
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 30
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Text(
                      widget.task.name,
              
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  'Сложность: ${widget.task.difficulty}',
              
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.grey[600]
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 5),
                alignment: Alignment.centerLeft,

                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    spreadRadius: 2,
                  )]
                ),

                child: Row(
                  textBaseline: TextBaseline.alphabetic,

                  children: [
                    const Icon(Icons.my_library_books_rounded, textDirection: TextDirection.ltr,),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child: Text(
                        widget.task.description == '' ? 'Нажмите, чтобы открыть' : widget.task.description,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                                      
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.grey[700]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Container(
              
                width: 140,
              
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
              
                  borderRadius: BorderRadius.circular(20)
                ),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
              
                    const Icon(Icons.help_outline, color: Colors.white, size: 30,),
              
                    const SizedBox(width: 5,),
              
                    Text(
                      'Помощь',
              
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(right: 20),

                decoration: BoxDecoration(
                  color: widget.task.finished ? Colors.green[400] : Colors.grey[900],
                  borderRadius: BorderRadius.circular(100),

                  boxShadow: [BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    spreadRadius: 2
                  )]
                ),

                child: IconButton(
                  disabledColor: Theme.of(context).colorScheme.primary,
                  color: Colors.grey[200],
                  highlightColor: const Color.fromARGB(255, 0, 128, 255),
                  iconSize: 36,
                  onPressed:() {
                      if (widget.task.finished != isDone) {
                        changeTask(isDone, widget.taskIndex, widget.subjectIndex);
                      }
                      else {
                        isDone = !isDone;
                        changeTask(isDone, widget.taskIndex, widget.subjectIndex);
                      }
                  },
                  icon: widget.task.finished ? const Icon(Icons.done) : const Icon(Icons.link)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}