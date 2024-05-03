import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/profil/profil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/Utilisateur.dart';
import '../components/buttomnavigationbar.dart';
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ViewProfil()),
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
      bottomNavigationBar: ButtomNavigationBar(),
     // appBar: AppBar(
     //   title: Text('Edit Profile'),
     // ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color:Colors.grey[100],
              child: Row(

                children: [
                  const SizedBox(height: 59),
                  const SizedBox(width: 15,),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color:  Color(0XFF47EAD0)
                    ),
                    child: Icon(CupertinoIcons.person_fill),
                  ),
                  const SizedBox(width: 8,),
                  Column(
                    children: [
                      Text("Edit Profil",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color: Colors.grey..shade400),),
                      //Text("${user?.username}",style: TextStyle(fontWeight:FontWeight.w600 ),)
                    ],
                  )

                ],
              ),
            ),
            Container(height: 40),
            Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username :',
                    style: TextStyle(
                        fontWeight: FontWeight.w600
                    )),
                SizedBox(height: 10),
                CustomTextForm(hinttext: 'Enter username',chiffre: TextInputType.text, password: false, mycontroller: usernameController,validator: (val){
                  if(val== ""){
                    return "Can't be empty";
                  }
                },),
                SizedBox(height: 30),
                Text('Email :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    )),
                SizedBox(height: 10),
                CustomTextForm(hinttext: 'Enter email',chiffre: TextInputType.emailAddress, password: false, mycontroller: emailController,validator: (val){
                  if(val== ""){
                    return "Can't be empty";
                  }
                },),
                SizedBox(height: 30),
                Text('Phone Number :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    )),
                SizedBox(height: 10),
                CustomTextForm(hinttext: 'Enter phone number',chiffre: TextInputType.number, password: false, mycontroller: phoneNumberController,validator: (val){
                  if(val== ""){
                    return "Can't be empty";
                  }
                },),
                SizedBox(height: 30),
                Text('Image URL :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    )),
                SizedBox(height: 10),
                CustomTextForm(hinttext: 'Enter image Url',chiffre: TextInputType.text, password: false, mycontroller: imageUrlController,validator: (val){
                  if(val== ""){
                    return "Can't be empty";
                  }
                },),
                SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Color(0XFF47EAD0))),
                    onPressed: _updateUserData,
                    child: Text('Save',style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600),),
                  ),
                ),
              ],
            ),
          ),],
        )
      ),
    );;
  }
}
