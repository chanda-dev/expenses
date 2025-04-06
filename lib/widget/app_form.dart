import 'package:flutter/material.dart';

class AppForm extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;

  const AppForm({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter $label',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
