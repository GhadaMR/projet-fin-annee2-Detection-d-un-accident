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
      // appBar: AppBar(
      //   title: Text('Add Contact'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
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
                        Text("Add Contact",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black),),
                       // Text("${user?.username}",style: TextStyle(fontWeight:FontWeight.w600 ),)
                      ],
                    )

                  ],
                ),
              ),
              Container(height: 40),
              Padding(padding: const EdgeInsets.all(10.0)
                ,child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        )),
                    SizedBox(height: 10),
                    CustomTextForm(hinttext: 'Enter name',chiffre: TextInputType.text, password: false, mycontroller: nomController,validator: (val){
                      if(val== ""){
                        return "Can't be empty";
                      }
                    },),
                    SizedBox(height: 30),
                    Text('First name:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        )),
                    SizedBox(height: 10),
                    CustomTextForm(hinttext: 'Enter first name',chiffre: TextInputType.text, password: false, mycontroller: prenomController,validator: (val){
                      if(val== ""){
                        return "Can't be empty";
                      }
                    },),
                    SizedBox(height: 30),
                    Text('Phone Number:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        )),
                    SizedBox(height: 10),
                    CustomTextForm(hinttext: 'Enter phone number',chiffre: TextInputType.number, password: false, mycontroller: numController,validator: (val){
                      if(val== ""){
                        return "Can't be empty";
                      }
                    },),
                    SizedBox(height: 30),
                    Row(children: [

                      Checkbox(value: recoitAlerte,
                          onChanged:(bool?value){
                            setState(() {
                              recoitAlerte=value??false;
                            });
                          }
                      ),
                      Text('Get Alerte',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
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
                        Text('Tracking',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),
                      ],
                    ),


                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()async{
                  try{
                    final name = nomController.text;
                    final firstName = prenomController.text;
                    final phoneNumber = "+216${numController.text}";
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
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Color(0XFF47EAD0))),

                  child: Text('Save',style: TextStyle(
                    color: Colors.white, // Couleur du texte du bouton (si onPrimary n'est pas utilisé)
                    // Vous pouvez également personnaliser d'autres propriétés de texte ici.
                  ),),




              ),
            ],
          ),

        ),
      ),
      bottomNavigationBar:ButtomNavigationBar(),
    );;
  }
}
