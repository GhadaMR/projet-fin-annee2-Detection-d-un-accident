import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get onPressed => null;

  get icon => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        actions: [],
      ),
      body: ListView(
        children: [

          Container(height: 50,),
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(
                  'Mode Tracking',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Switch(
                  value: false,
                  onChanged: (bool value) {
                    // Gérer le changement d'état du Switch
                  },
                  activeColor: Colors.pink[800],
                  inactiveThumbColor: Colors.pink[800],
                ),
              ],
            ),
          ),
          ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 40,
              onPressed: () {
                // Naviguer vers la page de profil
                //Navigator.push(
                //  context,
               //   MaterialPageRoute(builder: (context) => ProfilePage()),
               // );
              },
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.add),
              iconSize: 40,
              onPressed: () {
                // Naviguer vers la page d'ajout de contact
                //Navigator.push(
               //   context,
                // MaterialPageRoute(builder: (context) => AddContactPage()),
                // );
              },
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.people),
              iconSize: 40,
              onPressed: () {
                // Naviguer vers la page de liste de contacts
                // Navigator.push(
                //  context,
                //  MaterialPageRoute(builder: (context) => ContactListPage()),
                //);
              },
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.list),
              iconSize: 40,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: ListView(
                        children: [
                          ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('Manage preference'),
                            onTap: () {
                              // Action lors du clic sur Élément 1
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.history),
                            title: Text('View history'),
                            onTap: () {
                              // Action lors du clic sur Élément 2
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.info),
                            title: Text('About us'),
                            onTap: () {
                              // Action lors du clic sur Élément 3
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.exit_to_app),
                            title: Text('Sign out'),
                            onTap: () async {
                              // Action lors du clic sur Élément 4
                              Navigator.pop(context);
                              await FirebaseAuth.instance.signOut();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
