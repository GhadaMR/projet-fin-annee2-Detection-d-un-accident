import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/homepage.dart';
import 'package:flutter/material.dart';

import '../components/textformfield.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 100),
                Center(child: Text("SignUp", style: TextStyle(fontSize:50, fontWeight:  FontWeight.bold),)),
                Container(height: 20),
                Text("username", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                Container(height: 20),
                CustomTextForm(hinttext: 'Enter your username', mycontroller: username,),

                Container(height: 20),
                Text("email", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                Container(height: 20),
                CustomTextForm(hinttext: 'Enter your email', mycontroller: email,),
                Container(height: 20),
                Text("password", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                Container(height: 20),
                CustomTextForm(hinttext: 'Enter your password', mycontroller: password,),
                Container(height: 40,),
              ]),
          MaterialButton(
            height: 45,
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ) ,
            color: Colors.grey[800],
            textColor: Colors.white,
            onPressed: ()async{
              try {
                final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email.text,
                  password: password.text,
                );
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
            },child: Text("SignUp"),),
          Container(height: 100,),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "Have an account?",
                  ),
                  TextSpan(
                    text: "Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}