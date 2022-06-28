import 'package:bmi_calc/modules/AppBar/archived_tasks_screen.dart';
import 'package:bmi_calc/modules/AppBar/done_tasks_screen.dart';
import 'package:bmi_calc/modules/AppBar/new_tasks_screen.dart';
import 'package:bmi_calc/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../shared/components/constants.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();

    createDB();
  }

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen()
  ];

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  late Database db;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: ConditionalBuilder(
        condition: tasks.isNotEmpty,
        builder: (context) => screens[currentIndex],
        fallback: (context) => const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              insertIntoDb(titleController.text, timeController.text,
                      dateController.text)
                  .then((value) {
                Navigator.pop(context);

                getDataFromDatabase(db).then((value) {
                  setState(() {
                    fabIcon = Icons.edit;
                    isBottomSheetShown = false;

                    tasks = value;
                    print(tasks);
                  });
                });
              });
            }
          } else {
            scaffoldKey.currentState
                ?.showBottomSheet(
                    (context) => Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultTextFormField(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'title must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Title',
                                    prefixIcon: Icons.title),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultTextFormField(
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'time must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Time',
                                    prefixIcon: Icons.watch_later_outlined,
                                    onTab: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) => {
                                                timeController.text =
                                                    value!.format(context),
                                              });
                                    }),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultTextFormField(
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'Date must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Date',
                                    prefixIcon: Icons.calendar_today,
                                    onTab: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2025-05-03'))
                                          .then((value) => {
                                                dateController.text =
                                                    DateFormat.yMMMd()
                                                        .format(value!),
                                              });
                                    })
                              ],
                            ),
                          ),
                        ),
                    elevation: 20.0)
                .closed
                .then((value) => {
                      isBottomSheetShown = false,
                      setState(() {
                        fabIcon = Icons.edit;
                      })
                    });
            isBottomSheetShown = true;

            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child: Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: 'Done'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'Archived'),
        ],
      ),
    );
  }

  Future<String> getName() async {
    return ('Hasan Ahmad');
  }

  void createDB() async {
    db = await openDatabase('todo69.db', version: 1, onCreate: (db, version) {
      print('database created');
      db
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('Table created');
      }).catchError((error) {
        print('Error is ${error.toString()}');
      });
    }, onOpen: (db) {
      getDataFromDatabase(db).then((value) {
        setState(() {
          tasks = value;
          print(tasks);
        });
      });
      print('database opened');
    });
  }

  Future insertIntoDb(String title, String time, String date) async {
    return await db.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('When insert Error is $error');
      });
      return Future.value(null);
    });
  }

  Future<List<Map>> getDataFromDatabase(db) async {
    return await db.rawQuery('SELECT * FROM tasks');
  }
}
