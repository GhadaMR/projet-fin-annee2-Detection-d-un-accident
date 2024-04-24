import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/buttomnavigationbar.dart';
import 'Contact.dart';
import 'ContactEditPage.dart';

class ListContacts extends StatefulWidget {
  const ListContacts({super.key});

  @override
  State<ListContacts> createState() => _ListContactsState();
}

class _ListContactsState extends State<ListContacts> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference users= FirebaseFirestore.instance.collection('users');
  List<QueryDocumentSnapshot> contacts=[];
  @override
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
    QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection('users').doc(uid).collection('contacts').get();
    contacts.addAll(querySnapshot.docs);
    setState(() {
    });

  }
  late Contact contact;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemBuilder: (context,i){
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink[700],
                      child: Text("${contacts[i]['first_name'][0]}",
                              style: TextStyle(
                                color: Colors.white
                              ),
                      ),
                    ),
                    title: Text("${contacts[i]['first_name']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    ),
                    subtitle: Text("${contacts[i]['phone_number']}"),
                    trailing: SizedBox(
                      width: 70,
                        child: Row(
                          children: [
                            InkWell(child: Icon(Icons.edit),
                                    onTap: (){
                                      setState(() {

                                        contact = Contact(id_Contact: contacts[i].id,
                                                  nom: contacts[i]['name'],
                                                  prenom: contacts[i]['first_name'],
                                                  num: contacts[i]['phone_number'],
                                                  recoitAlerte: (contacts[i]['get_alert'] == true) ? true : false,
                                                  tracking: (contacts[i]['tracking'] == true) ? true : false,

                                        );
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ContactEditPage(contact: contact,)),
                                      );

                                    },
                            ),
                          SizedBox(width: 15,),
                            InkWell(child: Icon(Icons.delete),
                              onTap: () async {
                                // Supprimer l'élément de la base de données Firebase
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(uid)
                                    .collection('contacts')
                                    .doc(contacts[i].id)
                                    .delete()
                                    .then((value) {
                                  // Si la suppression dans la base de données réussit,
                                  // supprimez également l'élément de la liste locale
                                  setState(() {
                                    contacts.removeAt(i);
                                  });
                                }).catchError((error) {
                                  print("Erreur lors de la suppression de l'élément : $error");
                                });
                              },
                            ),
                          ],
                        ),

                    ),
                  ),

                );
              },
          itemCount: contacts.length,
          scrollDirection: Axis.vertical,



        ),
      ),
      bottomNavigationBar:ButtomNavigationBar(),
    );;
  }
}
