import 'package:flutter/material.dart';

import 'package:jei_project_manager_app/screens/add_project.dart';


import 'models/my_input_theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: MyInputTheme().theme(),
      ),

      home:AddProjectScreen(),
    );
  }
}

