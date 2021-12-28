import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:jei_project_manager_app/models/task.dart';
import 'package:jei_project_manager_app/services/task_service.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.admin
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(90, 30),
                primary: const Color(0xFF8a2831),
                onPrimary: Colors.white,
                side: const BorderSide(
                  color: Color(0xFF8a2831),
                  width: 0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("/tasks/add");
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          : null,
      body: FutureBuilder<List<Task>>(
          future: TaskServices.getTasks(3),
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
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
                                  TaskServices.updateTask(
                                          snapshot.data![index].id!)
                                      .then((value) {
                                    setState(() {});
                                  });
                                })
                        ],
                        child: Card(
                            child: ListTile(
                                title: Text(snapshot.data![index].name),
                                trailing: IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Color(0xff8a2831),
                                    ),
                                    onPressed: () {
                                      TaskServices.deleteTask(
                                              snapshot.data![index].id!)
                                          .then((value) {
                                        setState(() {});
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
                                  TaskServices.updateTask(
                                          snapshot.data![index].id!)
                                      .then((value) {
                                    setState(() {});
                                  });
                                })
                        ],
                        child: Card(
                            child: ListTile(
                          title: Text(snapshot.data![index].name),
                        )),
                      );
                    }
                  });
            } else if (snapshot.hasError) {
              return const Center(child: Text("Erreur de connexion."));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
            ;
          }),
    );
  }
}
