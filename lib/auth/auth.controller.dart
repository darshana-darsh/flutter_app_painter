import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';


import 'auth.service.dart';
import 'signin_enum.dart';

class AuthController  {

  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController fullnameController;
  AuthService _authService;


  AuthController() {
    _authService = AuthService();
  }

  @override


  @override


  handleAuthChanged(user) {
    if (user == null) {
    //  Get.offAllNamed("/login");
    } else {
    //  Get.offAllNamed("/");
    }
  }

  Future<String> handleSignIn(SignInType type ) async {

    if (type == SignInType.EMAIL_PASSWORD) {
      if (emailController.text == "" || passwordController.text == "") {

        return null;
      }
    }


    try {
      if (type == SignInType.EMAIL_PASSWORD) {
       var userId= await _authService.signInWithEmailAndPassword(
            emailController.text.trim(), passwordController.text.trim());
       print(userId);
        emailController.clear();
        passwordController.clear();
        return userId;
      }
      if (type == SignInType.GOOGLE) {
      var userId =  await _authService.signInWithGoogle();
        print("userpref"+userId);
        return userId;
      }
      if (type == SignInType.FACEBOOK) {
       // await _authService.signInFacebook();
        print("hello");
      }
    } catch (e) {

    }
  }

  handleSignUp() async {
    if (fullnameController.text == "" || emailController.text == "" ||
        passwordController.text == "") {
      try {
        String userID = await _authService.signUp(
          emailController.text.trim(), passwordController.text.trim(),
          fullnameController.text.trim(),);

        emailController.clear();
        passwordController.clear();

        return userID;
      } catch (e) {
        print(e);
      }
    }
  }


  handleSignOut() {

    _authService.signOut();


  }
}
