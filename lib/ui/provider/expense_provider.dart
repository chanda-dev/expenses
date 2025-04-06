import 'package:expenses/model/expenses.dart';
import 'package:expenses/model/user.dart';
import 'package:expenses/repository/expense_repository.dart';
import 'package:expenses/utils/async_value.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  final int id;
  final ExpenseRepository? repository;
  AsyncValue<List<Expenses>>? expenseState;
  ExpenseProvider({this.repository, required this.id}) {
    fetchExpense(id: id);
  }

  bool get isLoading =>
      expenseState != null && expenseState!.state == AsyncValueState.loading;
  bool get hasData =>
      expenseState != null && expenseState!.state == AsyncValueState.success;

  void fetchExpense({required int id}) async {
    try {
      expenseState = AsyncValue.loading();
      notifyListeners();
      expenseState = AsyncValue.success(
        await repository!.getExpense(user_id: id),
      );
      print("SUCCES: list size ${expenseState!.data!.length.toString()}");
    } catch (error) {
      print('Error:$error');
      expenseState = AsyncValue.error(error);
    }
    notifyListeners();
  }

  void addExpense(
    User user,
    int amount,
    Category category,
    DateTime date,
    String notes,
  ) async {
    try {
      await repository!.addExpense(
        user: user,
        amount: amount,
        category: category,
        date: date,
        notes: notes,
      );
    } catch (e) {
      print('failed to add expense $e');
    }

    fetchExpense(id: user.id);
  }

  void updateExpense(
    int id,
    User user,
    int amount,
    Category category,
    DateTime date,
    String note,
  ) async {
    await repository!.updateExpenses(
      id: id,
      user: user,
      amount: amount,
      category: category,
      date: date,
      note: note,
    );
    fetchExpense(id: user.id);
  }

  void deleteExpense({required int id, required int user_id}) async {
    if (hasData) {
      int index = expenseState!.data!.indexWhere((p) => p.id == id);
      if (index == -1) {
        throw Exception("Expense of id $id not found in cache");
      }
      final removedExpense = expenseState!.data![index];
      expenseState!.data!.removeAt(index);
      try {
        await repository!.deleteExpense(id: id);
      } catch (error) {
        expenseState!.data!.insert(index, removedExpense);
        notifyListeners();
      }
    } else {
      notifyListeners();
    }
    fetchExpense(id: user_id);
  }
}
