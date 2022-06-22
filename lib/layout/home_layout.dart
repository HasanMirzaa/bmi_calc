import 'package:bmi_calc/modules/AppBar/archived_tasks_screen.dart';
import 'package:bmi_calc/modules/AppBar/done_tasks_screen.dart';
import 'package:bmi_calc/modules/AppBar/new_tasks_screen.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = const [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getName()
              .then((value) => {
                    print(value),
                  })
              .catchError((error) {
            print('error ${error.toString()}');
          });
          // try {
          //   var name = await getName();
          //   print(name);
          // } catch (error) {
          //   print('error ${error.toString()}');
          // }
        },
        child: const Icon(Icons.add),
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
}
