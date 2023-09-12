import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import '../../apis.dart';
import '../../components/chat_user_card.dart';
import '../../components/drawer.dart';
import '../../helper/dialogs.dart';
import '../../model/chat_user.dart';
import '../login/login.dart';
import '../profile_screen.dart';
import 'map.dart';

//home screen -- where all available contacts are shown
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String? _currentAddress;
  Position? _currentPosition;
  bool _shouldSend = true;
  Timer? messageTimer;
  bool _hasShownAlert = false;


  // for storing searched items
  final List<ChatUser> _searchList = [];
  // for storing search status
  bool _isSearching = false;

  final twilio = TwilioFlutter(
    accountSid: 'AC18a8ee8b773e5f63686cea69616353b7',
    authToken: '3855faa7dda6c0bcab7443e17ff7fa72',
    twilioNumber: '+13158430796',
  );
  bool _isShaking = false;
  String number = '+923036209000';
  String _message = "message";
  late StreamSubscription _accelerometerSubscription;
  String _messageStatus = '';

  @override
  void initState() {
    super.initState();

    APIs.getSelfInfo();
    _getCurrentPosition();
    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      if (!_hasShownAlert && event.x.abs() > 30.0 ||
          !_hasShownAlert && event.y.abs() > 30.0 ||
          !_hasShownAlert && event.z.abs() > 30.0) {
        startTimer();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.red,
              title: const Text(
                'Sensor Alert',
                style: TextStyle(color: Colors.white),
              ),
              content: const Text(
                'The sensor has detected Accident.',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 200,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(0),
                    ),
                    onPressed: () {
                      cancelTimer();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
        // The device is shaking
        setState(() {
          _isShaking = true;
          _hasShownAlert = true;
        });

        // _sendMessage(number, _message);
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
    messageTimer?.cancel();
  }
  void startTimer() {
    messageTimer = Timer(Duration(seconds: 30), () {
      if (_shouldSend) {
        _sendMessage(number,_message);
      }
    });
  }
  void cancelTimer() {
    messageTimer?.cancel();
    setState(() {
      _shouldSend = false;
    });
  }


  Future<void> _sendMessage(String phoneNumber, String message) async {
    try {
      String message = 'Accident Detected at this  location: \n'
          'LAT: ${_currentPosition?.latitude ?? ""}\n'
          'LNG: ${_currentPosition?.longitude ?? ""}\n'
          'ADDRESS: ${_currentAddress ?? ""}';

      print('LAT: ${_currentPosition?.latitude ?? ""}');
      print('LNG: ${_currentPosition?.longitude ?? ""}');
      print('ADDRESS: ${_currentAddress ?? ""}');
      await twilio.sendSMS(
        toNumber: number,
        messageBody: message,
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 34, 45, 255),
                Color.fromARGB(255, 255, 41, 41)
              ])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            //app bar
            // drawer: NavDrawer(),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text('Accident Detection'),
              actions: [
                //more features button
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProfileScreen(user: APIs.me)));
                    },
                    icon: const Icon(Icons.person))
              ],
            ),

            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, bottom: 80),
                  child: Image.asset("assets/images/mainpic.png",
                      width: size.width * 0.85),
                ),
                Container(
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(

                    onTap: () {
                      _getCurrentPosition();
                      _sendMessage(number,_message);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "ALERT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(0),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GoolgeMap()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "GET LOCATION",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
    print('LAT: ${_currentPosition?.latitude ?? ""}');
    print('LNG: ${_currentPosition?.longitude ?? ""}');
    print('ADDRESS: ${_currentAddress ?? ""}');
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void _showSnackbar(BuildContext context) async {
    final location = await _getCurrentPosition();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Current Location: $_getCurrentPosition'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
