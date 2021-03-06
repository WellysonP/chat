import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:chat/pages/auth_or_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatNotificationService(),
        )
      ],
      child: MaterialApp(
        theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
          primary: Colors.blueAccent,
          secondary: Colors.amber,
        )),
        debugShowCheckedModeBanner: false,
        home: AuthOrHomePage(),
      ),
    );
  }
}
