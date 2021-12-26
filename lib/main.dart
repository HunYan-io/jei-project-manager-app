import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:jei_project_manager_app/screens/add_project_screen.dart';
import 'package:jei_project_manager_app/screens/projects_screen.dart';
import 'package:jei_project_manager_app/screens/signup_screen.dart';
import 'package:jei_project_manager_app/screens/tasks_screen.dart';
import 'package:jei_project_manager_app/services/auth_service.dart';
import 'package:jei_project_manager_app/utilities/theme.dart';
import 'package:jei_project_manager_app/screens/login_screen.dart';

void main() async {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => MyApp(), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _authInit = authService.init();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'JEI Project Manager',
      theme: AppTheme.lightTheme,
      home: FutureBuilder(
        future: _authInit,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return authService.isLoggedIn
                ? ProjectsScreen()
                : const LoginScreen();
          } else if (snapshot.hasError) {
            return const LoginScreen();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/tasks': (context) => TasksScreen(),
        '/projects': (context) => ProjectsScreen(),
        '/projects/add': (context) => const AddProjectScreen()
      },
    );
  }
}
