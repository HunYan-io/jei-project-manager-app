import 'package:flutter/material.dart';
import 'package:jei_project_manager_app/screens/login_screen.dart';
import 'package:jei_project_manager_app/services/auth_service.dart';
import 'package:jei_project_manager_app/widgets/rounded_button.dart';
import 'package:jei_project_manager_app/widgets/rounded_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _usernameError;
  String? _passwordError;
  String? _emailError;
  var _isLoading = false;

  void onSignupPressed() {
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = "Entrer votre email";
      });
      return;
    }
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
        .signup(_emailController.text, _usernameController.text,
            _passwordController.text)
        .then((_) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/projects", (route) => false);
    }).catchError((e) {
      switch (e.message) {
        case "email_exists":
          setState(() {
            _emailError = "Cet e-mail est déjà inscrit.";
          });
          break;
        case "username_exists":
          setState(() {
            _usernameError = "Nom d'utilisateur utilisé.";
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
    final height = MediaQuery.of(context).size.height;
    return BaseAuthScreen(
      children: [
        RoundedTextField(
          labelText: "E-mail",
          controller: _emailController,
          errorText: _emailError,
          onChanged: (_) {
            if (_emailError != null) {
              setState(() {
                _emailError = null;
              });
            }
          },
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: height / 40),
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
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: height / 40),
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
          onSubmitted: (_) => _isLoading ? null : onSignupPressed(),
        ),
        SizedBox(height: height / 20),
        _isLoading
            ? const CircularProgressIndicator()
            : RoundedButton(
                text: "S'inscrire",
                onPressed: onSignupPressed,
              ),
        SizedBox(height: height / 40),
        TextButton(
          child: const Text("Vous avez déjà un compte ?"),
          onPressed: _isLoading
              ? null
              : () {
                  Navigator.of(context).pop();
                },
        )
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
