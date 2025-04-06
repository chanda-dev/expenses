import 'dart:convert';
import 'dart:io';

import 'package:expenses/dto/expense_dto.dart';
import 'package:expenses/model/expenses.dart';
import 'package:expenses/model/user.dart';
import 'package:expenses/repository/expense_repository.dart';
import 'package:expenses/repository/user_repository.dart';
import 'package:http/http.dart' as http;

class SqliteExpenseRepo extends ExpenseRepository {
  static const String baseUrl = "http://localhost:5000/api/expense";
  final Uri uri = Uri.parse(baseUrl);
  @override
  Future<Expenses> addExpense({
    required User user,
    required int amount,
    required ExpenseType category,
    required DateTime date,
    required String note,
  }) async {
    try {
      final newExpense = {
        'user_id': user.id,
        'amount': amount,
        'category': category.toString(),
        'date': date.toIso8601String(),
        'notes': note,
      };
      final http.Response response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newExpense),
      );
      if (response.statusCode == HttpStatus.created ||
          response.statusCode == HttpStatus.ok) {
        final responseData = json.decode(response.body);
        return Expenses(
          id: responseData['id'] ?? responseData['username'],
          user: user,
          amount: amount,
          category: category,
          date: date,
          note: note,
        );
      }
      throw Exception('Failed to register: ${response.statusCode}');
    } catch (e) {
      throw Exception('add expense fail');
    }
  }

  @override
  Future<http.Response> deleteExpense({required int id}) async {
    Uri uriDelete = Uri.parse('$baseUrl/$id');
    final http.Response response = await http.delete(
      uriDelete,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to delete student');
    }

    return response;
  }

  @override
  Future<List<Expenses>> getExpense({required int id}) async {
    Uri uriGet = Uri.parse('$baseUrl/user/$id');
    final http.Response response = await http.get(uriGet);

    // Handle errors
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load');
    }
    final data = json.decode(response.body) as Map<String, dynamic>?;
    if (data == null) return [];
    return data.entries
        .map((entry) => ExpenseDto.fromJson(int.parse(entry.key), entry.value))
        .toList();
  }

  @override
  Future<Expenses> updateExpenses({
    required int id,
    required User user,
    required int amount,
    required ExpenseType category,
    required DateTime date,
    required String note,
  }) async {
    final updateExpenses = {
      'user_id': user.id,
      'amount': amount,
      'category': category.toString(),
      'date': date.toIso8601String(),
      'notes': note,
    };
    Uri uriUpdate = Uri.parse('$baseUrl/update/$id');
    final http.Response response = await http.put(
      uriUpdate,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updateExpenses),
    );

    // Handle errors
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add user');
    }

    // Return created user
    return Expenses(
      id: id,
      user: user,
      amount: amount,
      category: category,
      date: date,
      note: note,
    );
  }
}
