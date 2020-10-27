import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/painter/model/CustomerModel.dart';
import 'package:flutter_app/painter/views/homeView/home.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomerList.dart';

class CustomerDetailPage extends StatefulWidget {
  @override
  _CustomerDetailPageState createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  int _radioValueCustomer;
  int _radioValueCustomerStatus;
  int customerType, customerStatus;
  SharedPreferences prefs;
  String id;
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController fullnameController = new TextEditingController();
  TextEditingController emailContoller = new TextEditingController();
  TextEditingController contactController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController pincodeController = new TextEditingController();

  FocusNode _fullNameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _addressFocusNode = FocusNode();
  FocusNode _cityFocusNode = FocusNode();
  FocusNode _countryFocusNode = FocusNode();
  FocusNode _pincodeFocusNode = FocusNode();
  String _email,_fullname,_phone,_address,_city,_country,_pincode;
  CustomerModel model;
  int randomNumber;
  final databaseReference = Firestore.instance;
  bool _autoValidate = false;
  setRadioButton(int value) {
    setState(() {
      _radioValueCustomer = value;
      customerType = value;
    });
  }

  setRadioButton2(int value) {
    setState(() {
      _radioValueCustomerStatus = value;
      customerStatus = value;
    });
  }

  void createRecord() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      await databaseReference.collection("painter").document(id).collection("customerList").document(randomNumber.toString()).setData({
        "user_id": id,
        "customerId":randomNumber,
        "fullname": fullnameController.text,
        "email": emailContoller.text,
        "contact": contactController.text,
        "address": addressController.text,
        "city": cityController.text,
        "state": stateController.text,
        "pincode": pincodeController.text,
        "customerType": customerType,
        "customerStatus": customerStatus,
      });
      CircularProgressIndicator();
      await clearRecord();
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

    }
    else{
      setState(() {
        _autoValidate=true;
      });
    }

  //  Get.offAllNamed("/");


  }

  void clearRecord() {
    Config_File().hideKeyboard(context);

    setState(() {
      fullnameController.clear();
      emailContoller.clear();
      contactController.clear();
      addressController.clear();
      cityController.clear();
      stateController.clear();
      pincodeController.clear();
      _radioValueCustomer = 0;
      _radioValueCustomerStatus = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      id = UserPreference().getUserId();
    });
    _radioValueCustomer = 0;
    _radioValueCustomerStatus = 0;
    Random random = new Random();
    randomNumber = random.nextInt(10000);
  }

  void fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidate: _autoValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "New Customer",
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 22,
                color: Config_File.PRIMARY_COLOR,
                fontWeight: FontWeight.w300,
                height: 1.1363636363636365,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: Text(
              "Full Name",
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 14,
                color: Config_File.GREY,
                fontWeight: FontWeight.w300,
                height: 1.1363636363636365,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 20),
            child: TextFormField(
              controller: fullnameController,
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
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
            child: Text(
              "Email Address",
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 14,
                color: Config_File.GREY,
                fontWeight: FontWeight.w300,
                height: 1.1363636363636365,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 20),
            child: TextFormField(
              controller: emailContoller,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
              onSaved: (email)=> _email = email,
              focusNode: _emailFocusNode,
              onFieldSubmitted: (_){
                fieldFocusChange(context, _emailFocusNode, _phoneFocusNode);
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
            child: Text(
              "Phone Number",
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 14,
                color: Config_File.GREY,
                fontWeight: FontWeight.w300,
                height: 1.1363636363636365,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 20),
            child: TextFormField(
              controller: contactController,
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
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
            child: Text(
              "Address",
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 14,
                color: Config_File.GREY,
                fontWeight: FontWeight.w300,
                height: 1.1363636363636365,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 20),
            child: TextFormField(
              controller: addressController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              focusNode: _addressFocusNode,
              onFieldSubmitted: (_){
                fieldFocusChange(context, _addressFocusNode, _cityFocusNode);
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
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                      child: Text(
                        "City",
                        style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 14,
                          color: Config_File.GREY,
                          fontWeight: FontWeight.w300,
                          height: 1.1363636363636365,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0, left: 20),
                      child: TextFormField(
                        controller: cityController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        focusNode: _cityFocusNode,
                        onFieldSubmitted: (_){
                          fieldFocusChange(context, _cityFocusNode, _countryFocusNode);
                        },
                        validator: (String arg) {
                          if(arg.length == 0)
                            return 'Please Enter City';
                          else
                            return null;
                        },
                        onSaved: (String val) {
                          _city = val;
                        },
                        decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.only(bottom: 10, left: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
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
                      padding:
                      const EdgeInsets.only(left: 0.0, top: 0, bottom: 10),
                      child: Text(
                        "State/Country",
                        style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 14,
                          color: Config_File.GREY,
                          fontWeight: FontWeight.w300,
                          height: 1.1363636363636365,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: TextFormField(
                        controller: stateController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        focusNode: _countryFocusNode,

                        validator: (String arg) {
                          if(arg.length == 0)
                            return 'Please Enter Country';
                          else
                            return null;
                        },
                        onSaved: (String val) {
                          _country = val;
                        },
                        onFieldSubmitted: (_){
                          fieldFocusChange(context, _countryFocusNode, _pincodeFocusNode);
                        },
                        decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.only(bottom: 10, left: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                      child: Text(
                        "Pincode",
                        style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 14,
                          color: Config_File.GREY,
                          fontWeight: FontWeight.w300,
                          height: 1.1363636363636365,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0, left: 20),
                      child: TextFormField(
                        controller: pincodeController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: Config_File.validatePinCode,
                        onSaved: (pincode)=> _pincode = pincode,
                        focusNode: _pincodeFocusNode,

                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: "",
                            contentPadding:
                            EdgeInsets.only(bottom: 10, left: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: Text(
              "Type of Customer",
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 16,
                color: Config_File.PRIMARY_COLOR,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Row(
            //alignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Radio(
                  value: 1,
                  groupValue: _radioValueCustomer,
                  onChanged: (val) {
                    print("value----------");
                    setRadioButton(val);
                  },
                  activeColor: Config_File.GREY,
                ),
              ),
              Text(
                "Residential",
              ),
              Radio(
                value: 2,
                groupValue: _radioValueCustomer,
                onChanged: (value) {
                  print(value);
                  setRadioButton(value);
                },
                activeColor: Config_File.GREY,
              ),
              Text(
                "Commercial",
              ),
              Radio(
                value: 3,
                groupValue: _radioValueCustomer,
                onChanged: (value) {
                  print(value);
                  setRadioButton(value);
                },
                activeColor: Config_File.GREY,
              ),
              Text(
                "Society",
              ),
            ],
          ),
          // SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: Text(
              "Customer Status",
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 16,
                color: Config_File.PRIMARY_COLOR,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Radio(
                  value: 1,
                  groupValue: _radioValueCustomerStatus,
                  onChanged: setRadioButton2,
                  activeColor: Config_File.GREY,
                ),
              ),
              Text(
                "Approved Lead",
              ),
              Radio(
                value: 2,
                groupValue: _radioValueCustomerStatus,
                onChanged: setRadioButton2,
                activeColor: Config_File.GREY,
              ),
              Text(
                "Lost lead",
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Radio(
                  value: 3,
                  groupValue: _radioValueCustomerStatus,
                  onChanged: setRadioButton2,
                  activeColor: Config_File.GREY,
                ),
              ),
              Text(
                "Follow up in the future",
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                    onTap: () {
                      clearRecord();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 20),
                      child: Container(
                        height: 40,
                        //  width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: Config_File.PRIMARY_COLOR)),
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
                      createRecord();
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 10.0, right: 40, top: 20),
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
          InkWell(
            onTap: () {

              setState(() {
                // Get.offAllNamed("/addQuatation");
              });

            },
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 40, top: 30),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Config_File.PRIMARY_COLOR),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Center(
                    child: Text(
                      "Add Quatation",
                      style: TextStyle(color: Config_File.PRIMARY_COLOR),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
