import 'package:hive/hive.dart';
import '../models/subjects_list.dart';
import '../models/task_list.dart';
import '../models/user_list.dart';

// ignore: camel_case_types
class toDoDataBase {

  List<Subject> subjects = [];
  List<User> users = [];
  List<Tasks> tasks = [];

  final _myBox = Hive.box("myBox");

  void createInitialData() {
    subjects = [
      Subject(name: "Операционные системы", pressed: true, tasks: [
        Tasks(name: "Мастерство в управлении ОС", 
        description: "Исследование основных функций операционных систем и практические задачи по эффективному управлению ресурсами и процессами.", 
        difficulty: "Сложно", 
        finished: true),
        Tasks(name: "Эволюция интерфейсов: От командной строки до графического интерфейса", 
        description: "Анализ и сравнение различных интерфейсов ОС на протяжении времени и их влияние на пользовательский опыт.", 
        difficulty: "Легко", 
        finished: false),
        Tasks(name: "Управление ресурсами", 
        description: "Создайте программу, которая мониторит использование ресурсов системы и оптимизирует их распределение для улучшения производительности.", 
        difficulty: "Сложно", 
        finished: false),
        Tasks(name: "Сравнение ОС", 
        description: "Проведите исследование и сравните различные операционные системы по параметрам производительности, безопасности и удобству использования.", 
        difficulty: "Нормально", 
        finished: false),
        Tasks(name: "Эмуляция ОС", 
        description: "Напишите статью о процессе эмуляции одной операционной системы внутри другой и объясните ее преимущества и недостатки.", 
        difficulty: "Нормально", 
        finished: true),
      ]),
      Subject(name: "Компьютерные сети", pressed: false, tasks: [
        Tasks(name: "Сетевая архитектура: Построение и обслуживание", 
        description: "Создание и настройка сетевых архитектур, изучение методов обеспечения безопасности и управления данными в сетях.", 
        difficulty: "Легко", 
        finished: false),
        Tasks(name: "Инновации в сетевых технологиях", 
        description: "Рассмотрение новейших тенденций в компьютерных сетях, включая IoT, облачные вычисления и их влияние на современные бизнес-процессы.", 
        difficulty: "Сложно", 
        finished: true),
        Tasks(name: "Настройка сетевого оборудования", 
        description: "Проведите практическую лабораторную работу по настройке маршрутизатора и коммутатора для создания рабочей локальной сети.", 
        difficulty: "Сложно", 
        finished: false),
        Tasks(name: "Безопасность в сетях", 
        description: "Подготовьте презентацию о методах защиты информации в компьютерных сетях и их роли в современных бизнес-процессах.", 
        difficulty: "Легко", 
        finished: true),
      ]),
      Subject(name: "Электронный офис", pressed: false, tasks: [
        Tasks(name: "Оптимизация рабочего пространства: Эффективное использование офисных приложений", 
        description: "Практические упражнения по оптимизации работы в офисных приложениях для повышения производительности и эффективности.", 
        difficulty: "Нормально", 
        finished: true),
        Tasks(name: "Коллаборативные инструменты для бизнеса", 
        description: "Исследование и практическое применение инструментов электронного офиса для совместной работы и командного взаимодействия.", 
        difficulty: "Сложно", 
        finished: false),
        Tasks(name: "Оптимизация рабочего процесса", 
        description: "Составьте руководство по оптимизации рабочего процесса с использованием офисных приложений для повышения эффективности работы.", 
        difficulty: "Нормально", 
        finished: false),
        Tasks(name: "Виртуальные конференции и совещания", 
        description: "Проведите исследование о преимуществах и недостатках использования виртуальных инструментов для проведения конференций и совещаний.", 
        difficulty: "Легко", 
        finished: true),
      ]),
      Subject(name: "Оргтехника", pressed: false, tasks: [
        Tasks(name: "Продуктивное использование офисной техники", 
        description: "Изучение и практика основных функций и оптимизация использования принтеров, сканеров, копировальных аппаратов и другой оргтехники.", 
        difficulty: "Нормально", 
        finished: true),
        Tasks(name: "Управление офисной техникой: Решение проблем и техническое обслуживание", 
        description: "Навыки по диагностике, устранению неполадок и обслуживанию оргтехники для обеспечения бесперебойной работы в офисе.", 
        difficulty: "Сложно", 
        finished: true),
        Tasks(name: "Техническое обслуживание принтера", 
        description: "Подготовьте пошаговое руководство по техническому обслуживанию принтера для предотвращения возможных проблем.", 
        difficulty: "Легко", 
        finished: true),
        Tasks(name: "Выбор оргтехники для офиса", 
        description: "Проведите исследование рынка и подготовьте отчет о лучших моделях принтеров/сканеров для использования в офисе.", 
        difficulty: "Легко", 
        finished: false),
      ]),
      Subject(name: "Основы вычислительной техники", pressed: false, tasks: [
        Tasks(name: "Исследование процессорных архитектур", 
        description: "Проведите обзор различных процессорных архитектур, объясните их функции и применение в современных компьютерах.", 
        difficulty: "Легко", 
        finished: false),
        Tasks(name: "Развитие хранилищ данных", 
        description: "Составьте презентацию о развитии и инновациях в области устройств хранения данных от первых жестких дисков до современных SSD и облачных хранилищ.", 
        difficulty: "Нормально", 
        finished: false),
        Tasks(name: "Изучение архитектуры компьютеров", 
        description: "Обзор основных компонентов компьютера, их функций и взаимодействия для понимания работы вычислительной техники.", 
        difficulty: "Легко", 
        finished: false),
      ]),
    ];

  }

  void loadData() {
    subjects = _myBox.get('subjectList').cast<Subject>();
    users = _myBox.get('userList').cast<User>();
  }

  void updateDataBase() {
    _myBox.put('subjectList', subjects);
    _myBox.put('userList', users);
  }

}