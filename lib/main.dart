import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/auth/login.dart';
import 'package:firebase_test/homepage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_test/auth/signup.dart';



void  main() {
   //WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 //@override
  //void initState() {
  // FirebaseAuth.instance
  //  .authStateChanges()
  // .listen((User? user) {
  // if (user == null) {
  //   print('User is currently signed out!');
  // } else {
  //  print('User is signed in!');
  //  }
  // });
  //super.initState();
  //}

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Login(),
      //FirebaseAuth.instance.currentUser == null ? Login() : HomePage(),
    );
  }
}