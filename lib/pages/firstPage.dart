import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:personal_todo/pages/homePage.dart';
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  GoogleSignInAccount _currentUser;

 @override
  void initState() {
    super.initState();
    // _handleSignIn();
      
     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){
      setState(() {
        _currentUser = account;
      });
      
      if(_currentUser!=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>HomePage()));
      }
      print(_currentUser);
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: 20,left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: GoogleSignInButton(onPressed: (){
                  _handleSignIn();
                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}