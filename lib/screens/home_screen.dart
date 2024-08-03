import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_test/blocs/auth_bloc/bloc.dart';
import 'package:fan_test/models/user_firestore_model.dart';
import 'package:fan_test/screens/setting_screen.dart';
import 'package:fan_test/services/auth_service.dart';
import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/widgets/appbars/appbar_widget.dart';
import 'package:fan_test/widgets/dialogs/dialog_widget.dart';
import 'package:fan_test/widgets/lists/list_user_widget.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
    this.uid,
  });
  String? uid;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  AuthBloc authBloc = AuthBloc();

  bool? filterby;
  bool isSearch = false;
  String searchValue = "";

  List<UserFirestoreModel> listUserSearch = [];

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserFirestoreModel> listUser = [];

  // Future checkVerifEmail() async {
  //   await AuthService().checkEmailVerificationAndUpdate();
  // }

  void searching() {
    listUserSearch.clear();
    if (listUser.isNotEmpty) {
      listUser
          .map((e) => e.nama!.toLowerCase().contains(searchValue) ||
                  e.email!.toLowerCase().contains(searchValue)
              ? listUserSearch.add(e)
              : null)
          .toList();
    }
    log("length search: ${listUserSearch.length}");

    setState(() {});
  }

  void filterEmail() {
    listUserSearch.clear();
    if (listUser.isNotEmpty) {
      listUser
          .map(
              (e) => e.emailVerified == filterby ? listUserSearch.add(e) : null)
          .toList();
    }
    log("length search: ${listUserSearch.length}");

    setState(() {});
  }

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is CheckEmailVerifFailed) {
              showDialog(
                context: context,
                builder: (context) => Dialog2Widget(
                  title: "Error",
                  value: "${state.message}",
                  okeBtn: () => Get.back(),
                ),
              );
            }
            if (state is CheckEmailVerifLoaded) {}
            if (state is CheckEmailVerifSuccess) {}
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          if (isSearch) {
            isSearch = false;
            animationController.reverse();
            setState(() {});
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: AppbarWidget(
            title: "ChatApp",
            animationController: animationController,
            isSearchValue: isSearch,
            onTapBack: () {
              if (isSearch) {
                searchValue = "";
                listUserSearch.clear();
              }
              setState(() {});
            },
            isSearch: (p0) {
              isSearch = p0;
              setState(() {});
            },
            onSearch: (p0) {
              searchValue = p0.toLowerCase();
              searching();
              setState(() {});
            },
            actions: [
              PopupMenuButton(
                color: LightColors.white,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 1,
                      child: TextNormalRegular(value: "Setting"),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: TextNormalRegular(value: "Filter"),
                    ),
                  ];
                },
                onSelected: (value) async {
                  if (value == 1) {
                    authBloc.add(CheckEmailVerifEvent());
                    Get.to(() => const SettingScreen());
                  }
                  if (value == 2) {
                    showDialog(
                      context: context,
                      builder: (context) => DialogWidget(
                        title: "Filter by Email Status",
                        valueCustom: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            RadioListTile.adaptive(
                              title: TextNormalSemiBold(
                                value: "Semua",
                              ),
                              value: null,
                              groupValue: filterby,
                              toggleable: true,
                              onChanged: (value) {
                                filterby = value;
                                filterEmail();
                                Get.back();
                                setState(() {});
                              },
                            ),
                            RadioListTile.adaptive(
                              title: TextNormalSemiBold(value: "Terverifikasi"),
                              value: true,
                              groupValue: filterby,
                              onChanged: (value) {
                                filterby = value;
                                filterEmail();
                                Get.back();
                                setState(() {});
                              },
                            ),
                            RadioListTile.adaptive(
                              title: TextNormalSemiBold(
                                  value: "Belum terverifikasi"),
                              value: false,
                              groupValue: filterby,
                              onChanged: (value) {
                                filterby = value;
                                filterEmail();
                                Get.back();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: LightColors.mainColor))),
            child: StreamBuilder(
              stream: _firestore.collection("users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: TextBigBold(value: "Error"),
                  );
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
                  listUser = snapshot.data!.docs
                      .map((e) => UserFirestoreModel.fromJson(e.data()))
                      .where((element) =>
                          element.email != _firebaseAuth.currentUser!.email)
                      .toList();

                  var getSender = snapshot.data!.docs
                      .map((e) => UserFirestoreModel.fromJson(e.data()))
                      .where((element) =>
                          element.email == _firebaseAuth.currentUser!.email)
                      .toList()
                      .first;

                  if (listUser.length == 0) {
                    return Center(
                      child: TextBigBold(value: "User tidak ada"),
                    );
                  } else if (filterby != null && listUserSearch.length == 0) {
                    return Center(
                      child: TextBigBold(value: "User tidak ada"),
                    );
                  } else {
                    return RefreshIndicator(
                      color: LightColors.mainColor,
                      backgroundColor: LightColors.white,
                      onRefresh: () async {
                        await _firebaseAuth.currentUser?.reload();
                      },
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          if (filterby == null && searchValue == "") ...[
                            ...listUser.map<Widget>(
                              (value) => ListUserWidget(
                                data: value,
                                dataSender: getSender,
                              ),
                            )
                          ] else ...[
                            ...listUserSearch.map<Widget>(
                              (value) => ListUserWidget(
                                data: value,
                                dataSender: getSender,
                              ),
                            ),
                          ]
                        ],
                      ),
                    );
                  }
                }

                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
