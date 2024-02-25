import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/buttomnavigationbar.dart';

class ViewProfil extends StatefulWidget {
  const ViewProfil({super.key});

  @override
  State<ViewProfil> createState() => _ViewProfilState();
}

class _ViewProfilState extends State<ViewProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

        ],
      ),
      bottomNavigationBar:ButtomNavigationBar(),
    );
  }
}
