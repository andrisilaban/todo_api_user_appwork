import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_api_user_appwork/provider/user_provider.dart';
import 'package:todo_api_user_appwork/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo Api User',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
      ),
    );
  }
}
