import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/screens/Home.dart';

void main() {
  //main function call first
  //runApp() we have to pass the class
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To Do App",
      home: Home(),
    );
  }
}
