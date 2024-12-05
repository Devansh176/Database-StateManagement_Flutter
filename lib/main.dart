import 'package:flutter/material.dart';
import 'package:practice2/data/Home2.dart';
import 'package:practice2/provider/Home.dart';
import 'package:practice2/provider/list_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home2(),
    );
  }
}