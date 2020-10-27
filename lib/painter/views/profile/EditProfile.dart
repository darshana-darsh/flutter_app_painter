
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/painter/views/homeView/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController fullName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController experince = new TextEditingController();
  TextEditingController ratepsf = new TextEditingController();

  FocusNode _fullNameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _addressFocusNode = FocusNode();
  FocusNode _experienceFocusNode = FocusNode();
  FocusNode _rateFocusNode = FocusNode();
  String _email,_fullname,_phone,_address,_experience,_rate;
  final databaseReference = Firestore.instance;
  CollectionReference chatReference;
  bool _autoValidate = false;
  File _image;
  final picker = ImagePicker();
  String networkImage;
  String fileUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fullName.text=UserPreference().getUserNAme();
      email.text=UserPreference().getEmail();
      phone.text= UserPreference().getPhone()==null?"":UserPreference().getPhone();
      address.text= UserPreference().getAddress()==""?"":UserPreference().getAddress();
      experince.text= UserPreference().getExperince()==""?"":UserPreference().getExperince();
      ratepsf.text= UserPreference().getRate()==""?"":UserPreference().getRate();
      networkImage=UserPreference().getImage()==''?'':UserPreference().getImage();

    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
   setState(() {
     UserPreference().setImage("");
   });
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('profile/${UserPreference().getUserId()}/');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    await uploadTask.onComplete;
     fileUrl = await firebaseStorageRef.getDownloadURL();
   setState(() {
     fileUrl;
   });

   print(fileUrl);

  }
  void fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  void updateProfile() async {

   if(_key.currentState.validate()){
     _key.currentState.save();
     await databaseReference.collection("Users").document(UserPreference().getUserId()).updateData({
       "id": UserPreference().getUserId(),
       "username": fullName.text==""?UserPreference().getUserNAme():fullName.text,
       "email": email.text==""?UserPreference().getEmail():email.text,
       "profile_photo": fileUrl,
       "phone": phone.text==""?UserPreference().getPhone(): phone.text,
       "address": address.text==""?UserPreference().getAddress(): address.text,
       "experience": experince.text==""?UserPreference().getExperince(): experince.text,
       "rate": ratepsf.text==""?UserPreference().getRate(): ratepsf.text,

     });

     CircularProgressIndicator();
     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
   }
   else{
     setState(() {
       _autoValidate=true;

     });
   }

    // await clearRecord();

  }


  void clearData(){
    fullName.clear();
    phone.clear();
    address.clear();
    experince.clear();
    ratepsf.clear();
  }



  Future getCamera(context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
    uploadImageToFirebase(context);
    Navigator.of(context).pop();
  }

  Future openGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      _image = File(pickedFile.path);
    });
    uploadImageToFirebase(context);
    Navigator.of(context).pop();
  }
  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        getCamera(context);
                       // _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config_File.PRIMARY_COLOR,
        title: Text("Edit Profile"),
        leading: InkWell(onTap:(){
          Navigator.pop(context);
         // Get.offAllNamed("/viewProfile");
        },child: Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        children: [
          Form(
            key: _key,
            autovalidate: _autoValidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60,),
                Center(
                  child: InkWell(
                    onTap: (){
                      _showSelectionDialog(context);
                    },
                    child:_image==null? Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CircleAvatar(
                          // backgroundColor: Colors.black12,
                          radius: 50,
                          //  borderRadius: BorderRadius.circular(50),
                          child: _image==null?Image.asset("assets/images/user.png"):
                          Image.file(_image),
                        ),
                      ),
                    ):
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CircleAvatar(
                          // backgroundColor: Colors.black12,
                          radius: 50,
                          //  borderRadius: BorderRadius.circular(50),
                          child: UserPreference().getImage()==null?Image.asset("assets/images/user.png"):
                          Image.network(UserPreference().getImage()),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Change Photo",style: TextStyle(
                        color: Config_File.GREY_2,
                        fontSize: 14,fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left:50.0,bottom:2),
                  child: Text("Full Name",style: TextStyle(
                      color: Config_File.GREY_LIGHT,
                      fontSize: 14,fontWeight: FontWeight.normal
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0, left: 50,top: 10),
                  child: TextFormField(
                    controller: fullName,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    focusNode: _fullNameFocusNode,
                    onFieldSubmitted: (_){
                      fieldFocusChange(context, _fullNameFocusNode, _emailFocusNode);
                    },
                    validator: (String arg) {
                      if(arg.length < 3)
                        return 'Name must be more than 2 charater';
                      else
                        return null;
                    },
                    onSaved: (String val) {
                      _fullname = val;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:50.0,bottom:10,top:20),
                  child: Text("Email",style: TextStyle(
                      color: Config_File.GREY_LIGHT,
                      fontSize: 14,fontWeight: FontWeight.normal
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0, left: 50),
                  child: TextFormField(
                    controller: email,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                    onSaved: (email)=> _email = email,
                    focusNode: _emailFocusNode,
                    onFieldSubmitted: (_){
                      fieldFocusChange(context, _emailFocusNode, _phoneFocusNode);
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:50.0,bottom:10,top:20),
                  child: Text("Phone Number",style: TextStyle(
                      color: Config_File.GREY_LIGHT,
                      fontSize: 14,fontWeight: FontWeight.normal
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0, left: 50),
                  child: TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: Config_File.validateMobile,
                    onSaved: (phone)=> _phone = phone,
                    focusNode: _phoneFocusNode,
                    onFieldSubmitted: (_){
                      fieldFocusChange(context, _phoneFocusNode, _addressFocusNode);
                    },
                    maxLength: 10,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:50.0,bottom:10,top:20),
                  child: Text("Address",style: TextStyle(
                      color: Config_File.GREY_LIGHT,
                      fontSize: 14,fontWeight: FontWeight.normal
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0, left: 50),
                  child: TextFormField(
                    controller: address,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    focusNode: _addressFocusNode,
                    onFieldSubmitted: (_){
                      fieldFocusChange(context, _addressFocusNode, _experienceFocusNode);
                    },
                    validator: (String arg) {
                      if(arg.length == 0)
                        return 'Please Enter Address';
                      else
                        return null;
                    },
                    onSaved: (String val) {
                      _address = val;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,bottom:10,top:20),
                            child: Text("Experince(Years)",style: TextStyle(
                                color: Config_File.GREY_LIGHT,
                                fontSize: 14,fontWeight: FontWeight.normal
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0, left: 50),
                            child: TextFormField(
                              controller: experince,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              focusNode: _experienceFocusNode,
                              onFieldSubmitted: (_){
                                fieldFocusChange(context, _experienceFocusNode, _rateFocusNode);
                              },
                              validator: (String arg) {
                                if(arg.length == 0)
                                  return 'Please Enter experinece';
                                else
                                  return null;
                              },
                              onSaved: (String val) {
                                _experience = val;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:20.0,bottom:10,top:15),
                            child: Text("Rate per sq foot",style: TextStyle(
                                color: Config_File.GREY_LIGHT,
                                fontSize: 14,fontWeight: FontWeight.normal
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0, left: 20),
                            child: TextFormField(
                              controller: ratepsf,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              focusNode: _rateFocusNode,

                              validator: (String arg) {
                                if(arg.length == 0)
                                  return 'Please Enter rate';
                                else
                                  return null;
                              },
                              onSaved: (String val) {
                                _rate = val;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            clearData();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50.0, top: 20),
                            child: Container(
                              height: 40,
                              //  width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0)),
                                  border: Border.all(
                                      color: Config_File.PRIMARY_COLOR)),
                              child: Center(
                                  child: Text("Clear",
                                      style:
                                      TextStyle(color: Config_File.PRIMARY_COLOR))),
                            ),
                          ),
                        )),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            updateProfile();
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 20.0, right: 30, top: 20),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Config_File.PRIMARY_COLOR,
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(color: Config_File.WHITE),
                                  )),
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 30,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
