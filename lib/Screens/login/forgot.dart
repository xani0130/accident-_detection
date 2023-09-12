import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/Customized_Container.dart';
import '../../components/background.dart';
import 'register.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class ForgorScreen extends StatelessWidget {
  late AnimationController controller;
  late Animation<double> animation;
  final TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(

            gradient:  LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 34, 45, 255),
                  Color.fromARGB(255, 255, 41, 41)
                ])),
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('RESET PASSWORD',
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontStyle: FontStyle.italic
                        )),
                  ],
                  onTap: () {
                  },
                ),
              ),
              SizedBox(height: size.height * 0.10),
              CustomizedTextfield(
                myController: _emailController,
                hintText: 'Enter Your Email',
                isPassword: false,
                labelText: 'Email',
              ),

              SizedBox(height: size.height * 0.15),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.sendPasswordResetEmail(
                        email: _emailController.text).then((value) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),

                              title: const Text(
                                "Check your email and reset your password.",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.indigo
                                ),),
                              actions: [
                                TextButton(
                                  child: const Text("OK",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.indigo
                                    ),),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                )
                              ])
                      );
                    });
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
                      "RESET",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()))
                  },
                  child: const Text(
                    "Enter your Email to receive link...!",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
