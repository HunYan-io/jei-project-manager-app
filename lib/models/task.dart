import 'package:flutter/cupertino.dart';

class Task {
  int? id;
  String name;
  String description;
  DateTime deadline;
  String status;

  Task({
    this.id,
    required this.deadline,
    required this.description,
    required this.status,
    required this.name,
  });

  factory Task.fromJson(Map<String, dynamic> entrer) {
    return Task(
      id: entrer["id"],
      name: entrer["name"],
      description: entrer["description"],
      deadline: entrer["deadline"],
      status: entrer["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "deadline": deadline,
        "description": description,
        "status": status,
      };
}
