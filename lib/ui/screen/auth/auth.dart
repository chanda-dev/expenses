import 'package:expenses/ui/screen/auth/login/login.dart';
import 'package:expenses/ui/screen/auth/register/register.dart.dart';
import 'package:flutter/material.dart';

enum Mode { register, login }

class Auth extends StatefulWidget {
  final Mode initialMode;
  const Auth({super.key, required Mode mode}) : initialMode = mode;

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  late Mode mode;

  @override
  void initState() {
    super.initState();
    mode = widget.initialMode;
  }

  @override
  Widget build(BuildContext context) {
    if (mode != Mode.login) {
      return Register(
        onSwitchToLogin: () {
          setState(() {
            mode = Mode.login;
          });
        },
      );
    }
    return Login(
      onSwitchToRegister: () {
        setState(() {
          mode = Mode.register;
        });
      },
    );
  }
}
