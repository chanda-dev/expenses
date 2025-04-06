import 'package:expenses/repository/sqlite_user_repo.dart';
import 'package:expenses/ui/provider/user_provider.dart';
import 'package:expenses/ui/screen/auth/auth.dart';
import 'package:expenses/ui/screen/auth/register/register.dart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(SqliteUserRepo()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 249, 249),

        appBar: AppBar(
          title: Center(child: const Text("Welcome to Expense App")),
        ),
        body: Center(
          child: Container(
            height: 600,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Center(child: Auth(mode: Mode.register)),
          ),
        ),
      ),
    );
  }
}
