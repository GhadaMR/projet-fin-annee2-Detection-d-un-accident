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
    return BottomAppBar(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      IconButton(
        icon: Icon(Icons.home),
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
    icon: Icon(Icons.account_circle),
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
    icon: Icon(Icons.people),
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
    icon: Icon(Icons.list),
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
    );
  }
}
