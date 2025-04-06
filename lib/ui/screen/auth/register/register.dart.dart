import 'package:expenses/ui/provider/user_provider.dart';
import 'package:expenses/ui/screen/expense/expenses.dart';
import 'package:expenses/widget/app_form.dart';
import 'package:expenses/widget/app_text_button.dart';
import 'package:expenses/widget/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final VoidCallback onSwitchToLogin;
  const Register({super.key, required this.onSwitchToLogin});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _registerkey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool seePassword = true;
  String? onUsernameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please input some text';
    }
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Username cannot contain numbers';
    }
    return null;
  }

  String? onEmailController(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please input some text';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? onPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please input some text';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onSubmit() async {
    if (_registerkey.currentState!.validate()) {
      String username = _usernameController.text;
      String email = _emailController.text;
      String hashed_pass = _passwordController.text;
      final UserProvider userProvider = context.read<UserProvider>();

      try {
        final user = await userProvider.addUser(username, email, hashed_pass);
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => Expenses(user: user)),
        );
        print("Registered user ID: ${user.id}");
      } catch (e) {
        print("Registration failed: $e");
        if (!mounted) return;
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("Error"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
        );
      }
    }
  }

  void onSeePassword(bool? value) {
    seePassword = value!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _registerkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Register',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              AppForm(
                label: 'username',
                controller: _usernameController,
                validator: onUsernameValidation,
              ),
              const SizedBox(height: 16),
              AppForm(
                label: 'email',
                controller: _emailController,
                validator: onEmailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppForm(
                label: 'password',
                controller: _passwordController,
                validator: onPasswordValidation,
                keyboardType: TextInputType.visiblePassword,
                obscureText: seePassword,
              ),
              Row(
                children: [
                  Checkbox(
                    value: !seePassword,
                    onChanged: (value) {
                      setState(() {
                        seePassword = !(value ?? false);
                      });
                    },
                  ),
                  const Text('Show Password'),
                ],
              ),

              const SizedBox(height: 10),
              AppTextButton(
                onSwitchToLogin: widget.onSwitchToLogin,
                text: 'Already have account? login',
              ),
              const SizedBox(height: 32),
              AuthButton(
                onSubmit: onSubmit,
                text: 'Register',
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
