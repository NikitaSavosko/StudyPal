// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_pal/Pages/register_page.dart';
import 'package:study_pal/home_page.dart';
import 'package:study_pal/models/subjects_list.dart';
import 'package:study_pal/models/task_list.dart';
import 'package:study_pal/models/user_list.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(TasksAdapter());
  Hive.registerAdapter(UserAdapter());
  var box = await Hive.openBox('myBox');

  var isUserRegistered = box.containsKey('userList');

  runApp(StudyPal(isUserRegistered: isUserRegistered));
}


class StudyPal extends StatelessWidget {
  final bool isUserRegistered;

  const StudyPal({Key? key, required this.isUserRegistered}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {
      '/HomePage': (context) => const HomePage(),
      '/RegisterPage':(context) => const RegisterPage()
    },

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 55, 0, 255)),
        scaffoldBackgroundColor: const Color.fromARGB(245, 245, 245, 245),
        disabledColor: const Color.fromARGB(255, 146, 146, 255),
        // primaryColor: const Color.fromARGB(255, 58, 0, 232),
        shadowColor: const Color(0x66DBDBDB),
        canvasColor: const Color.fromARGB(245, 245, 245, 245),

        textTheme: GoogleFonts.latoTextTheme().copyWith(
          displayMedium: GoogleFonts.yesevaOne(
            color: const Color(0xFF202020),
            fontSize: 20,
          ),

          labelMedium: GoogleFonts.montserrat(
            color: const Color(0xFF202020),
            fontSize: 15,
            fontWeight: FontWeight.normal
          ),

          labelSmall: GoogleFonts.montserrat(
            color: const Color(0xFFAEAEAE),
            fontSize: 15,
          )
        )
      ),

      home: isUserRegistered ? const HomePage() : const RegisterPage(),
    );
  }
}