import 'package:firebase_test/profil/manage_profil.dart';
import 'package:flutter/cupertino.dart';
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
                          Text("Profil",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color: Colors.grey..shade400),),
                          Text("${user?.username}",style: TextStyle(fontWeight:FontWeight.w600 ),)
                        ],
                      )

                    ],
                  ),
                ),
                Container(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(

                    child:

                               Container(
                                 width: 350,
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.all(
                                       Radius.circular(20.0),

                                   ),

                                 ),

                                child: Column(
                                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(height: 50,),
                                                      user!.imageUrl!=null?CircleAvatar(
                                                        radius:70,
                                                        backgroundImage:AssetImage('assets/images/avatar.jpg'),
                                                        )
                                                        :
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
                                                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600,
                                                      color: Theme.of(context).primaryColor, // Couleur du texte du bouton (si onPrimary n'est pas utilisé)
                                                        // Vous pouvez également personnaliser d'autres propriétés de texte ici.
                                                      ),
                                                      ),

                                                      SizedBox(height: 10),

                                                      Text(
                                                        ' ${user?.email}',
                                                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                                                      ),
                                                      SizedBox(height: 10),

                                                      Text(
                                                        ' ${user?.phoneNumber}',
                                                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                                                      ),
                                                      SizedBox(height: 70),



                                                    ],
                                ),
                              ),


                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileEditPage(user: user,)),
                    );
                  },
                  child: Text('Edit profil',style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white, // Couleur du texte du bouton (si onPrimary n'est pas utilisé)
                    // Vous pouvez également personnaliser d'autres propriétés de texte ici.
                  ),),
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Color(0XFF47EAD0))),
                ),
              ],

            ),
          )

          : Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: ButtomNavigationBar(),
    );
  }
}