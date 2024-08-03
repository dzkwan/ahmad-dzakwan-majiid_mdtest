import 'package:fan_test/models/chat_model.dart';
import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/utils/capital_helper.dart';
import 'package:fan_test/utils/constants_helper.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListChatitemWidget extends StatelessWidget {
  ListChatitemWidget({
    super.key,
    required this.data,
  });
  ChatModel data;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    var alignment = (data.senderId == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: (data.senderId == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          TextNormalRegular(value: capitalizeEachWord("${data.from}")),
          SizedBox(height: 2),
          Container(
            constraints: BoxConstraints(
              maxWidth: ConstantsHelper.screenWidth * 0.75,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: LightColors.mainColor3,
            ),
            child: TextNormalRegular(value: data.chat!),
          ),
        ],
      ),
    );
  }
}
