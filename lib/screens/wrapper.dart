import 'package:fan_test/screens/auths/login_screen.dart';
import 'package:fan_test/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WrapperAuth extends StatefulWidget {
  const WrapperAuth({super.key});

  @override
  State<WrapperAuth> createState() => _WrapperAuthState();
}

class _WrapperAuthState extends State<WrapperAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return HomeScreen(
              uid: snapshot.data!.uid,
            );
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
