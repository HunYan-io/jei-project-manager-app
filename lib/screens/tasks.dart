import 'package:flutter/material.dart';
import 'package:jei_project_manager_app/tabs/doing.dart';
import 'package:jei_project_manager_app/tabs/todo.dart';
import 'package:jei_project_manager_app/tabs/done.dart';



class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>DefaultTabController(length: 3, child: Scaffold(
    appBar: AppBar(
      title: Text('Tasks'),
      centerTitle: true,
      backgroundColor: Color(0xff171a33),
      leading: IconButton(
        icon: Icon(Icons.arrow_back
      ), onPressed: () {  },
      ),
      bottom: TabBar(
          tabs: [
            Tab(text: 'to do ',),
            Tab(text: 'doing',),
            Tab(text: 'done'),
          ]
      ),
    ),
    body: TabBarView(
      children: [
        todo(),
        doing(),
        done(),
      ],
    ),
    ),
  );
}

