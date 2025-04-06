import 'package:expenses/model/user.dart';
import 'package:flutter/material.dart';

enum Category {
  food(Icons.lunch_dining),
  travel(Icons.flight_takeoff),
  leisure(Icons.movie),
  work(Icons.work);

  final IconData icon;

  const Category(this.icon);
}

class Expenses {
  final int id;
  final User user;
  final int amount;
  final Category category;
  final DateTime date;
  final String notes;

  Expenses({
    required this.id,
    required this.user,
    required this.amount,
    required this.category,
    required this.date,
    required this.notes,
  });
}
