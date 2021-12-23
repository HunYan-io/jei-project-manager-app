import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:jei_project_manager_app/models/Task.dart';
import 'package:focused_menu/modals.dart';





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
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(90, 30),
          primary: Color(0xFF8a2831),
          onPrimary: Colors.white,
          side: BorderSide(
            color: Color(0xFF8a2831),
            width: 0,
          ),
        ),

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
                    TextButton(

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Add",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: ListView.builder(itemCount: todos.length,itemBuilder: (BuildContext context, int index){
        return FocusedMenuHolder(
          onPressed: (){},
          menuWidth: MediaQuery.of(context).size.width*0.3,
          menuItems: <FocusedMenuItem>[
            FocusedMenuItem(title: Text('move to doing'), onPressed: (){}),
            FocusedMenuItem(title: Text('move to done'), onPressed: (){})
          ],
          child: Card(
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
          ),
        );
      }
      ),
    );
  }
}
