import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'Screens/login/splash.dart';
import 'helper/dialogs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final twilio = TwilioFlutter(
  //   accountSid: 'f994e98a402f',
  //   authToken: '711bcfdb2a30e978a02d68abaa9ee71d',
  //   twilioNumber: '+13203178577',AC2bf8c2838a6a135017f5
  // );
  //
  // bool _isShaking = false;
  // String number = '+923336686077';
  // String _message = 'hi im zain sohail';
  //
  // late StreamSubscription _accelerometerSubscription;
  // String _messageStatus = '';
  // @override
  // void initState() {
  //   super.initState();
  //   _accelerometerSubscription =
  //       accelerometerEvents.listen((AccelerometerEvent event) {
  //     if (event.x.abs() > 15.0 ||
  //         event.y.abs() > 15.0 ||
  //         event.z.abs() > 15.0) {
  //       // The device is shaking
  //       setState(() {
  //         _isShaking = true;
  //       });
  //       _sendMessage(number, _message);
  //       // Send the current location data via SMS to a specified phone number
  //       // Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
  //
  //       print(
  //         _isShaking ? 'Accident detected!' : 'Move your phone',
  //       );
  //     } else {
  //       setState(() {
  //         _isShaking = false;
  //       });
  //     }
  //   });
  // }



  // @override
  // void dispose() {
  //   super.dispose();
  //
  //   // Unsubscribe from the accelerometer stream
  //   _accelerometerSubscription?.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(0, 255, 255, 255)));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
  // Future<void> _sendMessage(String phoneNumber, String message) async {
  //   try {
  //     final response = await twilio.sendSMS(
  //       toNumber: number,
  //       messageBody: _message,
  //       // fromNumber: 'YOUR_TWILIO_PHONE_NUMBER', // replace with your Twilio phone number
  //     );
  //     setState(() {
  //       _messageStatus = 'Message sent successfully to $number.';
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _messageStatus = 'Error sending message: $e';
  //     });
  //   }
  // }
}
