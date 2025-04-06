import 'package:expenses/model/expenses.dart';
import 'package:expenses/model/user.dart';
import 'package:http/http.dart' as http;

abstract class ExpenseRepository {
  Future<Expenses> addExpense({
    required User user,
    required int amount,
    required Category category,
    required DateTime date,
    required String notes,
  });
  Future<List<Expenses>> getExpense({required int user_id});

  Future<http.Response> deleteExpense({required int id});

  Future<Expenses> updateExpenses({
    required int id,
    required User user,
    required int amount,
    required Category category,
    required DateTime date,
    required String note,
  });
}
