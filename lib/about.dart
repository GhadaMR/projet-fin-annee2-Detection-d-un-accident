import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
     // appBar: AppBar(
     //   title: Text("About us"),
    //  ),
      body: SafeArea(
        child: Column(children: [
          Container(
            color:Colors.grey[100],
            child: Row(

              children: [
                const SizedBox(height: 59),
                const SizedBox(width: 15,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color:  Color(0XFF47EAD0)
                  ),
                  child: Icon(CupertinoIcons.person_fill),
                ),
                const SizedBox(width: 8,),
                Column(
                  children: [
                    Text("About us",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color: Colors.grey..shade400),),
                   // Text("${user?.username}",style: TextStyle(fontWeight:FontWeight.w600 ),)
                  ],
                )

              ],
            ),
          ),
          Container(height: 40),
          Center(
            child: Container(
              width: 360,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),

                ),

              ),
              child: Column(
                children: [

                  Container(height: 50,),
                  Text("Who are we", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary,),),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.jpeg', // Chemin de votre image dans le dossier "assets"
                      width: 200, // Largeur de l'image
                      height: 150, // Hauteur de l'image
                    ),
                  ),
                  Center(child: Padding(
                    padding: EdgeInsets.all(8.0), // Adjust padding as needed
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      child: Text("Our mission at SecuRoute is to revolutionize road safety through cutting-edge accident detection and tracking technology. With a relentless focus on innovation and efficiency, we are dedicated to creating a safer driving environment for all. By harnessing the power of advanced algorithms and real-time data analysis, our application swiftly identifies accidents and seamlessly tracks vehicles, ensuring prompt emergency response and providing crucial insights for accident prevention. At SecuRoute, we are committed to shaping a future where road accidents are minimized, and journeys are safer for everyone.", style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ),
                ],
              ),
            ),
          ),
        ],),
      ),
    );
  }
}
