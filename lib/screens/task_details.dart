import 'dart:ffi';

import 'package:jei_project_manager_app/models/task.dart';
import 'package:jei_project_manager_app/services/task_service.dart';
import 'package:flutter/material.dart';

class TaskDetails extends StatefulWidget {
  final int ID;
  TaskDetails({Key? key, required this.ID}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late Future<Task> futureTask;

  @override
  void initState() {
    super.initState();
    futureTask = TaskServices.getTasks(widget.ID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Colors.white),
            title: Text("Détails"),
            centerTitle: true,
            backgroundColor: Color(0xff171a33),
          ),
          body: Container(
            margin: EdgeInsets.all(20.0),
            width: double.infinity,
            height: double.infinity,
            child: Card(
              color: Colors.white,
              elevation: 10.0,
              shadowColor: Color(0xff171a33),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FutureBuilder<Task>(
                    future: futureTask,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          margin: EdgeInsets.all(20.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 8,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!.name.toString(),
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        color: Color(0xff8a2831)),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    snapshot.data!.description.toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text("Deadline: " +
                                      snapshot.data!.deadline.day.toString() +
                                      "/" +
                                      snapshot.data!.deadline.month.toString() +
                                      "/" +
                                      snapshot.data!.deadline.year.toString()),
                                  Text("Status: " +
                                      snapshot.data!.status.toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return SizedBox(
                        height: 10.0,
                        width: 10.0,
                        child: CircularProgressIndicator(
                          color: Color(0xff171a33),
                          strokeWidth: 4.0,
                        ),
                      );
                    }),
              ),
            ),
          )),
    );
  }
}
