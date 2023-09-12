import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/Customized_Container.dart';
import '../../components/background.dart';
import '../../components/firebase_Auth_services.dart';
import '../register/Contact.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();



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
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('REGISTER',
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontStyle: FontStyle.italic)),
                  ],
                  onTap: () {},
                ),
              ),
              SizedBox(
                  height: size.height * 0.07,
              ),

              CustomizedTextfield(
                myController: _usernameController,
                hintText: 'Username',
                isPassword: false,
                labelText: 'Email',
              ),
              SizedBox(height: size.height * 0.03),
              CustomizedTextfield(
                myController: _emailController,
                hintText: 'Enter Your Email',
                isPassword: false,
                labelText: 'Email',
              ),
              SizedBox(height: size.height * 0.03),
              CustomizedTextField(
                myController: _passwordController,
                hintText: 'Enter Your Password',
                isPassword: true,
                labelText: 'Password',
              ),
              SizedBox(height: size.height * 0.03),
              CustomizedTextField(
                myController: _confirmPasswordController,
                hintText: 'Confirm password',
                isPassword: true,
                labelText: 'Confirm password',
              ),

              SizedBox(height: size.height * 0.05),
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
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    try {
                      await FirebaseAuthService().signup(

                          _emailController.text.trim(),
                          _passwordController.text.trim());
                      _confirmPasswordController.text.trim();

                      Navigator.of(context).pop();
                      if (!mounted) return;

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  LoginScreen()));
                    } on FirebaseException catch (e) {
                      debugPrint(e.message);
                    }

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => const LoginScreen()));
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
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()))
                  },
                  child: const Text(
                    "Already Have an Account? Sign in",
                    style: TextStyle(
                        fontSize: 12,
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
