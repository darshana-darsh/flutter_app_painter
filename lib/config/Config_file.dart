import 'dart:io';
import 'dart:async';
import 'package:flutter_app/auth/auth.service.dart';
import 'package:flutter_app/auth/views/login.dart';
import 'package:flutter_app/painter/views/profile/ViewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';
import 'package:intl/intl.dart';

class Config_File{

  static const WHITE= Color(0xffFFFFFF);
  static const PRIMARY_COLOR= Color(0xffD81159);
  static const BLACK= Color(0xff000000);
  static const GREY= Color(0xff7a7a7a);
  static const BLUE= Color(0xff73d2de);
  static const GREY_2= Color(0xff888888);
  static const GREY_LIGHT= Color(0x61707070);
  static const GREEN= Color(0xff11D890);
  static const GREYDARK= Color(0xff707070);
  static const ORANGE= Color(0xffFFA500);
  //static const Grey_Light_shade= Color(0xffDEDEDE);
  static const Grey_Light_shade= Color(0xfff8f8f8);
  static const DARK_PINK= Color(0xff8f2d56);
  static const SEARCHBARCOLOR= Color(0xffE4E4E4);


  double scaledHeight(BuildContext context, double baseSize) {
    return baseSize * (MediaQuery.of(context).size.height / 800);
  }

  double scaledWidth(BuildContext context, double baseSize) {
    return baseSize * (MediaQuery.of(context).size.width / 375);
  }

  Drawer appDrawer(context){
     return Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.close,color: PRIMARY_COLOR,),),
              ),
             DrawerHeader(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white)
                ),
                 child: Column(
               children: [
                 Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                       // backgroundColor: Colors.black12,
                        radius: 50,
                      //  borderRadius: BorderRadius.circular(50),
                        child: UserPreference().getImage()==null?Image.asset("assets/images/user.png",):
                        Image.network(UserPreference().getImage()),
                      ),
                    ),
                ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(UserPreference().getUserNAme().toString(),style: TextStyle(
                     color: PRIMARY_COLOR,
                     fontSize: 14,fontWeight: FontWeight.bold
                   ),),
                 )
               ],


             )),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ViewProfile(
                  )));

                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,top: 20),
                      child: Icon(Icons.person,color: PRIMARY_COLOR,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,top: 20),
                      child: Text("My profile",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20,top: 10,),
                child: Container(
                  height: 0.6,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:20.0,top: 20),
                    child: Icon(Icons.indeterminate_check_box,color: PRIMARY_COLOR,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10.0,top: 20),
                    child: Text("Terms and Conditions",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20,top: 10,),
                child: Container(
                  height: 0.6,
                  color: Colors.grey,
                ),
              ),
              InkWell(
                onTap: (){
                  UserPreference().clearPreference();
                  AuthService().signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));


                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,top: 20),
                      child: Icon(Icons.exit_to_app,color: PRIMARY_COLOR,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,top: 20),
                      child: Text("Logout",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
     );
   }
  Future<File> getImageFromCamera() async {
    File _image=null;
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _image = image;
    return _image;
  }
  Future getImage() async {

    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    final File file = File(pickedFile.path);
    return file;
  }

  hideKeyboard(context){
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static showLoader (context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) =>
            Center( // Aligns the container to center
                child: Container(
                  // A simplified version of dialog.
                  width: 40.0,
                  height: 40.0,
                  child: new CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(PRIMARY_COLOR
                    ), strokeWidth: 2.5,),
                )
            )
    );


  }
  static cancelLoader(context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  static String getDate(DateTime date) {
    if (date != "null") {
      var formatter = new DateFormat('MMM dd, yyyy');
      String formatted = formatter.format(date);
      return formatted;
    } else {
      //  strEnd = getConvertedDateStamp(new DateTime.now().millisecondsSinceEpoch.toString());
      var formatter = new DateFormat('MMM dd, yyyy');
      return formatter.format(new DateTime.now());
    }
  }

  static Future toastMsg(String msg){
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  static String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
  static String validatePinCode(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{5,6}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter pin code';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid pin code';
    }
    return null;
  }
}