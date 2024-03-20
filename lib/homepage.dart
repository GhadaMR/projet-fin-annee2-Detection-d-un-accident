import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/contact/add_contact.dart';
import 'package:firebase_test/contact/list_contacts.dart';
import 'package:firebase_test/envoyer_alerte.dart';
import 'package:firebase_test/preferences/manage_preference.dart';
import 'package:firebase_test/profil/profil.dart';
import 'package:firebase_test/view_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'about.dart';
import 'auth/login.dart';
import 'components/buttomnavigationbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:background_sms/background_sms.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String phoneNumber="07xxxxxxxxx";
  String message="Message2";

  void requestSmsPermission() async {
    var status = await Permission.sms.status;
    if (!status.isGranted) {
      status = await Permission.sms.request();
      String result = await BackgroundSms.sendMessage(
          phoneNumber: phoneNumber, message: message) as String;
      if (result == SmsStatus.sent) {
        print("Sent");
      } else {
        print("Failed");
      }
      print("message sent");
      if (status.isDenied) {
        print("Persmission denied");
      }
    }
    else{
      String result = await BackgroundSms.sendMessage(
          phoneNumber: phoneNumber, message: message) as String;
      if (result == SmsStatus.sent) {
        print("Sent");
      } else {
        print("Failed");
      }
    }
  }

  void sendSms(String phoneNumber,String message ) async {
    String result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message) as String;
    if (result == SmsStatus.sent) {
      print("Sent");
    } else {
      print("Failed");
    }
  }
  get onPressed => null;

  get icon => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Container(height: 10,),
            Text("Welcome", style: TextStyle(color: Colors.pink[800] , fontSize: 30, fontWeight: FontWeight.bold ),),
            Container(height: 50,),
            Row(
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
            ElevatedButton(onPressed: (){
              try{

                requestSmsPermission();

              }catch(e){
                print("Erreur:  $e");
              }


            }, child: Text('Send SMS2')),

            ],
        ),
      ),
      bottomNavigationBar: ButtomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Timer()),
        ); },
        child: Text('Alert') ,
      ),
    );
  }
}
