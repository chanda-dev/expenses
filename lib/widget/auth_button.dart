import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onSubmit;
  final String text;
  final Color color;
  const AuthButton({
    super.key,
    required this.onSubmit,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSubmit,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
