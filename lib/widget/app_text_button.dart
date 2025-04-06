import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback onSwitchToLogin;
  final String text;
  const AppTextButton({
    super.key,
    required this.onSwitchToLogin,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onSwitchToLogin,
        child: Text(
          text,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
