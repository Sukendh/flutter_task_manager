import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/screens/home_screen.dart';
import './providers/todo_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => TodoProvider()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
       home: const HomeScreen(),
      ),
    );
  }
}
