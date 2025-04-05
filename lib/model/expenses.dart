import 'package:expenses/model/user.dart';

enum ExpenseType { FOOD, TRAVEL, LEISURE, WORK }

class Expenses {
  final int id;
  final User user;
  final int amount;
  final ExpenseType category;
  final DateTime date;
  final String note;

  Expenses({
    required this.id,
    required this.user,
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
  });
}
