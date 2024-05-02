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
    setState(() {

    });

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
      backgroundColor: Colors.grey[200],
      body: user != null
          ? SafeArea(
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
                          Text("Preferences",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color: Colors.grey..shade400),),
                          //Text("${user?.username}",style: TextStyle(fontWeight:FontWeight.w600 ),)
                        ],
                      )

                    ],
                  ),
                ),
                Container(height: 40),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),

                    ),

                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
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
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.secondary,
                                    Theme.of(context).colorScheme.primary,

                                    Theme.of(context).colorScheme.tertiary,
                                  ],
                                )
                            ),
                            child: Center(
                              child: Text(
                                '${user?.dureeAlarme}',
                                style: TextStyle(
                                  fontSize: 78,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white


                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Color(0XFF47EAD0))),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditPreferences(user: user,)),
                              );
                            },
                            child: Text('Edit', style: TextStyle(fontWeight: FontWeight.w600,
                              color: Colors.white, // Couleur du texte du bouton (si onPrimary n'est pas utilisé)
                              // Vous pouvez également personnaliser d'autres propriétés de texte ici.
                            ),),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ) : Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: ButtomNavigationBar(),
    );
  }
}
