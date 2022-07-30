import 'package:earthkpru/states/authen.dart';
import 'package:flutter/material.dart';
import 'package:earthkpru/states/authen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authen(),
    );
  }
}