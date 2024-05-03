import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/Utilisateur.dart';
import '../components/buttomnavigationbar.dart';
import '../components/custombuttonauth.dart';
import '../components/textformfield.dart';
import 'manage_preference.dart';
class EditPreferences extends StatefulWidget {
  final Utilisateur? user;
  const EditPreferences({Key? key, required this.user}) : super(key: key);

  @override
  State<EditPreferences> createState() => _EditPreferencesState();
}

class _EditPreferencesState extends State<EditPreferences> {
  TextEditingController dureeAlerteController = TextEditingController();

  void initState() {
    super.initState();
    dureeAlerteController.text = widget.user!.dureeAlarme.toString();
    setState(() {

    });
  }





  Future<void> _updateUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('users').doc(uid).update({
        'dureeAlerte': int.parse(dureeAlerteController.text),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User data updated successfully')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ManagePreference()),
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
      //   title: Text('Edit Preferences'),
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
                      Text("Edit Preferences",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color: Colors.grey..shade400),),
                     // Text("${user?.username}",style: TextStyle(fontWeight:FontWeight.w600 ),)
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
                  Text('Alarm Duration :',style: TextStyle(fontWeight: FontWeight.w600),),
                  SizedBox(height: 10,),
                  CustomTextForm(hinttext: 'Enter Alarm Duration',chiffre: TextInputType.number, password: false, mycontroller: dureeAlerteController,validator: (val){
                    if(val== ""){
                      return "Can't be empty";
                    }
                  },),
                  SizedBox(height: 50),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Color(0XFF47EAD0))),
                    onPressed: _updateUserData,
                    child: Center(
                      child: Text('Save',style: TextStyle(
                        fontWeight: FontWeight.w600,

                        color: Colors.white, // Couleur du texte du bouton (si onPrimary n'est pas utilisé)
                        // Vous pouvez également personnaliser d'autres propriétés de texte ici.
                      ),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );;
  }
}
