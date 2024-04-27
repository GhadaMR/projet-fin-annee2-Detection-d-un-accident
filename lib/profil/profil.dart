import 'package:firebase_test/profil/manage_profil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/auth/Utilisateur.dart';
import 'package:firebase_test/components/buttomnavigationbar.dart';

class ViewProfil extends StatefulWidget {
  const ViewProfil({Key? key}) : super(key: key);

  @override
  State<ViewProfil> createState() => _ViewProfilState();
}

class _ViewProfilState extends State<ViewProfil> {
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
            child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0,100.0,0.0,20.0),
                      child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: user!.imageUrl.isEmpty
                      ? Icon(Icons.account_circle, size: 120, color: Colors.grey)
                      : CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(user!.imageUrl),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${user?.username}',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
                color: Colors.tealAccent[400], // Couleur du texte du bouton (si onPrimary n'est pas utilisé)
                  // Vous pouvez également personnaliser d'autres propriétés de texte ici.
                ),
                ),

                SizedBox(height: 10),

                Text(
                  ' ${user?.email}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),

                Text(
                  ' ${user?.phoneNumber}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 70),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileEditPage(user: user,)),
                    );
                  },
                  child: Text('Edit profil',style: TextStyle(
                    color: Colors.tealAccent[400], // Couleur du texte du bouton (si onPrimary n'est pas utilisé)
                    // Vous pouvez également personnaliser d'autres propriétés de texte ici.
                  ),),
                ),

              ],
                      ),
                    ),

          )

          : Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: ButtomNavigationBar(),
    );
  }
}