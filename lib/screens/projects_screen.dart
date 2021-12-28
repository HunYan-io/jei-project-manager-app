import 'package:flutter/material.dart';
import 'package:jei_project_manager_app/models/project.dart';
import 'package:jei_project_manager_app/screens/add_project_screen.dart';
import 'package:jei_project_manager_app/services/projects_service.dart';

class ProjectsScreen extends StatefulWidget {
  ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
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
        body: FutureBuilder<List<Project>>(
          future: ProjectsService.getProjects(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    child: Scrollbar(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Card(
                              child: ListTile(
                                trailing: IconButton(
                                    onPressed: () {
                                      ProjectsService.deleteProject(
                                              snapshot.data![index].id!)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(0xFF171a33),
                                      size: 20,
                                    )),
                                onTap: () => Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) => AddProjectScreen(),
                                  ),
                                )
                                    .then((value) {
                                  setState(() {});
                                }),
                                title: Text(snapshot.data![index].name),
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
                        Navigator.of(context)
                            .pushNamed("/projects/add")
                            .then((_) {
                          setState(() {});
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
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Erreur de connexion."));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
