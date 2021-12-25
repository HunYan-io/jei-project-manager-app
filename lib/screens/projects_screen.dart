import 'package:flutter/material.dart';
import 'package:jei_project_manager_app/models/project.dart';

class ProjectsScreen extends StatelessWidget {
  ProjectsScreen({Key? key}) : super(key: key);
  List<Project> projects = [
    Project(
      name: "projet1",
      type: "type1",
      description: "description",
      members: ["members"],
      deadline: DateTime.now(),
    ),
    Project(
      name: "projet2",
      type: "type1",
      description: "description",
      members: ["members"],
      deadline: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Projects",
            style: TextStyle(
              color: Color(0xFF171a33),
              fontSize: 30,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              child: Scrollbar(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        child: ListTile(
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: Color(0xFF171a33),
                                size: 20,
                              )),
                          onTap: () {},
                          title: Text(projects[index].name),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
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
                  Navigator.of(context).pushNamed("/projects/add");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
