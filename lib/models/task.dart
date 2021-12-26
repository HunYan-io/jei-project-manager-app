class Task {
  final int? id;
  final String name;
  final int project;
  final String description;
  final DateTime deadline;
  final String status;

  Task(
      {this.id,
      required this.name,
      required this.project,
      required this.description,
      required this.deadline,
      required this.status});

  factory Task.fromJson(Map<String, dynamic> task) => Task(
      id: task["id"],
      name: task["name"],
      project: task["projectId"],
      description: task["description"],
      deadline: DateTime.parse(task["deadline"]),
      status: task["task"]);

  Map<String, dynamic> toJson() {
    final task = {
      "name": name,
      "project": project,
      "description": description,
      "deadline": deadline.toString(),
      "status": status
    };
    if (id != null) {
      task["id"] = id!;
    }
    return task;
  }
}
