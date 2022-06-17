import 'package:chat/core/services/chat/chat_firebase_service.dart';
import 'package:chat/core/services/chat/chat_mock_service.dart';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage?> save(String text, ChatUser user);

  factory ChatService() {
    // return ChatMockService();
    return ChatFirebaseService();
  }
}
