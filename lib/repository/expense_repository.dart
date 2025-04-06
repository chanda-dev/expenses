import 'package:expenses/model/expenses.dart';
import 'package:expenses/model/user.dart';
import 'package:http/http.dart' as http;

abstract class ExpenseRepository {
  Future<Expenses> addExpense({
    required User user,
    required int amount,
    required ExpenseType category,
    required DateTime date,
    required String note,
  });
  Future<List<Expenses>> getExpense({required int id});

  Future<http.Response> deleteExpense({required int id});

  Future<Expenses> updateExpenses({
    required int id,
    required User user,
    required int amount,
    required ExpenseType category,
    required DateTime date,
    required String note,
  });
}
