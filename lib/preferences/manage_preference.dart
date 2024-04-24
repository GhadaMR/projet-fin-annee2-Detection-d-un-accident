import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_test/profil/manage_profil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/auth/Utilisateur.dart';
import 'package:firebase_test/components/buttomnavigationbar.dart';

import 'editpreferences.dart';

class ManagePreference extends StatefulWidget {
  const ManagePreference({super.key});

  @override
  State<ManagePreference> createState() => _ManagePreferenceState();
}

class _ManagePreferenceState extends State<ManagePreference> {
  Utilisateur? user;

  @override
  void initState() {
    fetchUserData();
    super.initState();

  }

  Future<void> fetchUserData() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    print('Current User: $firebaseUser');
    if (firebaseUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

        setState(() {
          user = Utilisateur(
            uid: firebaseUser.uid,
            username: userData['username'],
            email: userData['email'],
            password: userData['password'],
            imageUrl: userData['imageUrl'].toString(),
            phoneNumber: userData['phoneNumber'].toString(),
            dureeAlarme: userData['dureeAlarme'] != null ? int.parse(userData['dureeAlarme']) : 90,



          );
        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Alarm Duration:", style: TextStyle(fontSize: 40, ),),
            SizedBox(height: 30),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green[50],
              ),
              child: Center(
                child: Text(
                  '${user?.dureeAlarme}',
                  style: TextStyle(
                    fontSize: 78,

                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditPreferences(user: user,)),
                );
              },
              child: Text('Edit', style: TextStyle(fontSize: 20,
              color: Colors.green[800], // Couleur du texte du bouton (si onPrimary n'est pas utilisé)
                // Vous pouvez également personnaliser d'autres propriétés de texte ici.
              ),),
            ),
            SizedBox(height: 20),
          ],
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: ButtomNavigationBar(),
    );
  }
}
