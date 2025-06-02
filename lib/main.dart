import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/data/realm/realm_services/realm.dart';
import 'package:nhan_tin_noi_bo/features/auth/screens/RegisterScreen.dart';
import 'package:nhan_tin_noi_bo/features/auth/screens/SignIn.dart';
import 'package:nhan_tin_noi_bo/features/auth/screens/WelcomeScreen.dart';
import 'package:nhan_tin_noi_bo/features/user/screens/HomeScreen.dart';
import 'package:nhan_tin_noi_bo/presentation/splash/SplashScreen.dart';
import 'package:nhan_tin_noi_bo/features/auth/screens/SignUp.dart';
import 'package:permission_handler/permission_handler.dart';

import 'features/chat/NotificationServiceManager.dart';

void main  () async{
  WidgetsFlutterBinding.ensureInitialized();
  await [
    Permission.notification,
    Permission.scheduleExactAlarm,
  ].request();

  await NotificationServiceManager().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}