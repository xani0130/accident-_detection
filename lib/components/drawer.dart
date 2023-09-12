import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../Screens/home/map.dart';
import '../Screens/home/sensor.dart';
import '../Screens/login/login.dart';
import '../Screens/register/Contact.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) => const RadialGradient(
                  center: Alignment.topCenter,
                  stops: [1, 1],
                  colors: [
                    Colors.red,
                    Colors.blueAccent,
                  ],
                ).createShader(bounds),
                child: const Icon(
                  Icons.map_outlined,
                  // size: 133,
                ),
              ),
              title: const Text('Map'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const GoolgeMap()));
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.contact_phone_rounded,
            //   color: Colors.blueAccent,),
            //   title: const Text('SMS'),
            //   onTap: () => {
            //   Navigator.push(context,
            //   MaterialPageRoute(builder: (context) =>  TwilioScreen()))
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.contact_phone_rounded,
            //     color: Colors.blueAccent,
            //   ),
            //   title: const Text('Contact'),
            //   onTap: () => {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => ContactUs()))
            //   },
            // ),
            ListTile(
              leading: const Icon(
                Icons.chat,
                color: Colors.blueAccent,
              ),
              title: const Text('Sensor'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Accelometter()))
              },
            ),

            ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                title: const Text('Logout'),
                onTap: () {
                  {
                    FirebaseAuth.instance.signOut().then(
                      (value) {
                        print('sign out');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
