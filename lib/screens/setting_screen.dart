import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_test/blocs/auth_bloc/bloc.dart';
import 'package:fan_test/models/user_firestore_model.dart';
import 'package:fan_test/services/auth_service.dart';
import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/widgets/buttons/button_main_widget.dart';
import 'package:fan_test/widgets/dialogs/dialog_widget.dart';
import 'package:fan_test/widgets/inputs/input_select_widget.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AuthBloc authBloc = AuthBloc();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  void checkVerifEmail() {
    authBloc.add(CheckEmailVerifEvent());
  }

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    checkVerifEmail();
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    checkVerifEmail();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SendEmailVerifFailed) {
              showDialog(
                context: context,
                builder: (context) => Dialog2Widget(
                  title: "Gagal",
                  value: state.message,
                  okeBtn: () => Get.back(),
                ),
              );
              EasyLoading.dismiss();
              isLoading = false;
              setState(() {});
            } else if (state is SendEmailVerifLoaded) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
              isLoading = true;
              setState(() {});
            } else if (state is SendEmailVerifSuccess) {
              showDialog(
                context: context,
                builder: (context) => Dialog2Widget(
                  title: "Email Verifikasi",
                  value: "Silahkan periksa email Anda untuk verifikasi email.",
                  okeBtn: () => Get.back(),
                ),
              );
              EasyLoading.dismiss();
              isLoading = false;
              setState(() {});
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is CheckEmailVerifFailed) {
              showDialog(
                context: context,
                builder: (context) => Dialog2Widget(
                  title: "Akun tidak sesuai",
                  value: state.message,
                  okeBtn: () => Get.back(),
                ),
              );
            }
            if (state is CheckEmailVerifLoaded) {}
            if (state is CheckEmailVerifSuccess) {}
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ResetPasswordFailed) {
              showDialog(
                context: context,
                builder: (context) => Dialog2Widget(
                  title: "Gagal",
                  value: state.message,
                  okeBtn: () => Get.back(),
                ),
              );
              EasyLoading.dismiss();
              isLoading = false;
              setState(() {});
            }
            if (state is ResetPasswordLoaded) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
              isLoading = true;
              setState(() {});
            }
            if (state is ResetPasswordSuccess) {
              showDialog(
                context: context,
                builder: (context) => Dialog2Widget(
                  title: "Reset Password",
                  value:
                      "Silahkan periksa email Anda untuk mengatur ulang kata sandi.",
                  okeBtn: () => Get.back(),
                ),
              );
              EasyLoading.dismiss();
              isLoading = false;
              setState(() {});
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: LightColors.white,
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _firestore
                    .collection("users")
                    .doc(_firebaseAuth.currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: TextBigBold(value: "Error"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitFadingCircle(
                        color: LightColors.mainText,
                        size: 50,
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    if (!snapshot.data!.exists) {
                      return Center(
                        child: TextBigBold(value: "Data User Tidak Ditemukan"),
                      );
                    }
                    UserFirestoreModel data = UserFirestoreModel.fromRawJson(
                        json.encode(snapshot.data?.data()));
                    return ListView(
                      children: [
                        Container(
                          color: LightColors.mainColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: LightColors.mainColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          child: const Center(
                                            child: Icon(
                                              Icons.arrow_back,
                                              color: LightColors.white,
                                            ),
                                          ),
                                        ),
                                        onTap: () => Get.back(),
                                      ),
                                    ),
                                  ),
                                  TextMediumBold(
                                    value: "Setting",
                                    letterSpacing: 1,
                                    color: LightColors.white,
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/avatar.png",
                                    scale: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              InputSelectWidget(
                                value: "Reset Password",
                                borderColor: LightColors.notSelected,
                                suffix: const Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog2Widget(
                                      title: "Reset Password",
                                      value:
                                          "Dengan menekan YA, anda akan Kami kirimkan pesan reset password melalui email. Apakah anda yakin ingin melanjutkan?",
                                      okeTitle: "YA",
                                      cancelBtn: () => Get.back(),
                                      okeBtn: () {
                                        authBloc.add(
                                          ResetPasswordEvent(
                                            email:
                                                "${_firebaseAuth.currentUser?.email}",
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 24),
                              InputSelectWidget(
                                title: "Verifikasi Email",
                                value: data.emailVerified!
                                    ? "Terverifikasi"
                                    : "Belum Verifikasi",
                                suffix: data.emailVerified!
                                    ? null
                                    : const Icon(Icons.keyboard_arrow_right),
                                isEnable: !data.emailVerified!,
                                borderColor: data.emailVerified!
                                    ? LightColors.gray
                                    : LightColors.notSelected,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog2Widget(
                                      title: "Verifikasi Email",
                                      value:
                                          "Apakah anda yakin ingin mengirim ulang pesan email verifikasi?",
                                      okeTitle: "YA",
                                      cancelBtn: () => Get.back(),
                                      okeBtn: () {
                                        authBloc.add(SendEmailVerifEvent());
                                      },
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              InputSelectWidget(
                                title: "Nama",
                                value: "${data.nama}",
                                isEnable: false,
                              ),
                              const SizedBox(height: 20),
                              InputSelectWidget(
                                title: "Email",
                                value: "${data.email}",
                                isEnable: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: ButtonMainWidget(
                backgroundColor: LightColors.softRed,
                text: TextNormalSemiBold(
                  value: "KELUAR AKUN",
                  letterSpacing: 1.25,
                  color: LightColors.strongRed,
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => Dialog2Widget(
                    title: "Keluar dari Akun",
                    okeTitle: "KELUAR",
                    value: "Apakah Anda yakin ingin keluar dari akun Anda?",
                    okeBtn: () async {
                      await AuthService().signOut();
                    },
                    cancelBtn: () => Get.back(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
