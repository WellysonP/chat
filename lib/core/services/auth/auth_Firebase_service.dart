import 'dart:async';
import 'dart:io';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
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

    //1. upload da foto do usuário
    final imageName = "${credantial.user!.uid}.jpg";
    final imageUrl = await _uploadUserImage(image, imageName);

    //2. Atualizar atributos do usuário
    await credantial.user?.updateDisplayName(name);
    await credantial.user?.updatePhotoURL(imageUrl);

    //3. salvar usuário no banco de dados
    _currentUser = _toChatUser(credantial.user!, name, imageUrl);
    await _saveChatUser(_currentUser!);
  }

  @override
  Future<void> login(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child("user_images").child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  @override
  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection("users").doc(user.id);

    return docRef.set({
      "name": user.name,
      "email": user.email,
      "imageUrl": user.imageUrl,
    });
  }

  static ChatUser _toChatUser(User user, [String? name, String? imageUrl]) {
    return ChatUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split("@")[0],
      email: user.email!,
      imageUrl: imageUrl ?? user.photoURL ?? "assets/images/avatar.png",
    );
  }
}
