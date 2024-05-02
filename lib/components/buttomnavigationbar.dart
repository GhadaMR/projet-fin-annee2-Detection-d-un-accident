import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../about.dart';
import '../contact/add_contact.dart';
import '../auth/login.dart';
import '../contact/list_contacts.dart';
import '../preferences/manage_preference.dart';
import '../profil/profil.dart';
import '../view_history.dart';

class ButtomNavigationBar extends StatefulWidget {
  const ButtomNavigationBar({super.key});

  @override
  State<ButtomNavigationBar> createState() => _ButtomNavigationBarState();
}

class _ButtomNavigationBarState extends State<ButtomNavigationBar> {
  int _selectedIndex = 0; // Indice de la page actuellement sélectionnée

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor:Colors.white ,
      showSelectedLabels:true,
      showUnselectedLabels: false,
     /// selectedItemColor: Theme.of(context).colorScheme.primary,
     // fixedColor: Theme.of(context).colorScheme.primary,
     // currentIndex: 0,
      elevation: 3,
      items:  [
        BottomNavigationBarItem(

            label: 'Home',
            icon: Icon(CupertinoIcons.home, color: Colors.black,),
        ),

        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled, color: Colors.black,) ,label: 'Profile'

        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person_2_alt, color: Colors.black,) ,label: 'Contacts',

        ),

        BottomNavigationBarItem(
            label: 'Settings',
             icon: Icon(CupertinoIcons.settings, color: Colors.black,), )
      ],
      onTap: (int index){
        if(index==0){
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );


        }
        else if(index==1){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewProfil()
            ),
          );
          //this.widget.;
        }
        else if (index==2){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListContacts()),
          );
        }
        else if(index==3){
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ManagePreference()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.history),
                      title: Text('View history'),
                      onTap: () {
                        // Action lors du clic sur Élément 2
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewHistory()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('About us'),
                      onTap: () {
                        // Action lors du clic sur Élément 3
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutUs()),
                        );
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
        }
      },
    );


    /*BottomAppBar(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      IconButton(
        icon: Icon(CupertinoIcons.home,
      color: Colors.black,
    ),
        iconSize: 40,
        color: _selectedIndex == 0 ?   Colors.tealAccent[400]: Colors.grey[800],
        onPressed: () {
          setState(() {
            _selectedIndex = 0; // Mettre à jour l'indice de la page actuelle
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ),
      SizedBox(width: 20),
    IconButton(
    icon: Icon(CupertinoIcons.profile_circled, color: Colors.black),
    iconSize: 40,
      color: _selectedIndex == 1 ?   Colors.green[800]: Colors.grey[800],
    onPressed: () {
      setState(() {
        _selectedIndex = 1; // Mettre à jour l'indice de la page actuelle
      });
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ViewProfil()),
    );
    },
    ),
    SizedBox(width: 20),
    IconButton(
    icon: Icon(Icons.add),
    iconSize: 40,
      color: _selectedIndex == 2 ?   Colors.green[800]: Colors.grey[800],
      onPressed: () {
        setState(() {
          _selectedIndex = 2; // Mettre à jour l'indice de la page actuelle
        });
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddContact()),
    );
    },
    ),
    SizedBox(width: 20),
    IconButton(
    icon: Icon(CupertinoIcons.person_2_alt, color: Colors.black,),
    iconSize: 40,
      color: _selectedIndex == 3 ?   Colors.green[800]: Colors.grey[800],

      onPressed: () {
      setState(() {
        _selectedIndex = 3; // Mettre à jour l'indice de la page actuelle
      });
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ListContacts()),
    );
    },
    ),
    SizedBox(width: 10),
    IconButton(
    icon: Icon(CupertinoIcons.settings, color: Colors.black,),
    iconSize: 40,
      color: _selectedIndex == 4 ?   Colors.green[800]: Colors.grey[800],

      onPressed: () {
        setState(() {
          _selectedIndex = 4; // Mettre à jour l'indice de la page actuelle
        });
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
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ManagePreference()),
    );
    },
    ),
    ListTile(
    leading: Icon(Icons.history),
    title: Text('View history'),
    onTap: () {
    // Action lors du clic sur Élément 2
    Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ViewHistory()),
    );
    },
    ),
    ListTile(
    leading: Icon(Icons.info),
    title: Text('About us'),
    onTap: () {
    // Action lors du clic sur Élément 3
    Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AboutUs()),
    );
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
    );*/
  }
}
