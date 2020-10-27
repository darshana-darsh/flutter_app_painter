import 'dart:io';
import 'dart:async';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';

import 'ColorCodes.dart';

class Albumn extends StatefulWidget {
  @override
  _AlbumnState createState() => _AlbumnState();
}

class _AlbumnState extends State<Albumn> {
  List<File> imageList = new List();
  List<String> imageUrlList = new List();
  File _imagePath;
  bool colorCodeSelect=false;
  var document;
  final db = Firestore.instance;
  Widget getRecord(int index, File imageListFile, data) {
    return Container(

      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 8.0, bottom: 5.0),
            child:
            Container(
              //padding: EdgeInsets.all(30.0),
                width: 95.0,
                height: 95.0,
                //color: Colors.red,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.file(
                    data['arrayOfImages'],
                    fit: BoxFit.cover,
                  ),
                )),
          ),
         
        ],
      ),
    );
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
getData();

  }

getData() async {
   document = await db
      .collection("painter")
      .document(UserPreference().getUserId())
      .get();
   print(document.data['albumn'].length);
   setState(() {
     document;
   });
}



  @override
  Widget build(BuildContext context) {
    return colorCodeSelect?ColorCodes(): Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Album",
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
          document==null?Container():    GridView.count(
                crossAxisCount: 2,

                //physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(document.data['albumn'].length, (index) {
                  print(document.data['albumn'][index]);
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                     //  Text(document.data['arrayOfImages'][index].toString()),
                        Container(

                            child: Image.network(document.data['albumn'][index],height: 100,width: 150),height: 150,width: 150,),
                      ],
                    ),
                  );
                }),



          ),
          /*InkWell(
            onTap: () {

              setState(() {
                colorCodeSelect=true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 40, top: 30),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Config_File.PRIMARY_COLOR),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Center(
                    child: Text(
                      "Color Codes",
                      style: TextStyle(color: Config_File.PRIMARY_COLOR),
                    )),
              ),
            ),
          ),*/
          SizedBox(height: 50,)
        ],
      ),
    );
  }
}
