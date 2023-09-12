// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../apis.dart';
import '../helper/dialogs.dart';
import '../model/chat_user.dart';
import 'login/login.dart';

//profile screen -- to show signed in user info
class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(

            gradient:  LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 34, 45, 255),
                  Color.fromARGB(255, 255, 41, 41)
                ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          //app bar
            appBar: AppBar(
              elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text('Profile Screen')),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton.extended(
                  backgroundColor: Colors.orangeAccent,
                  onPressed: () async {
                    //for showing progress dialog
                    Dialogs.showProgressBar(context);

                    await APIs.updateActiveStatus(false);

                    //sign out from app
                    await APIs.auth.signOut().then((value) async {
                      await GoogleSignIn().signOut().then((value) {
                        //for hiding progress dialog
                        Navigator.pop(context);

                        //for moving to home screen
                        Navigator.pop(context);

                        APIs.auth = FirebaseAuth.instance;

                        //replacing home screen with login screen
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>  LoginScreen()));
                      });
                    });
                  },
                  icon: const Icon(Icons.logout,color: Colors.red,),
                  label: const Text('Logout')),
            ),

            //body
            body: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .05),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // for adding some space
                      SizedBox(width: width, height: height * .03),

                      //user profile picture
                      Stack(
                        children: [
                          //profile picture
                          _image != null
                              ?

                          //local image
                          ClipRRect(
                              borderRadius:
                              BorderRadius.circular(height * .1),
                              child: Image.file(File(_image!),
                                  width: height * .2,
                                  height: height * .2,
                                  fit: BoxFit.cover))
                              :

                          //image from server
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(height * .1),
                            child: CachedNetworkImage(
                              width: height * .2,
                              height: height * .2,
                              fit: BoxFit.cover,
                              imageUrl: widget.user.image,
                              errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                  child: Icon(CupertinoIcons.person)),
                            ),
                          ),

                          //edit image button
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: MaterialButton(
                              elevation: 1,
                              onPressed: () {
                                _showBottomSheet();
                              },
                              shape: const CircleBorder(),
                              color: Colors.white,
                              child: const Icon(Icons.edit, color: Colors.blue),
                            ),
                          )
                        ],
                      ),

                      // for adding some space
                      SizedBox(height: height * .03),

                      // user email label
                      Text(widget.user.email,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),

                      // for adding some space
                      SizedBox(height: height * .05),

                      // name input field
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        initialValue: widget.user.name,
                        onSaved: (val) => APIs.me.name = val ?? '',
                        validator: (val) => val != null && val.isNotEmpty
                            ? null
                            : 'Required Field',
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            prefixIcon:
                            const Icon(Icons.person, color: Colors.white),
                            border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(12)),
                            hintText: 'Name',
                            label: const Text('Name'),labelStyle: const TextStyle(color: Colors.white)),
                      ),

                      // for adding some space
                      SizedBox(
                        height: height *.02,
                      ),

                      // about input field
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        initialValue: widget.user.about,
                        onSaved: (val) => APIs.me.about = val ?? '',
                        validator: (val) => val != null && val.isNotEmpty
                            ? null
                            : 'Required Field',
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            prefixIcon: const Icon(Icons.info_outline,
                                color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            hintText: 'About',
                            label: const Text('About'),labelStyle: const TextStyle(color: Colors.white)),
                      ),

                      // for adding some space
                      SizedBox(height: height * .05),

                      // update profile button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            minimumSize: Size(width * .5, height * .06)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            APIs.updateUserInfo().then((value) {
                              Dialogs.showSnackbar(
                                  context, 'Profile Updated Successfully!');
                            });
                          }
                        },
                        icon: const Icon(Icons.edit, size: 28),
                        label:
                        const Text('UPDATE', style: TextStyle(fontSize: 16)),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  // bottom sheet for picking a profile picture for user
  void _showBottomSheet() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
            EdgeInsets.only(top: height * .03, bottom: height * .05),
            children: [
              //pick profile picture label
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

              //for adding some space
              SizedBox(height: height * .02),

              //buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick from gallery button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(width * .3, height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/add_image.png')),

                  //take picture from camera button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(width * .3,height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/camera.png')),
                ],
              )
            ],
          );
        });
  }
}
