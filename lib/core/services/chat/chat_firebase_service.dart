import 'dart:async';
import 'dart:math';

import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_user.dart';

class ChatFirebaseService implements ChatService {
  Stream<List<ChatMessage>> messagesStream() {
    return Stream<List<ChatMessage>>.empty();
  }

  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final msg = ChatMessage(
      id: "",
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    final docRef = await store
        .collection("chat")
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(msg);

    final doc = await docRef.get();
    return doc.data()!;
  }

// ChatMessage => Map<String, dynamic> (padrão utilizado pelo firebase)
  Map<String, dynamic> _toFirestore(ChatMessage msg, SetOptions? options) {
    return {
      "text": msg.text,
      "createdAt": msg.createdAt.toIso8601String(),
      "userId": msg.userId,
      "userName": msg.userName,
      "userImageUrl": msg.userImageUrl,
    };
  }

//Map<String, dynamic> => ChatMessage
  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return ChatMessage(
      id: doc.id,
      text: doc["text"],
      createdAt: DateTime.parse(doc["createdAt"]),
      userId: doc["userId"],
      userName: doc["userName"],
      userImageUrl: doc["userImageUrl"],
    );
  }
}
