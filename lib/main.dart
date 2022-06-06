import 'package:chat/pages/auth_or_home_page.dart';
import 'package:chat/pages/auth_page.dart';
import 'package:chat/pages/loadind_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
        primary: Colors.blueAccent,
        secondary: Colors.amber,
      )),
      debugShowCheckedModeBanner: false,
      home: AuthOrHomePage(),
    );
  }
}
