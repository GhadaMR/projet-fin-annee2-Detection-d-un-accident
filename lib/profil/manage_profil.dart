import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/Utilisateur.dart';
import '../components/custombuttonauth.dart';
import '../components/textformfield.dart';

class ProfileEditPage extends StatefulWidget {
  final Utilisateur? user;

  const ProfileEditPage({Key? key, required this.user}) : super(key: key);


  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {


  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dureeAlerteController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  void initState() {
    super.initState();
    usernameController.text = widget.user!.username;
    emailController.text = widget.user!.email;
    phoneNumberController.text = widget.user!.phoneNumber.toString();
    dureeAlerteController.text = widget.user!.dureeAlarme.toString();
    imageUrlController.text = widget.user!.imageUrl;
  }





  Future<void> _updateUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('users').doc(uid).update({
        'username': usernameController.text,
        'email': emailController.text,
        'phoneNumber': int.parse(phoneNumberController.text),
        'dureeAlerte': int.parse(dureeAlerteController.text),
        'imageUrl' :imageUrlController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User data updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user data')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                )),
            CustomTextForm(hinttext: 'Enter username', password: false, mycontroller: usernameController,validator: (val){
              if(val== ""){
                return "Can't be empty";
              }
            },),
            SizedBox(height: 20),
            Text('Email',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                )),
            CustomTextForm(hinttext: 'Enter email', password: false, mycontroller: emailController,validator: (val){
              if(val== ""){
                return "Can't be empty";
              }
            },),
            SizedBox(height: 20),
            Text('Phone Number',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                )),
            CustomTextForm(hinttext: 'Enter phone number', password: false, mycontroller: phoneNumberController,validator: (val){
              if(val== ""){
                return "Can't be empty";
              }
            },),
            SizedBox(height: 20),
            Text('Image URL',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                )),
            CustomTextForm(hinttext: 'Enter image Url', password: false, mycontroller: imageUrlController,validator: (val){
              if(val== ""){
                return "Can't be empty";
              }
            },),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserData,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );;
  }
}
