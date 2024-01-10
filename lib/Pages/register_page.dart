import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../Data/data_base.dart';
import '../models/user_list.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _myBox = Hive.box('myBox');
  late toDoDataBase db = toDoDataBase();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordCheckController = TextEditingController();
  bool passwordTextObscure = true;
  bool passwordCheckObscure = true;
  double radius = 10;

  @override
  void initState() {
    super.initState();

    if (_myBox.get('subjectList') == null || _myBox.get('userList') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void addAccount(String name, String password) {
    setState(() {
      // db.users[0].name = name;
      // db.users[0].password = password;
      db.users.add(User(name: name, password: password));
      // db.users.clear();
    });

    db.updateDataBase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      
          Center(
            child: Text(
              'StudyPal',
          
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 35
              ),
            ),
          ),
      
          const SizedBox(
            height: 50,
          ),
      
          Container(
      
            padding: const EdgeInsets.only(left: 20, right: 5),
      
            child: Text(
              'Добро пожаловать!\nЗарегистрируйтесь для работы в приложении',
            
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
      
      
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 30),
      
            child: TextFormField(
              controller: nameController,
              textCapitalization: TextCapitalization.sentences,
              
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Имя',
      
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius)
                ),
      
                prefixIcon: const Icon(Icons.account_circle_rounded)
              ),
      
            ),
          ),
      
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 30),
      
            child: TextFormField(
              controller: passwordController,
              obscureText: passwordTextObscure,
              
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Пароль',
      
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius)
                ),
      
                suffixIcon: IconButton(
                  onPressed:() {
                    setState(() {
                      passwordTextObscure = !passwordTextObscure;
                    });
                  }, 
                  icon: Icon(passwordTextObscure ? Icons.visibility : Icons.visibility_off)
                ),
      
                prefixIcon: const Icon(Icons.lock)
              ),
            ),
          ),
      
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 30),
      
            child: TextFormField(
              controller: passwordCheckController,
              obscureText: passwordCheckObscure,
              
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Повторите пароль',
      
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius)
                ),
      
                suffixIcon: IconButton(
                  onPressed:() {
                    setState(() {
                      passwordCheckObscure = !passwordCheckObscure;
                    });
                  }, 
                  icon: Icon(passwordCheckObscure ? Icons.visibility : Icons.visibility_off)
                ),
      
                prefixIcon: const Icon(Icons.lock)
              ),
            ),
          ),
      
          const SizedBox(
            height: 70,
          ),
      
          ElevatedButton(
            onPressed:() {
              if(passwordController.text == passwordCheckController.text && nameController.text != ''  && passwordController.text != '') {
                addAccount(nameController.text, passwordController.text);
                Navigator.pushNamed(context, '/HomePage');
              }
            },
      
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
              overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
              padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
              ),
      
            child: Text(
              'Зарегистрироваться',
      
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white
              )
            ),
          ),
        ],
      ),
    );
  }
}