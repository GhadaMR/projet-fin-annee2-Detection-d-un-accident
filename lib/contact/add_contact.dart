import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/buttomnavigationbar.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
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
