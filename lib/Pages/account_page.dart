import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Data/data_base.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  
  final _myBox = Hive.box('myBox');
  late toDoDataBase db = toDoDataBase();

  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (_myBox.get('subjectList') == null || _myBox.get('userList') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void changeName(String newName) {
    setState(() {
      db.users[0].name = newName;
    });

    db.updateDataBase();
  }

  void changeNameDialog() {
    
    showDialog(
      context: context, 
      builder:(BuildContext context) {
        return StatefulBuilder(
          builder:(context, setState) {
            return AlertDialog(
          title: const Text('Введите новое имя'),
          surfaceTintColor: Theme.of(context).canvasColor,

          contentPadding: const EdgeInsets.all(10),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
  
              TextFormField(
                controller: nameController,

                decoration: const InputDecoration(
                  hintText: 'Новое имя',
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите новое имя';
                  }

                  return null;
                },
              ),

              Container(
                height: 10,
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
        
                  ElevatedButton(
                    onPressed:() {
                      setState(() {
                        Navigator.pop(context);
                        nameController.clear();
                      });
                    },
        
                      child: const Text(
                        'Отмена'
                      ),
                  ),

                  Container(
                    width: 10,
                  ),

                  ElevatedButton(
                    onPressed:() {

                        if(nameController.text.isEmpty || nameController.text == '') {
                          return;
                        }

                        else {
                          changeName(nameController.text);
                          Navigator.pop(context);
                          nameController.clear();
                        }
                    },
        
                      child: const Text(
                        'Ok'
                      ),
                  ),
                ],
              ),
            ],
          ),
        );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
          children: [
            const Icon(
              Icons.account_circle_rounded,
              size: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    db.users[0].name,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  IconButton(
                    onPressed:() {
                      setState(() {
                        changeNameDialog();
                      });
                    },
                    icon: const Icon(Icons.manage_accounts), // Поменять иконку
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Все задания:",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
            ),
            ListView.builder(
              itemCount: db.subjects.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                return Container(
                  padding: const EdgeInsets.only(left: 20, right: 5, top: 20, bottom: 20),
                  margin: const EdgeInsets.only(bottom: 20),
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
                    children: [
                      Text(
                        db.subjects[index].name,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        "${db.subjects[index].tasks.length} практических заданий",
                        softWrap: false,
                        style: Theme.of(context).textTheme.labelSmall,
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
