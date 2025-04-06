import 'package:expenses/model/expenses.dart';
import 'package:expenses/ui/screen/expense/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onExpenseRemoved,
  });

  final List<Expenses> expenses;

  final Function(BuildContext, Expenses) onExpenseRemoved;

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text(
          'No expense found',
          style: TextStyle(
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder:
            (context, index) => Dismissible(
              onDismissed:
                  (direction) => onExpenseRemoved(context, expenses[index]),
              key: Key("${expenses[index].id}"),
              child: ExpenseItem(expenses[index]),
            ),
      ),
    );
  }
}
