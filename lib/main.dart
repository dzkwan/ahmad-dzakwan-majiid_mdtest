import 'package:fan_test/firebase_options.dart';
import 'package:fan_test/screens/splash_screen.dart';
import 'package:fan_test/themes/light_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'blocs/auth_bloc/bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: LightColors.mainColor,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fan Test App',
          builder: EasyLoading.init(),
          theme: ThemeData(
            primaryColor: LightColors.mainColor,
            scaffoldBackgroundColor: LightColors.white,
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Roboto',
                ),
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: LightColors.mainColor,
              foregroundColor: LightColors.white,
            ),
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
