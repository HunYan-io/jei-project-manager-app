import 'package:flutter/material.dart';
import 'package:jei_project_manager_app/models/task.dart';
import 'package:jei_project_manager_app/services/auth_service.dart';
import 'package:jei_project_manager_app/widgets/task_tab.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({Key? key}) : super(key: key);

  List<Task> data = [
    Task(
      name: 'task1',
      project: 0,
      description: "description",
      deadline: DateTime.now(),
      status: "to do",
    ),
    Task(
      name: 'task2',
      project: 0,
      description: "description",
      deadline: DateTime.now(),
      status: "to do",
    ),
    Task(
      name: 'task3',
      project: 0,
      description: "description",
      deadline: DateTime.now(),
      status: "to do",
    ),
  ];
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tasks'),
            centerTitle: true,
            backgroundColor: const Color(0xff171a33),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            bottom: const TabBar(tabs: [
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
                admin: authService.isAdmin,
              ),
              TaskTab(
                tasks: data,
                location: 'doing',
                moveToStatus: ['to do', 'done'],
                admin: authService.isAdmin,
              ),
              TaskTab(
                tasks: data,
                location: 'done',
                moveToStatus: ['to do', 'doing'],
                admin: authService.isAdmin,
              ),
            ],
          ),
        ),
      );
}
