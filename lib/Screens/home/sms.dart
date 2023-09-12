// import 'package:flutter/material.dart';
//
// class AddNumber extends StatelessWidget {
//   const AddNumber({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         title: const Text(
//           'Emergency Contact Number'
//         ),
//       ),
//       body:  Padding(
//         padding: const EdgeInsets.only(left: 28.0,right: 28,top: 30),
//         child: Form(
//           child: Column(
//             children: [
//               const Text('Add Your Emergency Person Contact Number!',style: TextStyle(
//                 color: Colors.indigo,
//                 fontSize: 27,
//                 fontWeight: FontWeight.bold
//               ),),
//               const SizedBox(
//                 height: 50,
//               ),
//               TextField(
//                 decoration:InputDecoration(
//                     border: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: Colors.indigo,
//                         ),
//                         borderRadius: BorderRadius.circular(20)
//                     ),
//                     hintText: 'Person Name',
//                     labelText: 'Person Name'
//                 ),
//
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 decoration:InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       color: Colors.indigo,
//                     ),
//                       borderRadius: BorderRadius.circular(20)
//                   ),
//                   hintText: 'Contact Number',
//                   labelText: 'Contact Number'
//                 ),
//
//               ),
//
//               const SizedBox(
//                 height: 50,
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 height: 50.0,
//                 width: size.width * 0.5,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(80.0),
//                     gradient: const LinearGradient(colors: [
//                       Color.fromARGB(255, 255, 136, 34),
//                       Color.fromARGB(255, 255, 177, 41)
//                     ])
//                 ),
//                 padding: const EdgeInsets.all(0),
//                 child: const Text(
//                   "Add Number",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
