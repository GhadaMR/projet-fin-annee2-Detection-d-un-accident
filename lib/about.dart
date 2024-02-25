import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About us"),
      ),
      body: Column(
        children: [
          Text("Who we are", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
          Text("bla bla bla "),

        ],
      ),
    );
  }
}
