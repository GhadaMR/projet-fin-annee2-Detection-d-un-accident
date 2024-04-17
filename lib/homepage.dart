import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/contact/add_contact.dart';
import 'package:firebase_test/contact/list_contacts.dart';
import 'package:firebase_test/envoyer_alerte.dart';
import 'package:firebase_test/preferences/manage_preference.dart';
import 'package:firebase_test/profil/profil.dart';
import 'package:firebase_test/view_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/buttomnavigationbar.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> sendAudioFile(String filePath, String fileName) async {
    print(filePath);
    print(fileName);
    var url = Uri.parse('http://10.0.2.2:5000/api/upload_audio');
    var request = http.MultipartRequest('POST', url);


    // Charger le fichier audio depuis les ressources de l'application
    var fileContent = await rootBundle.load(filePath);

    // Ajouter le fichier audio à la requête multipart
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileContent.buffer.asUint8List(),
        filename: fileName,
      ),
    );
    print("request: $request");
    print("fileContent: $fileContent");
    var response = await request.send();
    print("response $response");


    if (response.statusCode == 200) {

      print('Fichier audio envoyé avec succès');
      // Get the JSON response from the response stream
      var jsonResponse = await response.stream.bytesToString();
      print('JSON Response: $jsonResponse');

      // You can parse the JSON response if needed
      var decodedResponse = jsonDecode(jsonResponse);
      print('Decoded Response: $decodedResponse');

      // Handle the JSON data as needed
    } else {
      print('Échec de l\'envoi du fichier audio');
    }
  }

  get onPressed => null;

  get icon => null;
  String? _currentAddress;
  Position? _currentPosition;
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
            ElevatedButton(onPressed: () {
              String filePath='assets/jsu.mp3';
              String fileName='jsu.mp3';
              sendAudioFile(filePath,fileName);
            },
                child: const Text('Get Result')),

            Text('LAT: ${_currentPosition?.latitude ?? ""}'),
            Text('LNG: ${_currentPosition?.longitude ?? ""}'),
            Text('ADDRESS: ${_currentAddress ?? ""}'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                _currentPosition = await LocationHandler.getCurrentPosition();
                _currentAddress = await LocationHandler.getAddressFromLatLng(
                    _currentPosition!);
                setState(() {});
              },
              child: const Text("Get Current Location"),
            ),

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


abstract class LocationHandler {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print(' Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied') ;
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, we cannot request permissions.') ;

      return false;
    }
    print('Location Permission enabled');
    return true;
  }
  static Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await handleLocationPermission();
      if (!hasPermission) return null;
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];
      print("${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}");
      return "${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}";
    } catch (e) {
      return null;
    }
  }

}

