import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/Utilisateur.dart';
import '../components/custombuttonauth.dart';
import '../components/textformfield.dart';
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
        title: Text('Edit Preferences'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Alarm Duration:'),
            CustomTextForm(hinttext: 'Enter Alarm Duration', mycontroller: dureeAlerteController,validator: (val){
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
