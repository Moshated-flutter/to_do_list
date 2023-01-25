import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_list/injection.dart';

void main() {
  runApp(MyApp());
  configureInjection(Environment.prod);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
