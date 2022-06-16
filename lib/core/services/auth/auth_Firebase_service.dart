import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  // static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi(
    (controller) async {
      // _controller = controller;
      final authChanges = FirebaseAuth.instance.authStateChanges();
      await for (final user in authChanges) {
        _currentUser = user == null ? null : _toChatUser(user);
        controller.add(_currentUser);
      }
    },
  );

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  Future<void> signUp(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final auth = FirebaseAuth.instance;
    UserCredential credantial = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credantial.user == null) return;

    credantial.user?.updateDisplayName(name);
    // credantial.user?.updatePhotoURL(image);
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  static ChatUser _toChatUser(User user) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split("@")[0],
      email: user.email!,
      imageUrl: user.photoURL ?? "assets/images/avatar.png",
    );
  }
}
