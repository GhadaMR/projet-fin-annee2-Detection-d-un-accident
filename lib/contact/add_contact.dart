import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/auth/Utilisateur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/login.dart';
import '../components/buttomnavigationbar.dart';
import '../components/custombuttonauth.dart';
import '../components/textformfield.dart';
import '../homepage.dart';
import 'Contact.dart';
import 'list_contacts.dart';
import 'package:uuid/uuid.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {

  @override
  //TextEditingController id_ContactController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController numController = TextEditingController();


  bool recoitAlerte = false;
  bool tracking =false;
  final id_contact=Uuid().v4();

  String uid = FirebaseAuth.instance.currentUser!.uid;

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  CollectionReference users= FirebaseFirestore.instance.collection('users');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: SingleChildScrollView(
      child:Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name'),
            CustomTextForm(hinttext: 'Enter name', password: false, mycontroller: nomController,validator: (val){
              if(val== ""){
                return "Can't be empty";
              }
            },),
            SizedBox(height: 20),
            Text('First name'),
            CustomTextForm(hinttext: 'Enter first name', password: false, mycontroller: prenomController,validator: (val){
              if(val== ""){
                return "Can't be empty";
              }
            },),
            SizedBox(height: 20),
            Text('Phone Number'),
            CustomTextForm(hinttext: 'Enter phone number', password: false, mycontroller: numController,validator: (val){
              if(val== ""){
                return "Can't be empty";
              }
            },),
            SizedBox(height: 20),
            Row(children: [

              Checkbox(value: recoitAlerte,
                  onChanged:(bool?value){
                    setState(() {
                      recoitAlerte=value??false;
                    });
                  }
              ),
              Text('Get Alerte'),
            ],),

            SizedBox(height: 20),
            Row(
              children: [

                Checkbox(value: tracking,
                    onChanged:(bool?value){
                      setState(() {
                        tracking=value??false;
                      });
                    }
                ),
                Text('Tracking'),
              ],
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()async{
                try{
                  final name = nomController.text;
                  final firstName = prenomController.text;
                  final phoneNumber = numController.text;
                  if(name.isNotEmpty&&firstName.isNotEmpty&&phoneNumber.isNotEmpty){
                    setState(()async {
                      DocumentReference docRef =await users.doc(uid).collection('contacts').add({
                        'name': name,
                        'first_name': firstName,
                        'phone_number': phoneNumber,
                        'get_alert': recoitAlerte,
                        'tracking': tracking,

                      });
                      String id_Contact=docRef.id;

                      Contact newContact = Contact(
                        id_Contact: id_Contact,
                        nom: name,
                        prenom: firstName,
                        num: phoneNumber,
                        recoitAlerte: recoitAlerte,
                        tracking: tracking,
                      );
                      print("Contact Added");
                      nomController.text="";
                      prenomController.text="";
                      numController.text="";
                      recoitAlerte=false;
                      tracking=false;
                    });
                  }

                }catch (error) {
                  print("Erreur lors de l'ajout du contact: $error");}
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
      ),
      bottomNavigationBar:ButtomNavigationBar(),
    );;
  }
}
