import 'dart:convert';

import 'package:jei_project_manager_app/models/task.dart';
import 'package:http/http.dart' as http;

class TaskServices {
  static Future<Task> getTasks(int ID) async {
    var client = http.Client();
    var url = Uri.parse(
        'https://my-json-server.typicode.com/hanabenasker/ollert/' +
            ID.toString());

    var response = await client.get(url);

    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load task");
    }
  }
}
