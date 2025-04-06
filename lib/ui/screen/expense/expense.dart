import 'package:expenses/model/user.dart';
import 'package:expenses/repository/sqlite_expense_repo.dart';
import 'package:expenses/ui/provider/expense_provider.dart';
import 'package:expenses/ui/screen/expense/expensesList.dart';
import 'package:expenses/utils/async_value.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'expenses_form.dart';
import 'package:expenses/model/expenses.dart';

class Expense extends StatefulWidget {
  final User user;
  const Expense({super.key, required this.user});

  @override
  State<Expense> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expense> {
  final List<Expenses> _registeredExpenses = [];
  void onUndo(Expenses expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void onExpenseRemoved(BuildContext context, Expenses expense) {
    final ExpenseProvider expenseProvider = context.read<ExpenseProvider>();
    expenseProvider.deleteExpense(id: expense.id, user_id: widget.user.id);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    print(expense.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Expense deleted',
          style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.blue,
          onPressed:
              () => {
                expenseProvider.addExpense(
                  widget.user,
                  expense.amount,
                  expense.category,
                  expense.date,
                  expense.notes,
                ),
              },
        ),
      ),
    );
  }

  void onExpenseCreated(Expense newExpense) {
    // setState(() {
    //   _registeredExpenses.add(newExpense);
    // });
  }

  void onAddPressed(BuildContext context, ExpenseProvider expenseProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (_) => ChangeNotifierProvider.value(
            value: expenseProvider,
            child: ExpenseForm(user: widget.user),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExpenseProvider>(
      create:
          (_) => ExpenseProvider(
            id: widget.user.id,
            repository: SqliteExpenseRepo(),
          ),
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          actions: [
            Consumer<ExpenseProvider>(
              builder:
                  (context, expenseProvider, _) => IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => onAddPressed(context, expenseProvider),
                  ),
            ),
          ],
          backgroundColor: Colors.blue[700],
          title: const Text('Livinda-The-Best Expenses App'),
        ),

        body: Consumer<ExpenseProvider>(
          builder: (context, expenseProvider, child) {
            if (expenseProvider.expenseState == null ||
                expenseProvider.expenseState!.state ==
                    AsyncValueState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (expenseProvider.expenseState!.state ==
                AsyncValueState.error) {
              return const Center(child: Text("Something went wrong"));
            } else {
              final expenses = expenseProvider.expenseState!.data ?? [];
              return ExpensesList(
                expenses: expenses,
                onExpenseRemoved: onExpenseRemoved,
              );
            }
          },
        ),
      ),
    );
  }
}
