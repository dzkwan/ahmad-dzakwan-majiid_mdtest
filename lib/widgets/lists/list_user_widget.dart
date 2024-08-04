import 'package:fan_test/models/chat_model.dart';
import 'package:fan_test/models/user_firestore_model.dart';
import 'package:fan_test/screens/chat_screen.dart';
import 'package:fan_test/services/chat_service.dart';
import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/utils/capital_helper.dart';
import 'package:fan_test/widgets/dialogs/dialog_widget.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListUserWidget extends StatelessWidget {
  ListUserWidget({
    super.key,
    required this.data,
    required this.dataSender,
  });
  UserFirestoreModel data;
  UserFirestoreModel dataSender;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_firebaseAuth.currentUser!.email != data.email) {
      return StreamBuilder(
        stream:
            ChatService().getChat(_firebaseAuth.currentUser!.uid, data.uid!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ChatModel> listChat = snapshot.data!.docs.map((e) {
              var value = e.data() as Map<String, dynamic>;
              return ChatModel.fromJson(value);
            }).toList();
            ChatModel userChat = ChatModel();
            if (listChat.isNotEmpty) {
              userChat = listChat.elementAt(listChat.length - 1);
              // debugPrint(
              //     "data chat ${listChat.elementAt(listChat.length - 1)['chat']}");
            }
            // debugPrint(newChat);
            return InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (!_firebaseAuth.currentUser!.emailVerified) {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog2Widget(
                      title: "Gagal",
                      value:
                          "Silahkan verifikasi email Anda terlebih dahulu. Jika merasa sudah verifikasi, silahkan refresh halaman ini.",
                      okeBtn: () => Get.back(),
                    ),
                  );
                  return;
                }
                if (!data.emailVerified!) {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog2Widget(
                      title: "Gagal",
                      value:
                          "${capitalizeEachWord("${data.nama}")} belum melakukan verifikasi email.",
                      okeBtn: () => Get.back(),
                    ),
                  );
                  return;
                }
                Get.to(
                  () => ChatScreen(
                    data: data,
                    senderNama: dataSender.nama!,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: LightColors.mainColor2,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: TextMediumRegular(
                          value: data.nama![0].toUpperCase(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              TextMediumRegular(
                                  value: capitalizeEachWord("${data.nama}"),
                                  color: LightColors.mainText),
                              const SizedBox(width: 4),
                              if (data.emailVerified!) ...[
                                const Icon(
                                  Icons.check_circle,
                                  color: LightColors.softGreen,
                                  size: 15,
                                ),
                              ] else ...[
                                const Icon(
                                  Icons.remove_circle,
                                  color: LightColors.notSelected,
                                  size: 15,
                                ),
                              ],
                            ],
                          ),
                          CustomText(
                            value: "${data.email}",
                            maxLines: 1,
                            size: 10,
                            color: LightColors.ternaryText,
                          ),
                          if (_firebaseAuth.currentUser!.emailVerified &&
                              data.emailVerified! &&
                              userChat.chat != null) ...[
                            CustomText(
                              value:
                                  "${_firebaseAuth.currentUser?.uid == userChat.senderId ? "You : " : ""}${userChat.chat ?? ""}",
                              maxLines: 1,
                              color: LightColors.secondaryText,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
