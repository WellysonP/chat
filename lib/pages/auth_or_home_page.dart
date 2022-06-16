import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/pages/auth_page.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loadind_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          return StreamBuilder<ChatUser?>(
            stream: AuthService().userChanges,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingPage();
              } else {
                return snapshot.hasData ? ChatPage() : AuthPage();
              }
            },
          );
        }
      },
    );
  }
}
