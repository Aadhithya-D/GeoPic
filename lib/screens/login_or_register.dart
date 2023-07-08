import 'package:os_app/screens/login.dart';
import 'package:os_app/screens/register.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showUserLogin = true;

  void onToggle() {
    setState(() {
      showUserLogin = !showUserLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showUserLogin) {
      return LoginScreen(onTap: onToggle);
    } else {
      return RegisterScreen(onTap: onToggle);
    }
  }
}
