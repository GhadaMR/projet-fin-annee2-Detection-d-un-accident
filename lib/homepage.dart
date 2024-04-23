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
import 'auth/Utilisateur.dart';
import 'components/buttomnavigationbar.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:background_sms/background_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Utilisateur? user ;
  @override
  void initState() {
    fetchUserData();
    getData();
    super.initState();
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference users= FirebaseFirestore.instance.collection('users');
  List<QueryDocumentSnapshot> contacts=[];

  getData()async{
    QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection('users').doc(uid).collection('contacts').where('get_alert', isEqualTo: true).get();
    contacts.addAll(querySnapshot.docs);
    setState(() {
    });

  }

  Future<void> fetchUserData() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    print('Current User: $firebaseUser');
    if (firebaseUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

        setState(() {
          user = Utilisateur(
            uid: firebaseUser.uid,
            username: userData['username'],
            email: userData['email'],
            password: userData['password'],
            imageUrl: userData['imageUrl'].toString(),
            phoneNumber: userData['phoneNumber'].toString(),
            dureeAlarme: userData['dureeAlarme'] != null ? int.parse(userData['dureeAlarme']) : 30,



          );
        });
      }

    }
  }

  void requestSmsPermission(String receiver,String message ) async {
    var status2 = await Permission.sms.status;
    if (!status2.isGranted) {
      status2 = await Permission.sms.request();
      SmsStatus result = await BackgroundSms.sendMessage(
          phoneNumber: receiver, message: message);
      if (result == SmsStatus.sent) {
        print("Sent");
      } else {
        print("Failed");
      }
      print("message sent");
      if (status2.isDenied) {
        print("Persmission denied");
      }
    }
    else {
      SmsStatus result = await BackgroundSms.sendMessage(
          phoneNumber: receiver, message: message);
      if (result == SmsStatus.sent) {
        print("Sent");
      } else {
        print("Failed");
      }
    }
  }


  Future<String> getRealTimeTrackingLink(double latitude, double longitude) async {
    // Construire l'URL pour le suivi en temps réel avec la latitude et la longitude
    String trackingUrl = "https://www.google.com/maps/@$latitude,$longitude,17z";
    String apiKey = "AIzaSyDSwntoSn6hPDiGF70jIq9fcmmBjsZCSZA";
    //String trackingUrl = "https://www.google.com/maps/embed/v1/view?key=$apiKey&center=$latitude,$longitude&zoom=17&maptype=roadmap";

    //String iframeCode = '<iframe width="600" height="450" frameborder="0" style="border:0" src="$trackingUrl" allowfullscreen></iframe>';

    return trackingUrl;
  }


  Future<void> _sendLocation() async {
    // Vérifier et demander les autorisations de localisation
    var status = await Permission.location.request();


    if (!status.isGranted) {
      // Les autorisations n'ont pas été accordées, afficher une boîte de dialogue pour demander l'autorisation
      print("Les autorisations n'ont pas été accordées");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Autorisations de localisation"),
            content: Text(
                "Pour envoyer votre position, veuillez autoriser l'accès à la localisation."),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  if (await Permission.location.isGranted) {
                    // Si l'autorisation est accordée après la boîte de dialogue, continuer l'envoi de la position
                    _sendLocation();
                  }
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Récupérer la latitude et la longitude de la position
    double latitude = position.latitude;
    double longitude = position.longitude;

    // Créer le lien Google Maps avec la latitude et la longitude
    String googleMapsLink = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    // Obtenir le lien de suivi en temps réel
    String realTimeTrackingLink = await getRealTimeTrackingLink(latitude, longitude);

    // Ouvrir le lien Google Maps dans le navigateur du téléphone
    // Essayer d'ouvrir l'URL avec différentes méthodes
    try {
      // Méthode 1 : Ouvrir l'URL avec `launch`
      await launch(realTimeTrackingLink);
      print('launch $realTimeTrackingLink');
    } catch (e) {
      print('Could not launch $realTimeTrackingLink');
      // Gestion des erreurs
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Impossible d'ouvrir Google Maps."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }


    // Envoyer un SMS avec le lien Google Maps au numéro spécifié
    String message = "Voici ma position: $googleMapsLink\nSuivez ma position en temps réel: $realTimeTrackingLink";
    print(message);
    // envoyer le SMS en arrière-plan
    try{
      for(int i=0;i<contacts.length;i++){
        requestSmsPermission(contacts[i]['phone_number'], message );
      }
    }catch(e){
      print("Erreur:  $e");
    }
  }


  bool accident=false;
  Future<void> sendAudioFile(String filePath, String fileName) async {
    print(filePath);
    print(fileName);
    var url = Uri.parse('http://192.168.1.36:5000/api/upload_audio');
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
      print("response");
      print(decodedResponse["message"]);
      print(decodedResponse["message"] =="The audio represents a car accident.");
      if(decodedResponse["message"] =="The audio represents a car accident."){
        setState(() {
          accident=true;
        });
      }
      else{
        setState(() {
          accident=false;
        });
      }

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
            Text("Welcome", style: TextStyle(color: Colors.pink[800],
                fontSize: 30,
                fontWeight: FontWeight.bold),),
            Container(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mode Tracking',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Switch(
                  value: true,
                  onChanged: (bool value) {
                    if (value) {
                      _sendLocation();
                    }
                  },
                  activeColor: Colors.pink[800],
                  inactiveThumbColor: Colors.pink[800],
                ),
              ],
            ),
            ElevatedButton(onPressed: () async{
              String filePath = 'assets/jsu.mp3';
              String fileName = 'jsu.mp3';

              await sendAudioFile(filePath, fileName);
              if(accident==true){
                print("accident =true");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Timer()),
                );
              }
              else{
                print("accident =false");
              }
            },
                child: const Text('Get Result')),

            ElevatedButton(
              onPressed: _sendLocation,
              child: Text('Send My Location'),
            ),


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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Timer()),
          );
        },
        child: Text('Alert'),
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


