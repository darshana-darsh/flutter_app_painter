import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';



class UserPreference {
  static SharedPreferences preferences;
  static SharedPreferences preferencesFirstTime;
  static const String USER_ID = 'userId';
  static const String ACCESS_TOKEN = 'accessToken';
  static const String USER_NAME = 'UserName';
  static const String EMAIL = 'Email';
  static const String IMAGE = 'image';
  static const String ADDRESS = 'address';
  static const String DEVICETOKEN = 'deviceToken';
  static const String NOTIFICATION = 'nstatus';
  static const String PHONE = 'phone';
  static const String EXPERIENCE = 'experince';
  static const String RATE = 'rate';
  static const String CDATA = 'cdata';
  static const String LOGIN_STATUS = 'loginStatus';



  Future initSharedPreference () async {
    preferences = await SharedPreferences.getInstance();
  }
  static void initBoolData () {
    setLoginStatus(false);
  }
    void setUserId (String userId) {
    preferences.setString(USER_ID, userId);
  }
  static void setLoginStatus (bool status) {
    preferences.setBool(LOGIN_STATUS, status);
  }
  static bool getLoginStatus () {
    return preferences.getBool(LOGIN_STATUS);
  }
   String getUserId () {
    return preferences.getString(USER_ID);
  }
   void setUserName (String userName) {
    preferences.setString(USER_NAME, userName);
  }

   String getUserNAme () {
    return preferences.getString(USER_NAME);
  }
   void setEmail (String email) {
    preferences.setString(EMAIL, email);
  }

   String getEmail () {
    return preferences.getString(EMAIL);
  }

  void setPhone (String phone) {
    preferences.setString(PHONE, phone);
  }

  String getPhone() {
    return preferences.getString(PHONE);
  }
   String getAddress () {
    return preferences.getString(ADDRESS);
  }
   void setAddress (String address) {
    preferences.setString(ADDRESS, address);
  }

  String getExperince () {
    return preferences.getString(EXPERIENCE);
  }
  void setExperince (String experince) {
    preferences.setString(EXPERIENCE, experince);
  }




  String getRate () {
    return preferences.getString(RATE);
  }
  void setRate (String rate) {
    preferences.setString(RATE, rate);
  }




   void setImage (String image) {
    preferences.setString(IMAGE, image);
  }

   String getImage() {
    if (preferences.getString(IMAGE) != null) {
      return preferences.getString(IMAGE);
    } else {
      return "";
    }
  }

   void setAccessToken (String token) {
    preferences.setString(ACCESS_TOKEN, token);
  }

   String getAccessToken () {
    return preferences.getString(ACCESS_TOKEN);
  }

   void setDeviceToken (String token) {
    preferencesFirstTime.setString(DEVICETOKEN, token);
  }

   String getDeviceToken () {
    return preferencesFirstTime.getString(DEVICETOKEN);
  }

    setNotificationStatus (bool status) {
    preferences.setBool(NOTIFICATION, status);
  }

   bool getNotificationStatus () {
    return preferences.getBool(NOTIFICATION);
  }

   void clearPreference() {
    preferences.clear();
  }



}
