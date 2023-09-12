import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import '../../components/drawer.dart';
import '../../helper/dialogs.dart';



class Accelometter extends StatefulWidget {
  @override
  _AccelometterState createState() => _AccelometterState();
}

class _AccelometterState extends State<Accelometter>  {
  // bool _isShaking = false;
  // bool _isMessageSent = false;
  // late StreamSubscription _accelerometerSubscription;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   // Subscribe to the accelerometer stream and check for shaking
  //   _accelerometerSubscription =
  //       accelerometerEvents.listen((AccelerometerEvent event) {
  //         if (event.x.abs() > 15.0 || event.y.abs() > 15.0 || event.z.abs() > 15.0) {
  //           // The device is shaking
  //           setState(() {
  //             _isShaking = true;
  //           });
  //
  //           // Send the current location data via SMS to a specified phone number
  //           _sendLocationDataSMS();
  //         } else {
  //           setState(() {
  //             _isShaking = false;
  //           });
  //         }
  //       });
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //
  //   // Unsubscribe from the accelerometer stream
  //   _accelerometerSubscription?.cancel();
  // }
  // void _sendLocationDataSMS() async {
  //   if(!_isMessageSent){
  //     List<String> recipients = ['03158492262']; // Replace with your desired phone number
  //
  //     try {
  //       // Get the current position
  //       Position position = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);
  //
  //       // Get the address from the current position
  //       List<Placemark> placemarks =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //       String address = '${placemarks.first.street ?? ''},${placemarks.first.subLocality??''},${placemarks.first.subAdministrativeArea??''}';
  //
  //       // Send an SMS message with the current location data
  //       String message =
  //           ' Latitude: ${position.latitude}, Longitude: ${position.longitude}, Address: $address';
  //       await sendSMS(message: message, recipients: recipients);
  //       print('SMS sent successfully!');
  //     } catch (e) {
  //       print('Error sending SMS: $e');
  //     }
  //     _isMessageSent=true;
  //   }
  // }




  final twilio = TwilioFlutter(
    accountSid: 'AC2bf8c2838a6a135017f5f994e98a402f',
    authToken: '711bcfdb2a30e978a02d68abaa9ee71d',
    twilioNumber: '+13203178577',
  );
  bool _isShaking = false;
  String number = '+923336686077';
  String _message = 'hi im zain sohail';
  late StreamSubscription _accelerometerSubscription;
  String _messageStatus = '';
  @override
  void initState() {
    super.initState();
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
          if (event.x.abs() > 15.0 ||
              event.y.abs() > 15.0 ||
              event.z.abs() > 15.0) {
            // The device is shaking
            setState(() {
              _isShaking = true;
            });
            _sendMessage(number, _message);
            // Send the current location data via SMS to a specified phone number
            Dialogs.showSnackbar(context, 'Accident Detected!');

            print(
              _isShaking ? 'Accident detected!' : 'Move your phone',
            );
          } else {
            setState(() {
              _isShaking = false;
            });
          }
        });
  }
  @override
  void dispose() {
    super.dispose();

    // Unsubscribe from the accelerometer stream
    _accelerometerSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Accident Detect',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
// popup menu button
// actions: [
//   PopupMenuButton<int>(
//     itemBuilder: (context) => [
//       // popupmenu item 1
//       PopupMenuItem(
//         value: 1,
//         // row has two child icon and text.
//         child: Row(
//           children: [
//             Icon(Icons.person),
//             SizedBox(
//               // sized box with width 10
//               width: 10,
//             ),
//             TextButton(
//                 onPressed: (){
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => ProfileScreen(user: APIs.me)));
//                 },
//                 child: Text("Profile",
//                 style: TextStyle(
//                   color: Colors.black
//                 ),))
//           ],
//         ),
//       ),
//       // popupmenu item 2
//       PopupMenuItem(
//         value: 2,
//         // row has two child icon and text
//         child: Row(
//           children: [
//             Icon(Icons.chrome_reader_mode),
//             SizedBox(
//               // sized box with width 10
//               width: 10,
//             ),
//             TextButton(
//               onPressed: (){},
//               child: Text(
//                   'About',style: TextStyle(
//                   color: Colors.black
//               )
//               ),
//             )
//           ],
//         ),
//       ),
//     ],
//     offset: Offset(0, 100),
//     color: Colors.grey,
//     elevation: 2,
//   ),
// ],

      ),

      body: Center(
          child: Text(
            _isShaking ? 'Shaking detected!' : 'Shake your phone',
            style: TextStyle(fontSize: 24.0),
          ),
        ),

    );
  }
  Future<void> _sendMessage(String phoneNumber, String message) async {
    try {
      final response = await twilio.sendSMS(
        toNumber: number,
        messageBody: _message,
        // fromNumber: 'YOUR_TWILIO_PHONE_NUMBER', // replace with your Twilio phone number
      );
      setState(() {
        _messageStatus = 'Message sent successfully to $number.';
      });
    } catch (e) {
      setState(() {
        _messageStatus = 'Error sending message: $e';
      });
    }
  }
}
