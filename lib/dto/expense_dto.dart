import 'package:expenses/model/expenses.dart';

class ExpenseDto {
  static Expenses fronJson(Map<String, dynamic> json) {
    return Expenses(
      id: json['id'],
      user: json['user'],
      amount: json['amount'],
      category: json['category'],
      date: json['date'],
      note: json['note'],
    );
  }

  static Map<String, dynamic> toJson(Expenses expenses) {
    return {
      'id': expenses.id,
      'user': expenses.user,
      'amount': expenses.amount,
      'category': expenses.category,
      'date': expenses.date,
      'note': expenses.note,
    };
  }
}
