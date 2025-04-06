import 'package:expenses/model/expenses.dart';
import 'package:expenses/model/user.dart';
import 'package:expenses/repository/expense_repository.dart';
import 'package:expenses/utils/async_value.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  final ExpenseRepository _repository;
  AsyncValue<List<Expenses>>? expenseState;
  ExpenseProvider(this._repository);

  bool get isLoading =>
      expenseState != null && expenseState!.state == AsyncValueState.loading;
  bool get hasData =>
      expenseState != null && expenseState!.state == AsyncValueState.success;

  void fetchExpense({required int id}) async {
    try {
      expenseState = AsyncValue.loading();
      notifyListeners();
      expenseState = AsyncValue.success(await _repository.getExpense(id: id));
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
    ExpenseType category,
    DateTime date,
    String note,
  ) async {
    await _repository.addExpense(
      user: user,
      amount: amount,
      category: category,
      date: date,
      note: note,
    );
    fetchExpense(id: user.id);
  }

  void updateExpense(
    int id,
    User user,
    int amount,
    ExpenseType category,
    DateTime date,
    String note,
  ) async {
    await _repository.updateExpenses(
      id: id,
      user: user,
      amount: amount,
      category: category,
      date: date,
      note: note,
    );
    fetchExpense(id: user.id);
  }

  void deleteExpense(int id) async {
    if (hasData) {
      int index = expenseState!.data!.indexWhere((p) => p.id == id);
      if (index == -1) {
        throw Exception("Expense of id $id not found in cache");
      }
      final removedExpense = expenseState!.data![index];
      expenseState!.data!.removeAt(index);
      try {
        await _repository.deleteExpense(id: id);
      } catch (error) {
        expenseState!.data!.insert(index, removedExpense);
        notifyListeners();
      }
    } else {
      notifyListeners();
    }
  }
}
