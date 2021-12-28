import 'package:intl/intl.dart';
import 'package:jei_project_manager_app/models/project.dart';
import 'package:jei_project_manager_app/models/task.dart';
import 'package:flutter/material.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({Key? key}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final task = arguments["task"] as Task;
    final project = arguments["project"] as Project;
    return Scaffold(
      body: Padding(
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
              task.name,
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
                    task.status.toUpperCase(),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
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
                        DateFormat("dd MMM y hh:mm").format(task.deadline),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.grey.shade800,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1)),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.description,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    "Projet  |  ",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  Expanded(
                    child: Text(
                      project.name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Description",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10.0),
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.grey.shade700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
