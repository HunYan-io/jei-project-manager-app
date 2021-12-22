import 'package:flutter/material.dart';
import 'package:project/models/Task.dart';




class todo extends StatefulWidget {
  todo({Key? key}) : super(key: key);


  @override
  _doneState createState() => _doneState();
}

class _doneState extends State<todo> {
  Task input= Task(name: '', project: "project", description: "description", deadline: "deadline");
  List<Task> todos = [
    Task(name: 'task1', project: "project", description: "description", deadline: "deadline"),
    Task(name: 'task2', project: "project", description: "description", deadline: "deadline"),
    Task(name: 'task3', project: "project", description: "description", deadline: "deadline"),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Add Todolist"),
                  content: TextField(
                    onChanged: (String value) {
                      input.name = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            todos.add(input);
                          });
                        },
                        child: Text("Add"))
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(itemCount: todos.length,itemBuilder: (BuildContext context, int index){
        return Card(
            child: ListTile(title: Text(todos[index].name),
                trailing: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Color(0xff8a2831),
                    ),
                    onPressed: () {
                      setState((){
                        todos.removeAt(index);
                      }
                      );
                    }
                )
            )
        );
      }
      ),
    );
  }
}
