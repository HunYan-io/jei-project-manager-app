import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:jei_project_manager_app/models/task.dart';
import 'package:focused_menu/modals.dart';

class TaskTab extends StatefulWidget {
  bool admin = false;
  List<Task> tasks;
  String location = '';
  List<String> moveToStatus;
  TaskTab({
    Key? key,
    required this.tasks,
    required this.location,
    required this.moveToStatus,
    required this.admin,
  }) : super(key: key);

  @override
  _taskTabState createState() => _taskTabState();
}

class _taskTabState extends State<TaskTab> {
  Task input = Task(
    name: '',
    project: 0,
    description: "description",
    deadline: DateTime.now(),
    status: "to do",
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0.0),
        itemCount: widget.tasks.length + 20,
        itemBuilder: (BuildContext context, int index) {
          if (widget.admin) {
            return FocusedMenuHolder(
              onPressed: () {},
              menuWidth: MediaQuery.of(context).size.width * 0.3,
              menuItems: <FocusedMenuItem>[
                for (var statusName in widget.moveToStatus)
                  FocusedMenuItem(
                      title: Text('move to $statusName'),
                      onPressed: () {
                        print(statusName);
                      })
              ],
              child: Card(
                  child: ListTile(
                      title:
                          Text(widget.tasks[index % widget.tasks.length].name),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Color(0xff8a2831),
                          ),
                          onPressed: () {
                            setState(() {
                              widget.tasks.removeAt(index);
                            });
                          }))),
            );
          } else {
            return FocusedMenuHolder(
              onPressed: () {},
              menuWidth: MediaQuery.of(context).size.width * 0.3,
              menuItems: <FocusedMenuItem>[
                for (var statusName in widget.moveToStatus)
                  FocusedMenuItem(
                      title: Text('move to $statusName'),
                      onPressed: () {
                        print(statusName);
                      })
              ],
              child: Card(
                  child: ListTile(
                title: Text(widget.tasks[index % widget.tasks.length].name),
              )),
            );
          }
        });
  }
}
