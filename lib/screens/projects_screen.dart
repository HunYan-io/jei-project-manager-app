import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jei_project_manager_app/models/project.dart';
import 'package:jei_project_manager_app/screens/add_project_screen.dart';
import 'package:jei_project_manager_app/services/auth_service.dart';
import 'package:jei_project_manager_app/services/projects_service.dart';
import 'package:jei_project_manager_app/widgets/delete_dialog.dart';

class ProjectsScreen extends StatefulWidget {
  ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: authService.isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/projects/add").then((_) {
                  setState(() {});
                });
              },
              child: const Icon(Icons.add),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: MediaQuery.of(context).padding.top + 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bonjour, ${toBeginningOfSentenceCase(authService.username)}",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Rendons cette journée productive.",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    child: Center(
                      child: Text(
                        (authService.username ?? "U").toUpperCase()[0],
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    radius: 23.0,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  )
                ],
              ),
              const SizedBox(height: 30.0),
              Text(
                "Projets",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 10.0),
              FutureBuilder<List<Project>>(
                future: ProjectsService.getProjects(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Project>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0.0),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return DeleteDialog(onApprove: () {
                                        ProjectsService.deleteProject(
                                                snapshot.data![index].id!)
                                            .then((value) {
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        });
                                      });
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.close,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 20,
                                )),
                            onTap: () => Navigator.of(context)
                                .pushNamed("/tasks",
                                    arguments: snapshot.data![index])
                                .then((value) {
                              setState(() {});
                            }),
                            title: Text(snapshot.data![index].name),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Erreur de connexion."));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
