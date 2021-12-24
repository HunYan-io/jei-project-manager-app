import 'package:flutter/material.dart';
import 'package:jei_project_manager_app/models/Task.dart';
import 'package:jei_project_manager_app/widgets/task_tab.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({Key? key}) : super(key: key);

  List<Task> data = [
    Task(
        name: 'task1',
        project: "project",
        description: "description",
        deadline: "deadline"),
    Task(
        name: 'task2',
        project: "project",
        description: "description",
        deadline: "deadline"),
    Task(
        name: 'task3',
        project: "project",
        description: "description",
        deadline: "deadline"),
  ];
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tasks'),
            centerTitle: true,
            backgroundColor: Color(0xff171a33),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            bottom: TabBar(tabs: [
              Tab(
                text: 'to do ',
              ),
              Tab(
                text: 'doing',
              ),
              Tab(text: 'done'),
            ]),
          ),
          body: TabBarView(
            children: [
              TaskTab(
                tasks: data,
                location: 'to do',
                moveToStatus: ['doing', 'done'],
              ),
              TaskTab(
                tasks: data,
                location: 'doing',
                moveToStatus: ['to do', 'done'],
              ),
              TaskTab(
                tasks: data,
                location: 'done',
                moveToStatus: ['to do', 'doing'],
              ),
            ],
          ),
        ),
      );
}
