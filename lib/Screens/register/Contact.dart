// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import '../../components/Customized_Container.dart';
// import '../../components/background.dart';
// import '../login/login.dart';
//
// class ContactUs extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Background(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//
//               alignment: Alignment.centerLeft,
//               padding: const EdgeInsets.symmetric(horizontal: 40),
//               child: AnimatedTextKit(
//                 animatedTexts: [
//                   WavyAnimatedText('CONTACT',
//                       textStyle: const TextStyle(
//                           color: Color(0xFF2661FA),
//                           fontSize: 30,
//                           fontStyle: FontStyle.italic)),
//                 ],
//                 onTap: () {},
//               ),
//             ),
//             SizedBox(
//               height: size.height * 0.05,
//             ),
//
//             const CustomizedTextfield(
//               // myController: _usernameController,
//               hintText: 'Name',
//               isPassword: false,
//               labelText: 'Name',
//             ),
//             SizedBox(height: size.height * 0.03),
//             const CustomizedTextfield(
//               // myController: _emailController,
//               hintText: 'First Number',
//               isPassword: false,
//               labelText: 'first number',
//             ),
//             // SizedBox(height: size.height * 0.03),
//
//
//             SizedBox(height: size.height * 0.05),
//             Container(
//               alignment: Alignment.centerRight,
//               margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(80.0)),
//                   backgroundColor: Colors.white,
//                   padding: const EdgeInsets.all(0),
//                 ),
//                 onPressed: () async {
//
//                   // try {
//                   //   await FirebaseAuthService().signup(
//                   //
//                   //       _emailController.text.trim(),
//                   //       _passwordController.text.trim());
//                   //   _passwordController.text.trim();
//                   //
//                   //
//                   //   if (!mounted) return;
//                   //
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) =>  LoginScreen(user: widget.user)));
//                   // } on FirebaseException catch (e) {
//                   //   debugPrint(e.message);
//                   // }
//                   // Navigator.push(context,
//                   //     MaterialPageRoute(builder: (_) => const LoginScreen()));
//                 },
//                 child: Container(
//
//                   alignment: Alignment.center,
//                   height: 50.0,
//                   width: size.width * 0.4,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(80.0),
//                       gradient: const LinearGradient(colors: [
//                         Color.fromARGB(255, 255, 136, 34),
//                         Color.fromARGB(255, 255, 177, 41)
//                       ])),
//                   padding: const EdgeInsets.all(0),
//                   child: const Text(
//                     "Next",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               alignment: Alignment.centerRight,
//               margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//               child: GestureDetector(
//                 onTap: ()  {},
//                 child: const Text(
//                   "Change Number...?",
//                   style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF2661FA)),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
