import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/add_contact.dart';
import 'package:firebase_test/list_contacts.dart';
import 'package:firebase_test/manage_preference.dart';
import 'package:firebase_test/profil.dart';
import 'package:firebase_test/view_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'about.dart';
import 'auth/login.dart';
import 'components/buttomnavigationbar.dart';

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
      bottomNavigationBar: ButtomNavigationBar(),
    );
  }
}
