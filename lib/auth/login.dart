import 'package:firebase_test/auth/signup.dart';
import 'package:flutter/material.dart';

import '../components/textformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 130),
                Center(child: Text("Login", style: TextStyle(fontSize:50, fontWeight:  FontWeight.bold),)),
                Container(height: 20),
                Text("email", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                Container(height: 20),
                CustomTextForm(hinttext: 'Enter your email', mycontroller: email,),
                Container(height: 20),
                Text("password", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                Container(height: 20),
                CustomTextForm(hinttext: 'Enter your password', mycontroller: password,),
                Container(height: 10,),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  alignment: Alignment.topRight,
                  child: Text(
                      "Forgot password ?",
                      textAlign: TextAlign.right ,
                      style: TextStyle(fontSize: 14)),
                ),
          ]),
          MaterialButton(
            height: 45,
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ) ,
            color: Colors.grey[800],
            textColor: Colors.white,
            onPressed: (){},child: Text("Login"),),
          Container(height: 100,),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "Don't have an account?",
                  ),
                  TextSpan(
                    text: " Register",
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