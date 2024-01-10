import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Pages/account_page.dart';
import 'Pages/doneTask_page.dart';
import 'Pages/task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Widget> pages = [
    const DoneTask(),
    const TaskPage(),
    const AccountPage()
  ];

  int selectedIndex = 1;

  void navigationBarIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,

        ),

        child: GNav(
      
          backgroundColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).disabledColor,
          activeColor: Colors.white,
          iconSize: 30,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          gap: 8,
          selectedIndex: selectedIndex,
          padding: const EdgeInsets.all(10),
          // tabBackgroundColor:const Color.fromARGB(255, 55, 0, 253),

          onTabChange: (index) {
            navigationBarIndex(index);
          },
      
          tabs: const [
            GButton(icon: Icons.task, text: 'Выполнено'),
      
            GButton(icon: Icons.list, text: 'Задания'),
      
            GButton(icon: Icons.account_circle_rounded, text: 'Аккаунт'),
          ],
        ),
      ),

      body: pages[selectedIndex],

    );
  }
}