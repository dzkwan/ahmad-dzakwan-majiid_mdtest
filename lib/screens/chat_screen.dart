import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_test/models/chat_model.dart';
import 'package:fan_test/models/user_firestore_model.dart';
import 'package:fan_test/services/chat_service.dart';
import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/utils/capital_helper.dart';
import 'package:fan_test/widgets/inputs/input_text_widget.dart';
import 'package:fan_test/widgets/lists/list_chatitem_widget.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({
    super.key,
    required this.data,
    required this.senderNama,
  });
  UserFirestoreModel data;
  String senderNama;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatCtrl = TextEditingController();
  ChatService chatService = ChatService();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int maxLines = 4;

  Future<void> klikSendChat() async {
    if (chatCtrl.text.isNotEmpty) {
      await chatService.sendChat(
        widget.data.uid!,
        widget.senderNama,
        chatCtrl.text,
      );
      chatCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextMediumRegular(
          value: capitalizeEachWord("${widget.data.nama}"),
        ),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: chatService.getChat(
                widget.data.uid!,
                firebaseAuth.currentUser!.uid,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return TextBigBold(value: "error: ${snapshot.error}");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: LightColors.mainText,
                      size: 50,
                    ),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data?.docs.length == 0) {
                    return Center(
                      child: TextBigBold(value: "Chat Kosong"),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((e) {
                      ChatModel data =
                          ChatModel.fromJson(e.data() as Map<String, dynamic>);
                      return ListChatitemWidget(data: data);
                    }).toList(),
                  );
                }
                return Center(
                  child: TextBigBold(value: "Chat Kosong"),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            color: LightColors.white,
            child: Row(
              children: [
                Expanded(
                  child: InputTextWidget(
                    hintText: "Enter Message",
                    controller: chatCtrl,
                    textInputType: TextInputType.multiline,
                    maxLines: maxLines,
                  ),
                ),
                IconButton(
                  onPressed: klikSendChat,
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
