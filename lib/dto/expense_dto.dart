import 'package:expenses/model/expenses.dart';

class ExpenseDto {
  static Expenses fromJson(int id, Map<String, dynamic> json) {
    return Expenses(
      id: json['id'],
      user: json['user'],
      amount: json['amount'],
      category: json['category'],
      date: DateTime.parse(json['date']),
      note: json['notes'],
    );
  }

  static Map<String, dynamic> toJson(Expenses expenses) {
    return {
      'id': expenses.id,
      'user': expenses.user,
      'amount': expenses.amount,
      'category': expenses.category,
      'date': expenses.date.toIso8601String(),
      'notes': expenses.note,
    };
  }
}
