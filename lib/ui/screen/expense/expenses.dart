import 'package:expenses/model/user.dart';
import 'package:flutter/material.dart';

class Expenses extends StatelessWidget {
  final User user;
  const Expenses({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense')),
      body: Text('${user.id}'),
    );
  }
}
