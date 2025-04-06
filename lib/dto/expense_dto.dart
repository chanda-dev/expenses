import 'package:expenses/dto/user_dto.dart';
import 'package:expenses/model/expenses.dart';
import 'package:expenses/model/user.dart';

class ExpenseDto {
  static Expenses fromJson(int id, Map<String, dynamic> json) {
    final user =
        json.containsKey('user') && json['user'] != null
            ? UserDto.fromJson(json['user'])
            : User(
              id: json['user_id'] ?? 0,
              username: 'Unknown',
              email: 'unknown@example.com',
            );

    Category category;
    try {
      category = Category.values.firstWhere(
        (element) => element.toString() == json['category'].toString(),
      );
    } catch (_) {
      category = Category.travel;
    }

    return Expenses(
      id: json['id'],
      user: user,
      amount: json['amount'],
      category: category,
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }

  static Map<String, dynamic> toJson(Expenses expenses) {
    return {
      'id': expenses.id,
      'user_id': expenses.user.id,
      'amount': expenses.amount,
      'category': expenses.category.toString().split('.').last,
      'date': expenses.date.toIso8601String(),
      'notes': expenses.notes,
    };
  }
}
