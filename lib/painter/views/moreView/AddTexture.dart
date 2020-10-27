import 'dart:io';
import 'dart:async';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';
import 'package:image_picker/image_picker.dart';

import 'ColorCodes.dart';

class Add_Texture extends StatefulWidget {
  @override
  _Add_TextureState createState() => _Add_TextureState();
}

class _Add_TextureState extends State<Add_Texture> {
  List<File> imageList = new List();

  List<String> imageUrlList = new List();
  File _imagePath;
  bool colorCodeSelect=false;
  final db = Firestore.instance;
  String id;
  int randomNumber;
  Future<QuerySnapshot> snapshot;
  AsyncSnapshot<QuerySnapshot> snapshots;
  List<DocumentSnapshot> nameList=[];

  Widget getRecord(int index, File imageListFile) {
    return Column(
      children: [
        Stack(
          children: <Widget>[
            Container(
              //padding: EdgeInsets.all(30.0),
                width: 95.0,
                height: 95.0,
                //color: Colors.red,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.file(
                    imageListFile,
                    fit: BoxFit.cover,
                  ),
                )),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    imageList.removeAt(index);
                  });
                },
                child: Icon(Icons.close),
              ),
            )
          ],
        ),
      ],
    );
  }


  void initState() {
    super.initState();
    setState(() {
      id = UserPreference().getUserId();
    });

  }

//add selected images to list

 /* Future uploadImageToFirebase() async {

    try {
      for (int i = 0; i < imageList.length; i++) {
        final StorageReference storageReference = FirebaseStorage().ref().child("albumn/$i");

        final StorageUploadTask uploadTask = storageReference.putFile(imageList[i]);

        final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {

          print('EVENT ${event.type}');
        });

        // Cancel your subscription when done.
        await uploadTask.onComplete;
        streamSubscription.cancel();

        String imageUrl = await storageReference.getDownloadURL();
        imageUrlList.add(imageUrl); //all all the urls to the list
      }
      //upload the list of imageUrls to firebase as an array
      await db.collection("painter").document(id).setData({
        "arrayOfImages": imageUrlList,
      });
    } catch (e) {
      print(e);
    }
  }*/

  Future uploadImageToFirebase(BuildContext context) async {
 for (int i = 0; i < imageList.length; i++) {
   StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(
       'albumn/$i');
   StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageList[i]);
   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
   taskSnapshot.ref.getDownloadURL().then(
         (value) {
           print(value);
           imageUrlList.add(value);
         },
   );
 }
    await db.collection("painter").document(id).setData({
           'albumn':
             imageUrlList

    });

    }

  @override
  Widget build(BuildContext context) {
    return colorCodeSelect?ColorCodes(): Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "New Texture",
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
       Stack(
         children: [
          InkWell(
            onTap: () async {

                _imagePath = await Config_File()
                    .getImageFromCamera();
                if (imageList == null)
                  imageList = new List();
                if (_imagePath != null) {
                  setState(() {
                    imageList.add(_imagePath);


                  });
                }
                print(
                    'imageList size:: ${imageList.length}');
                uploadImageToFirebase(context);


            },
            child: Padding(
              padding: const EdgeInsets.only(left:12.0,top: 10,right: 20),
              child: Image(image: AssetImage("assets/images/campic.png")),
            ),
          ),
          Positioned(
            top: 20,right: 100,
            child: Column(
             // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:80.0),
                  child: Icon(Icons.camera_alt,color: Config_File.WHITE,size: 35,),
                ),
                Text("Tap to Capture",
                style: TextStyle(
                  color: Config_File.WHITE,
                  fontSize: 16
                ),
                )
              ],
            ),
          )

         ],
       ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 0.2,
            color: Config_File.GREY,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:20.0,left: 20),
          child: Text(
            "Recent Capture Image",
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 14,
              color: Config_File.PRIMARY_COLOR,
              fontWeight: FontWeight.w500,
              height: 1.1363636363636365,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Row(
          children: <Widget>[

              Expanded(
              child: new Container(
                margin: EdgeInsets.symmetric(
                    vertical: 15.0),
                height: 95.0,
                child: imageList != null
                    ? GridView.count(
                  crossAxisCount: 3,
                  //physics: NeverScrollableScrollPhysics(),

                  shrinkWrap: true,
                  children: List.generate(imageList.length, (index) {
                   return getRecord(index, imageList[index]);
                  }),

                )
                    : Container(),
              ),


            )
          ],

        ),
       /* Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 0.2,
            color: Config_File.GREY,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:20.0,left: 20),
          child: Text(
            "Albums",
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 14,
              color: Config_File.PRIMARY_COLOR,
              fontWeight: FontWeight.w500,
              height: 1.1363636363636365,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Image(
                image: new AssetImage(
                    'assets/images/captureImage.png'),
                width: 95.0,
                height: 95.0,
                //fit: BoxFit.cover,
              ),
            ),


          ],
        ),
        InkWell(
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
    );
  }
}
