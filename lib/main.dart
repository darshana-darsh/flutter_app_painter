import 'package:flutter_app/auth/views/login.dart';
import 'package:flutter_app/painter/views/homeView/home.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/preferences/UserPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {


     runApp(new MaterialApp(
       debugShowCheckedModeBanner: false,
       home: new MyApp(),


     ));

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   UserPreference().initSharedPreference();

    new Future.delayed(
        const Duration(seconds: 3),
            () => navigation() );
  }

  @override
  Widget build(BuildContext context) {
   // Constant_Message.applicationContext=context;
    return GestureDetector(
      child: new Scaffold(
        backgroundColor: Colors.white,
        body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
               //   CommonWidget.getSurveyImage(logoSize.LOGO_HIGHT,logoSize.LOGO_WIDTH),

                ],
              )),

        ),
      );
  }

  navigation() {
    print(UserPreference.getLoginStatus());
    if (UserPreference.getLoginStatus() == null) {
      UserPreference.setLoginStatus(false);
    }

    bool loginStatus = UserPreference.getLoginStatus() != null
        ? UserPreference.getLoginStatus()
        : false;


;
    if (loginStatus) {
      //Go to home Page

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));

    }

    else  {
      //Go to Login page
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));

    }
  }
}