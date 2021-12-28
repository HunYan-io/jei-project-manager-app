import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:jei_project_manager_app/models/project.dart';

import 'package:jei_project_manager_app/models/task.dart';
import 'package:jei_project_manager_app/services/task_service.dart';
import 'package:jei_project_manager_app/widgets/delete_dialog.dart';

class TaskTab extends StatefulWidget {
  final bool admin;
  final List<Task> tasks;
  final String location;
  final List<String> moveToStatus;
  final Project project;
  final void Function() onUpdate;

  const TaskTab({
    Key? key,
    required this.tasks,
    required this.location,
    required this.moveToStatus,
    required this.admin,
    required this.project,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _TaskTabState createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0.0),
        itemCount: widget.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return FocusedMenuHolder(
            onPressed: () {},
            menuWidth: 200,
            menuItems: <FocusedMenuItem>[
              for (var statusName in widget.moveToStatus)
                FocusedMenuItem(
                    title: Text('Déplacer vers $statusName'),
                    onPressed: () {
                      TaskServices.updateTask(
                              widget.tasks[index].id!, statusName)
                          .then((value) {
                        widget.onUpdate();
                      });
                    })
            ],
            child: Card(
              child: ListTile(
                title: Text(widget.tasks[index].name),
                onTap: () {
                  Navigator.of(context).pushNamed("/task", arguments: {
                    "project": widget.project,
                    "task": widget.tasks[index]
                  });
                },
                trailing: widget.admin
                    ? IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xff8a2831),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return DeleteDialog(onApprove: () {
                                TaskServices.deleteTask(
                                  widget.tasks[index].id!,
                                ).then((value) {
                                  Navigator.of(context).pop();
                                  widget.onUpdate();
                                });
                              });
                            },
                          );
                        },
                      )
                    : null,
              ),
            ),
          );
        });
  }
}
