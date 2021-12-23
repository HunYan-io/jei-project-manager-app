import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jei_project_manager_app/services/auth_service.dart';
import 'package:jei_project_manager_app/widgets/rounded_button.dart';
import 'package:jei_project_manager_app/widgets/rounded_text_field.dart';

class BaseAuthScreen extends StatelessWidget {
  final List<Widget> children;
  const BaseAuthScreen({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40.0),
                    const Image(
                      image: AssetImage("assets/images/logo_junior.png"),
                      width: 150.0,
                    ),
                    const SizedBox(height: 50.0),
                    ...children,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _usernameError;
  String? _passwordError;
  var _isLoading = false;

  void onLoginPressed() {
    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameError = "Entrez votre nom d'utilisateur";
      });
      return;
    }
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = "Entrez votre mot de passe";
      });
      return;
    }
    setState(() {
      _isLoading = true;
    });
    authService
        .login(_usernameController.text, _passwordController.text)
        .then((_) {
      Navigator.of(context).pushReplacementNamed("/projects");
    }).catchError((e) {
      switch (e.message) {
        case "invalid_username":
          setState(() {
            _usernameError = "Nom d'utilisateur n'existe pas.";
          });
          break;
        case "invalid_password":
          setState(() {
            _passwordError = "Mot de passe incorrect.";
          });
          break;
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseAuthScreen(
      children: [
        RoundedTextField(
          labelText: "Nom d'utilisateur",
          controller: _usernameController,
          errorText: _usernameError,
          onChanged: (_) {
            if (_usernameError != null) {
              setState(() {
                _usernameError = null;
              });
            }
          },
        ),
        const SizedBox(height: 20.0),
        RoundedTextField(
          labelText: "Mot de passe",
          controller: _passwordController,
          errorText: _passwordError,
          obscureText: true,
          onChanged: (_) {
            if (_passwordError != null) {
              setState(() {
                _passwordError = null;
              });
            }
          },
        ),
        const SizedBox(height: 40.0),
        _isLoading
            ? const CircularProgressIndicator()
            : RoundedButton(
                text: "Se connecter",
                onPressed: onLoginPressed,
              ),
        const SizedBox(height: 20.0),
        TextButton(
          child: const Text("Vous n'avez pas de compte ? Créez-en un !"),
          onPressed: _isLoading
              ? null
              : () {
                  Navigator.of(context).pushNamed("/signup");
                },
        )
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
