import 'package:expenses/model/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem(this.expense, {super.key});

  final Expenses expense;
  final formatter = DateFormat.yMd();

  String get formatedDate => formatter.format(expense.date);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.notes,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('\$${expense.amount.toStringAsFixed(2)}'),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Icon(expense.category.icon),
                const SizedBox(width: 8),
                Text(formatedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
