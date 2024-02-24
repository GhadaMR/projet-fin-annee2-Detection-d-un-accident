import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/homepage.dart';
import 'package:flutter/material.dart';

import '../components/custombuttonauth.dart';
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

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(children: [
          Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 100),
                  Center(child: Text("SignUp", style: TextStyle(fontSize:50, fontWeight:  FontWeight.bold),)),
                  Container(height: 20),
                  Text("username", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                  Container(height: 20),
                  CustomTextForm(hinttext: 'Enter your username', mycontroller: username,validator: (val){
                    if(val== ""){
                      return "Can't be empty";
                    }
                  },),

                  Container(height: 20),
                  Text("email", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                  Container(height: 20),
                  CustomTextForm(hinttext: 'Enter your email', mycontroller: email,validator: (val){
                    if(val== ""){
                      return "Can't be empty";
                    }
                  },),
                  Container(height: 20),
                  Text("password", style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)),
                  Container(height: 20),
                  CustomTextForm(hinttext: 'Enter your password', mycontroller: password,validator: (val){
                    if(val== ""){
                      return "Can't be empty";
                    }
                  },),
                  Container(height: 40,),
                ]),
          ),
          CustomButtonAuth( title:"Sign Up",onPressed: () async{
          if(formState.currentState!.validate()){
            try {
            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email.text,
              password: password.text,
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: 'Error',
                  desc: 'The password provided is too weak.',
                  btnCancelOnPress: () {},
            btnOkOnPress: () {},
            )..show();
            } else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                title: 'Error',
                desc: 'The account already exists for that email.',
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              )..show();
            }
          } catch (e) {
            print(e);
          }}else{
            print("not valid");
          }},),
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