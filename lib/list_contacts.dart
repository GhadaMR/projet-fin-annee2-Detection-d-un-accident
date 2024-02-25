import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/buttomnavigationbar.dart';

class ListContacts extends StatefulWidget {
  const ListContacts({super.key});

  @override
  State<ListContacts> createState() => _ListContactsState();
}

class _ListContactsState extends State<ListContacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

        ],
      ),
      bottomNavigationBar:ButtomNavigationBar(),
    );;
  }
}
