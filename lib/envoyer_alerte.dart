import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'auth/Utilisateur.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  Utilisateur? user;
  //late   int _duration ;
  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
     fetchUserData();
    //print("userInitState :${user?.uid}");



  }




  Future<void> fetchUserData() async {
    User? firebaseUser =  FirebaseAuth.instance.currentUser;
    //print('Current User: $firebaseUser');
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
            dureeAlarme: userData['dureeAlarme'] != null ? int.parse(userData['dureeAlarme']) : 90,);

        });
        //_duration=user!.dureeAlarme;
      }

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: user!=null
      ?Column(
        children: [
          Center(
            child: CircularCountDownTimer(

              // Countdown duration in Seconds.
              duration: user!.dureeAlarme,

              // Countdown initial elapsed Duration in Seconds.
              initialDuration: 0,

              // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
              controller: _controller,

              // Width of the Countdown Widget.
              width: MediaQuery.of(context).size.width / 2,

              // Height of the Countdown Widget.
              height: MediaQuery.of(context).size.height / 2,

              // Ring Color for Countdown Widget.
              ringColor: Colors.grey[300]!,

              // Ring Gradient for Countdown Widget.
              ringGradient: null,

              // Filling Color for Countdown Widget.
              fillColor: Colors.pink[800]!,

              // Filling Gradient for Countdown Widget.
              fillGradient: null,

              // Background Color for Countdown Widget.
              backgroundColor: Colors.white,

              // Background Gradient for Countdown Widget.
              backgroundGradient: null,

              // Border Thickness of the Countdown Ring.
              strokeWidth: 20.0,

              // Begin and end contours with a flat edge and no extension.
              strokeCap: StrokeCap.round,

              // Text Style for Countdown Text.
              textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),

              // Format for the Countdown Text.
              textFormat: CountdownTextFormat.S,

              // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
              isReverse: true,

              // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
              isReverseAnimation: true,

              // Handles visibility of the Countdown Text.
              isTimerTextShown: true,

              // Handles the timer start.
              autoStart: true,

              // This Callback will execute when the Countdown Starts.
              onStart: () {
                // Here, do whatever you want
                debugPrint('Countdown Started');
              },

              // This Callback will execute when the Countdown Ends.
              onComplete: () {
                // Here, do whatever you want
                debugPrint('Countdown Ended');
                //fonction to send the alert to the contacts that have getAlert=true
              },

              // This Callback will execute when the Countdown Changes.
              onChange: (String timeStamp) {
                // Here, do whatever you want
                debugPrint('Countdown Changed $timeStamp');
              },


              timeFormatterFunction: (defaultFormatterFunction, duration) {
                if (duration.inSeconds == 0) {
                  // only format for '0'
                  return "Alert sent";
                } else {
                  // other durations by it's default format
                  return Function.apply(defaultFormatterFunction, [duration]);
                }
              },
            ),
          ),

          SizedBox(
            width:200 ,
            height: 120,
            child: ElevatedButton(onPressed: () => _controller.pause(),
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.pink[700]),

            ),
              child: const Text('Cancel', style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),
              ),),
          )
        ],
      ):Center(
    child: CircularProgressIndicator(),

    )
    );

  }

}
