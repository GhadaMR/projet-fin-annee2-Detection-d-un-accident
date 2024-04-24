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
          Container(height: 50,),
          Text("Who we are", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green),),
          Center(
            child: Image.asset(
              'assets/images/LOGO1.JPG', // Chemin de votre image dans le dossier "assets"
              width: 200, // Largeur de l'image
              height: 150, // Hauteur de l'image
            ),
          ),
          Center(child: Padding(
    padding: EdgeInsets.all(16.0), // Adjust padding as needed
    child: Container(
    margin: EdgeInsets.all(16.0),
    child: Text("Our mission at SecuRoute is to revolutionize road safety through cutting-edge accident detection and tracking technology. With a relentless focus on innovation and efficiency, we are dedicated to creating a safer driving environment for all. By harnessing the power of advanced algorithms and real-time data analysis, our application swiftly identifies accidents and seamlessly tracks vehicles, ensuring prompt emergency response and providing crucial insights for accident prevention. At SecuRoute, we are committed to shaping a future where road accidents are minimized, and journeys are safer for everyone.", style: TextStyle(fontSize: 15,),
    textAlign: TextAlign.center,
    ),
    ),
          ),
          ),
        ],
      ),
    );
  }
}
