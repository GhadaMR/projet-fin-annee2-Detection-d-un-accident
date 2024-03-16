import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/textformfield.dart';
import 'Contact.dart';

class ContactEditPage extends StatefulWidget {
  final Contact contact;
   const ContactEditPage({super.key, required  this.contact});

  @override
  State<ContactEditPage> createState() => _ContactEditPageState();
}

class _ContactEditPageState extends State<ContactEditPage> {
  late bool recoitAlerte;
  late bool tracking;

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController numController = TextEditingController();


  void initState() {
    super.initState();
    nomController.text = widget.contact!.nom;
    prenomController.text = widget.contact!.prenom;
    numController.text = widget.contact!.num;
    recoitAlerte=widget.contact.recoitAlerte;
    tracking=widget.contact.tracking;


  }
  Future<void> _updateContactData() async{
    print("1111");
    String uid=FirebaseAuth.instance.currentUser!.uid;
    print("uid in initState: $uid");
    print("2222");
    String cid=widget.contact.id_Contact;

    print("3333");
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    print("4444");
    try{
      print("5555");
      await firestore.collection('users').doc(uid).collection('contacts').doc(cid).update(
      {
      'name': nomController.text,
        'first_name': prenomController.text,
        'phone_number': numController.text,
        'get_alert': recoitAlerte,
        'tracking': tracking,
      });
      print("6666");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contact data updated successfully')),
      );
    }catch (e) {
      print("7777");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update Contact data')),
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Contact'),
      ),
      body:SingleChildScrollView(
      child:Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Center(
              child: CircleAvatar(
                radius:50,
                backgroundColor: Colors.pink[700],
                child: Text(prenomController.text[0],
                  style: TextStyle(
                      color: Colors.white,
                    fontSize: 70,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Text('Name',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            CustomTextForm(hinttext: 'Enter name', mycontroller: nomController,validator: (val){
              if(val== ""){
                return "Can't be empty";
              }
            },),
            SizedBox(height: 20),
            Text('First name',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            CustomTextForm(hinttext: 'Enter first name', mycontroller: prenomController,validator: (val){
              if(val== ""){
                return "Can't be empty";
              }
            },),
            SizedBox(height: 20),
            Text('Phone Number',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            CustomTextForm(hinttext: 'Enter phone number', mycontroller: numController,validator: (val){
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
              Text('Get Alerte',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
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
                  ),),
              ],
            ),

            SizedBox(height: 20),
            ElevatedButton(onPressed: _updateContactData, child: Text('Update'))

          ],
        ),
      ),
      )
     // bottomNavigationBar:ButtomNavigationBar(),
    );;
  }
}
