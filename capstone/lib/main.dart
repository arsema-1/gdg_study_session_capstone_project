import 'package:capstone/services/auth_service.dart';
import 'package:capstone/auth/login_page.dart';
import 'package:capstone/home/home_page.dart';
import 'package:capstone/services/user_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';


void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );

  await UserManager.initializePrefs();

  bool isLoggedIn = await AuthService().getLoginStatus();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}


class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: isLoggedIn ? HomePage() : LoginPage(),
    );
  }
}
