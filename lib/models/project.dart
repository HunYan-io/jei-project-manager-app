class Project {
  final int? id;
  final String name;
  final String type;
  final String description;
  final List<String> members;
  final DateTime deadline;

  Project({
    this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.members,
    required this.deadline,
  });

  factory Project.fromJson(Map<String, dynamic> project) => Project(
        id: project["id"],
        name: project["name"],
        type: project["type"],
        description: project["description"],
        members: List<String>.from(project["members"]),
        deadline: DateTime.parse(project["deadline"]),
      );

  Map<String, dynamic> toJson() {
    final project = {
      "name": name,
      "type": type,
      "description": description,
      "members": members,
      "deadline": deadline.toString()
    };
    if (id != null) {
      project["id"] = id!;
    }
    return project;
  }
}
