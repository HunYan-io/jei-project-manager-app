import 'dart:convert';

import 'package:jei_project_manager_app/config.dart';
import 'package:jei_project_manager_app/models/task.dart';
import 'package:jei_project_manager_app/services/http_service.dart';

class TaskServices {
  Future<List<Task>> getTasks(int id) async {
    final response = await httpService.get(
      Uri.parse(Config.apiURL + "/projects/$id/tasks"),
    );
    if (response.statusCode < 400) {
      final data = List<Map<String, dynamic>>.from(json.decode(response.body));
      return data.map((task) => Task.fromJson(task)).toList();
    } else {
      final data = json.decode(response.body) as Map<String, dynamic>;
      throw Exception(data["error"]);
    }
  }

  Future<Task> postTask(Task task) async {
    final response = await httpService.post(
      Uri.parse(
          Config.apiURL + "/projects/" + task.project.toString() + "/tasks"),
      body: json.encode(task.toJson()),
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode < 400) {
      return Task.fromJson(data);
    } else {
      throw Exception(data["message"]);
    }
  }

  Future<bool> deleteTask(int id) async {
    final response = await httpService.delete(
      Uri.parse(Config.apiURL + "/task/$id"),
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode < 400) {
      return data["success"];
    } else {
      throw Exception(data["message"]);
    }
  }

  Future<bool> updateTask(int id) async {
    final response = await httpService.put(
      Uri.parse(Config.apiURL + "/task/$id"),
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode < 400) {
      return data["success"];
    } else {
      throw Exception(data["message"]);
    }
  }
}
