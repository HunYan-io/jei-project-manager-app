import 'dart:convert';

import 'package:jei_project_manager_app/config.dart';
import 'package:jei_project_manager_app/models/project.dart';
import 'package:jei_project_manager_app/services/http_service.dart';

class ProjectsService {
  static Future<List<Project>> getProjects() async {
    final response = await httpService.get(
      Uri.parse(Config.apiURL + "/projects"),
    );
    if (response.statusCode < 400) {
      final data = List<Map<String, dynamic>>.from(json.decode(response.body));
      return data.map((project) => Project.fromJson(project)).toList();
    } else {
      final data = json.decode(response.body) as Map<String, dynamic>;
      throw Exception(data["error"]);
    }
  }

 static Future<bool> postProject(Project project) async {
     final response = await httpService.post(
      Uri.parse(Config.apiURL + "/projects"),
      body: json.encode(project.toJson()),
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode < 400) {
      return data["success"];
    } else {
      throw Exception(data["message"]);
    }
  }

  static Future<bool> deleteProject(int id) async {
    final response = await httpService.delete(
      Uri.parse(Config.apiURL + "/projects/$id"),
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode < 400) {
      return data["success"];
    } else {
      throw Exception(data["message"]);
    }
  }
}

final projectsService = ProjectsService();
