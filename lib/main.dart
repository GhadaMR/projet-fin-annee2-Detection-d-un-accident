import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_test/auth/login.dart';
import 'package:firebase_test/homepage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_test/auth/signup.dart';


void  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'YOUR_RECAPTCHA_SITE_KEY');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 @override
  void initState() {
   FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
  if (user == null) {
    print('User is currently signed out!');
  } else {
    print('User is signed in!');
    print('User: $user');
    }
   });
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:ThemeData(
        colorScheme: ColorScheme.light(
            background: Colors.white,
            onBackground: Colors.black,
            primary: Color(0xFF2CCED2),
            secondary: Color(0xFF74EC8D),
            tertiary: Color(0xFF117AC1)
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? Login() : HomePage(),
    );
  }
}