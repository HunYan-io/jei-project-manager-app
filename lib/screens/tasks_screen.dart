import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jei_project_manager_app/models/project.dart';
import 'package:jei_project_manager_app/models/task.dart';
import 'package:jei_project_manager_app/services/auth_service.dart';
import 'package:jei_project_manager_app/services/task_service.dart';
import 'package:jei_project_manager_app/widgets/task_tab.dart';
import 'package:readmore/readmore.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({Key? key}) : super(key: key);

  List<Task> data = [
    Task(
      name: 'task1',
      project: 3,
      description: "description",
      deadline: DateTime.now(),
      status: "to do",
    ),
    Task(
      name: 'task2',
      project: 0,
      description: "description",
      deadline: DateTime.now(),
      status: "to do",
    ),
    Task(
      name: 'task3',
      project: 0,
      description: "description",
      deadline: DateTime.now(),
      status: "to do",
    ),
  ];

  final project = Project(
      name: "Jei project manager app",
      type: "Développement Mobile",
      description:
          "A project management app that allows users to see and add projects. Each project has a list of tasks labeled as todo, doing or done.",
      members: [
        "Heni Yengui",
        "Tayaa Ayachi",
        "Imen Kaabachi",
        "Hana Ben Asker"
      ],
      deadline: DateTime.now());

  final _tabNames = ["to do", "doing", "done"];

  @override
  Widget build(BuildContext context) {
    // final project = ModalRoute.of(context)!.settings.arguments as Project;
    return Scaffold(
      floatingActionButton: authService.isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/tasks/add").then((_) => {
                      // setState(() {});
                    });
              },
              child: const Icon(Icons.add),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: DefaultTabController(
        length: 3,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Transform.translate(
                          offset: const Offset(-10, 0),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      project.name,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.1),
                          ),
                          margin: const EdgeInsets.only(top: 8.0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 9.0, horizontal: 15.0),
                          child: Text(
                            project.type.startsWith("D")
                                ? project.type.split(" ")[1]
                                : project.type.split(" ")[0],
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.grey.shade800.withOpacity(0.1),
                          ),
                          margin: const EdgeInsets.only(top: 8.0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 9.0, horizontal: 15.0),
                          child: Text(
                            "Deadline | " +
                                DateFormat("dd MMM y hh:mm")
                                    .format(project.deadline),
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.grey.shade800,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ReadMoreText(
                      project.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey),
                      trimLines: 2,
                      colorClickableText:
                          Theme.of(context).colorScheme.secondary,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Voir plus',
                      trimExpandedText: 'Moins',
                    ),
                    if (project.members.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20.0),
                          Text(
                            "Membres",
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          const SizedBox(height: 10.0),
                          Wrap(
                            spacing: 10.0,
                            runSpacing: 5.0,
                            children: [
                              for (final member in project.members)
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.1),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: 15.0,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        child: Center(
                                          child: Text(
                                            member[0],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5.0),
                                      Text(
                                        member,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                      ),
                                      const SizedBox(width: 5.0)
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(height: 30.0),
                    Text(
                      "Tâches",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                      child: Theme(
                        data: ThemeData(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: TabBar(
                          unselectedLabelColor:
                              Theme.of(context).colorScheme.primary,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          indicatorPadding: const EdgeInsets.only(bottom: 1.0),
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                          labelStyle:
                              Theme.of(context).textTheme.button!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          tabs: [
                            for (final tabName in _tabNames)
                              Tab(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.08),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      tabName.toUpperCase(),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (final tabName in _tabNames)
                      TaskTab(
                        tasks: data,
                        location: tabName,
                        moveToStatus:
                            _tabNames.where((name) => name != tabName).toList(),
                        admin: authService.isAdmin,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
