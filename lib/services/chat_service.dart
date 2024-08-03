import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendChat(String receiverId, String nama, String chat) async {
    String userId = _firebaseAuth.currentUser!.uid;
    Timestamp timestamp = Timestamp.now();

    var body = {
      "senderId": userId,
      "receiverId": receiverId,
      "from": nama,
      "timeStamp": timestamp,
      "chat": chat,
    };

    List<String> idx = [userId, receiverId];
    idx.sort();
    String chatRoomId = idx.join("-");

    await _firestore
        .collection("chat_room")
        .doc(chatRoomId)
        .collection("chat")
        .add(body);
  }

  Stream<QuerySnapshot> getChat(String userId, String otherUserId) {
    List<String> idx = [userId, otherUserId];
    idx.sort();
    String chatRoomId = idx.join("-");

    return _firestore
        .collection("chat_room")
        .doc(chatRoomId)
        .collection("chat")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }
}
