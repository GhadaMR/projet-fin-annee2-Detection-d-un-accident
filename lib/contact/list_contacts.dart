import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/buttomnavigationbar.dart';
import 'ContactEditPage.dart';

class ListContacts extends StatefulWidget {
  const ListContacts({super.key});

  @override
  State<ListContacts> createState() => _ListContactsState();
}

class _ListContactsState extends State<ListContacts> {

  List<QueryDocumentSnapshot> contacts=[];
  @override
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
    QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection("contacts").get();
    contacts.addAll(querySnapshot.docs);
    setState(() {
    });

  }
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
                                    /*onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ContactEditPage(contact: contacts[i],)),
                                      );

                                    },*/
                            ),
                          SizedBox(width: 7,),
                            InkWell(child: Icon(Icons.delete),
                                    onTap: (){
                              setState(() {
                                contacts.removeAt(i);
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
