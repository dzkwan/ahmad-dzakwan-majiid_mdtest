import 'package:fan_test/blocs/auth_bloc/bloc.dart';
import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/widgets/buttons/button_main_widget.dart';
import 'package:fan_test/widgets/dialogs/dialog_widget.dart';
import 'package:fan_test/widgets/inputs/input_text_widget.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  AuthBloc authBloc = AuthBloc();
  TextEditingController emailCtrl = TextEditingController();
  bool isLoading = false;
  bool isEnable = false;
  String errorMessage = " ";

  String emailValidator =
      r"[a-z0-9!#%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$";

  void checkEnable() {
    if (emailCtrl.text != "" &&
        RegExp(emailValidator).hasMatch(emailCtrl.text)) {
      isEnable = true;
      errorMessage = " ";
    } else {
      isEnable = false;
      errorMessage = "Please enter a valid email address.";
    }
    setState(() {});
  }

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ResetPasswordFailed) {
              showDialog(
                context: context,
                builder: (context) => Dialog2Widget(
                  title: "Gagal",
                  value: "${state.message}",
                  okeBtn: () => Get.back(),
                ),
              );
              isLoading = false;
              setState(() {});
            }
            if (state is ResetPasswordLoaded) {
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
              isLoading = false;
              setState(() {});
            }
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          if (isLoading) {
            return false;
          }
          return true;
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: LightColors.white,
            appBar: PreferredSize(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: LightColors.mainColor,
                      offset: Offset(0, -12),
                      blurRadius: 14,
                    )
                  ],
                ),
                child: AppBar(
                  elevation: 0.0,
                  backgroundColor: LightColors.white,
                  foregroundColor: LightColors.mainColor,
                  titleSpacing: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light),
                  title: TextMediumBold(
                    value: "Reset Password",
                    color: LightColors.mainColor,
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(kToolbarHeight),
            ),
            body: Container(
              color: LightColors.white,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const SizedBox(height: 24),
                  TextNormalRegular(
                    value:
                        "Masukkan email yang terkait dengan akun Anda dan kami akan mengirimkan link untuk mengatur ulang kata sandi Anda.",
                    color: LightColors.mainText,
                  ),
                  const SizedBox(height: 20),
                  InputTextWidget(
                    title: "Email",
                    controller: emailCtrl,
                    onChanged: (p0) {
                      checkEnable();
                    },
                    onEditingComplete: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      authBloc.add(ResetPasswordEvent(email: emailCtrl.text));
                    },
                  ),
                  const SizedBox(height: 6),
                  TextNormalRegular(
                    value: errorMessage,
                    color: LightColors.red,
                  ),
                  const SizedBox(height: 12),
                  ButtonMainWidget(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      authBloc.add(ResetPasswordEvent(email: emailCtrl.text));
                    },
                    isEnable: isEnable && !isLoading,
                    text: isLoading
                        ? const SpinKitFadingCircle(
                            size: 17,
                            color: LightColors.white,
                          )
                        : TextNormalBold(
                            value: "KIRIM",
                            color: LightColors.white,
                            letterSpacing: 1.25,
                          ),
                    backgroundColor: isEnable
                        ? LightColors.mainColor
                        : LightColors.mainColor.withOpacity(0.4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
