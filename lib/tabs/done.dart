import 'package:flutter/material.dart';
import 'package:project/models/Task.dart';


class done extends StatefulWidget {
   done({Key? key}) : super(key: key);

  @override
  _doneState createState() => _doneState();
}

class _doneState extends State<done> {
  List<Task> todos = [
    Task(name: 'task1', project: "project", description: "description", deadline: "deadline"),
    Task(name: 'task2', project: "project", description: "description", deadline: "deadline"),
    Task(name: 'task3', project: "project", description: "description", deadline: "deadline"),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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




    
    
