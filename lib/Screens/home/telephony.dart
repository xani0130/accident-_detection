// import 'package:flutter/material.dart';
// import 'package:twilio_flutter/twilio_flutter.dart';
//
// class TwilioScreen extends StatefulWidget {
//   @override
//   _TwilioScreenState createState() => _TwilioScreenState();
// }
//
// class _TwilioScreenState extends State<TwilioScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _mcontroller = TextEditingController();
//   final twilio = TwilioFlutter(
//     accountSid: 'AC2bf8c2838a6a135017f5f994e98a402f',
//     authToken: '711bcfdb2a30e978a02d68abaa9ee71d',
//     twilioNumber: '+13203178577',
//   );
//   String _messageStatus = '';
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _mcontroller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _sendMessage(String phoneNumber, String message) async {
//     try {
//       final response = await twilio.sendSMS(
//         toNumber: phoneNumber,
//         messageBody: message,
//         // fromNumber: 'YOUR_TWILIO_PHONE_NUMBER', // replace with your Twilio phone number
//       );
//       setState(() {
//         _messageStatus = 'Message sent successfully to $phoneNumber.';
//       });
//     } catch (e) {
//       setState(() {
//         _messageStatus = 'Error sending message: $e';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Send a message with Twilio'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: _controller,
//               keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(
//                 labelText: 'Phone number',
//                 hintText: 'Enter phone number',
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _mcontroller,
//               keyboardType: TextInputType.multiline,
//               maxLines: null,
//               decoration: const InputDecoration(
//                 labelText: 'Message',
//                 hintText: 'Enter message',
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//
//                 final phoneNumber = _controller.text.trim();
//                 final message = _mcontroller.text.trim();
//                 _sendMessage(phoneNumber, message);
//                 print(message);
//               },
//               child: const Text('Send Message'),
//             ),
//             const SizedBox(height: 16),
//             Text(_messageStatus),
//           ],
//         ),
//       ),
//     );
//   }
// }
