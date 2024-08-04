import 'package:fan_test/blocs/auth_bloc/bloc.dart';
import 'package:fan_test/screens/auths/register_screen.dart';
import 'package:fan_test/screens/auths/reset_password_screen.dart';
import 'package:fan_test/screens/wrapper.dart';
import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/utils/constants_helper.dart';
import 'package:fan_test/widgets/buttons/button_main_widget.dart';
import 'package:fan_test/widgets/dialogs/dialog_widget.dart';
import 'package:fan_test/widgets/inputs/input_text_widget.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_navigation/get_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  AuthBloc authBloc = AuthBloc();

  String errorMessage = "";
  bool isLoading = false;
  bool isEnable = false;

  String emailValidator =
      r"[a-z0-9!#%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$";

  void checkEnable() {
    if (emailCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty) {
      isEnable = true;
    } else {
      isEnable = false;
    }
    setState(() {});
  }

  void checkValidEmail() {
    if (emailCtrl.text != "") {
      if (RegExp(emailValidator).hasMatch(emailCtrl.text)) {
        isEnable = true;
        errorMessage = "";
      } else {
        isEnable = false;
        errorMessage = "Please enter a valid email address.";
      }
    } else {
      isEnable = false;
      errorMessage = "";
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
            if (state is LoginFailed) {
              showDialog(
                context: context,
                builder: (context) => Dialog2Widget(
                  title: "Gagal",
                  value: "${state.message}",
                  okeBtn: () => getx.Get.back(),
                ),
              );
              isLoading = false;
              setState(() {});
            } else if (state is LoginLoaded) {
              isLoading = true;
              setState(() {});
            } else if (state is LoginSuccess) {
              getx.Get.offAll(() => const WrapperAuth());
              isLoading = false;
              setState(() {});
            }
          },
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ConstantsHelper.screenHeight * 0.17),
                  Center(
                    child: CustomText(
                      size: 30,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                      color: LightColors.mainColor,
                      value: "ChatApp",
                    ),
                  ),
                  const SizedBox(height: 70),
                  InputTextWidget(
                    title: "Email",
                    controller: emailCtrl,
                    textInputAction: TextInputAction.next,
                    onChanged: (p0) {
                      checkValidEmail();
                      checkEnable();
                    },
                  ),
                  const SizedBox(height: 6),
                  TextNormalRegular(
                    value: errorMessage,
                    color: LightColors.red,
                  ),
                  SizedBox(height: errorMessage == "" ? 14 : 10),
                  InputTextWidget(
                    title: "Password",
                    isPassword: true,
                    controller: passwordCtrl,
                    textInputType: TextInputType.visiblePassword,
                    onEditingComplete: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      authBloc.add(
                        LoginEvent(
                          email: emailCtrl.text,
                          password: passwordCtrl.text,
                        ),
                      );
                      setState(() {});
                    },
                    onChanged: (p0) {
                      checkEnable();
                    },
                  ),
                  const SizedBox(height: 20),
                  ButtonMainWidget(
                    isEnable: isEnable && !isLoading,
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      authBloc.add(
                        LoginEvent(
                          email: emailCtrl.text,
                          password: passwordCtrl.text,
                        ),
                      );
                      setState(() {});
                    },
                    text: isLoading
                        ? const SpinKitFadingCircle(
                            size: 17,
                            color: LightColors.white,
                          )
                        : TextNormalBold(
                            value: "LOGIN",
                            color: LightColors.white,
                            letterSpacing: 1.25,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          size: 12,
                          value: "Lupa password?",
                          color: LightColors.mainText,
                        ),
                        TextButton(
                          style: const ButtonStyle(
                            overlayColor:
                                WidgetStatePropertyAll(Colors.transparent),
                          ),
                          onPressed: () =>
                              getx.Get.to(() => const ResetPasswordScreen()),
                          child: CustomText(
                            size: 12,
                            fontWeight: FontWeight.w700,
                            value: "Klik disini",
                            color: LightColors.mainText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Flexible(
                        fit: FlexFit.tight,
                        child: Divider(
                          height: 1,
                          color: LightColors.softBlack,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextNormalRegular(
                          value: "OR",
                          color: LightColors.softBlack,
                        ),
                      ),
                      const Flexible(
                        fit: FlexFit.tight,
                        child: Divider(
                          height: 1,
                          color: LightColors.softBlack,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          size: 12,
                          value: "Belum punya akun ?",
                          color: LightColors.mainText,
                        ),
                        TextButton(
                          style: const ButtonStyle(
                            overlayColor:
                                WidgetStatePropertyAll(Colors.transparent),
                          ),
                          onPressed: () => getx.Get.off(
                            () => const RegisterScreen(),
                            transition: getx.Transition.leftToRight,
                            duration: Durations.long2,
                          ),
                          child: CustomText(
                            size: 12,
                            value: "Registrasi",
                            fontWeight: FontWeight.w700,
                            color: LightColors.mainText,
                          ),
                        ),
                      ],
                    ),
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
