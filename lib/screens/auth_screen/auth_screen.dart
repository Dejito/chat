import 'package:chatter/widget/auth_form.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';


class AuthScreen extends StatefulWidget {
   const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitFn (String username, String email, String password, bool isLoggedIn, File image, BuildContext context,) async{
    try{
      setState(() {
        _isLoading =! _isLoading;
      });
      if(isLoggedIn){ 
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        // print('login successful');
      } else {
        final authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance.ref().child('user_images').child('${authResult.user!.uid}.jpeg');
        await ref.putFile(image);

       final imageURL = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(
            authResult.user?.uid).set({
          'username': username,
          'email': email,
          'imageUrl': imageURL
        });
        setState(() {
          _isLoading =! _isLoading;
        });

      }
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()),
          duration: const Duration(seconds: 2),
          ));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,

      body: AuthForm(_submitFn, _isLoading),
    );
  }
}
