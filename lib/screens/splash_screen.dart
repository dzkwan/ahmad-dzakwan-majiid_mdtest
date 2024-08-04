import 'dart:async';

import 'package:fan_test/screens/wrapper.dart';
import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/utils/constants_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  int indexAnimation = 0;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => indexAnimation++);
      if (indexAnimation >= 4) {
        Get.off(() => const WrapperAuth());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ConstantsHelper.screenWidth = MediaQuery.of(context).size.width;
    ConstantsHelper.screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LightColors.mainColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 0.0,
      ),
      body: Center(
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOutBack,
              top: indexAnimation == 0
                  ? -100
                  : indexAnimation == 1
                      ? ConstantsHelper.screenHeight / 2
                      : ConstantsHelper.screenHeight - 90,
              left: 64,
              right: 64,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: LightColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: indexAnimation == 0
                      ? 16
                      : indexAnimation == 1
                          ? 40
                          : 22,
                ),
                child: const Text(
                  "ChatApp",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
