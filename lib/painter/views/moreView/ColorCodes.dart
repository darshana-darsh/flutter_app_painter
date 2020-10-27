import 'package:flutter/material.dart';
import 'package:flutter_app/config/Config_file.dart';

class ColorCodes extends StatefulWidget {
  @override
  _ColorCodesState createState() => _ColorCodesState();
}

class _ColorCodesState extends State<ColorCodes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:20.0,left: 20),
          child: Text(
            "Primary Color".toUpperCase(),
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
          children: [
            Image.asset("assets/images/RedColor.png",height: 80,width: 80,),
            Image.asset("assets/images/GreenColor.png",height: 80,width: 80,),
            Image.asset("assets/images/BlueColor.png",height: 80,width: 80,),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top:20.0,left: 20),
          child: Text(
            "Color Shade".toUpperCase(),
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
          children: [
            Image.asset("assets/images/Shade.png",height: 120,width: 75,),
            Image.asset("assets/images/Shade.png",height: 120,width: 75,),
            Image.asset("assets/images/Shade.png",height: 120,width: 75,),
            Image.asset("assets/images/Shade.png",height: 120,width: 75,),
            Image.asset("assets/images/Shade.png",height: 120,width: 71,),
          ],
        ),
        InkWell(
          onTap: () {

            setState(() {
             // colorCodeSelect=true;
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
                    "Add Quatation",
                    style: TextStyle(color: Config_File.PRIMARY_COLOR),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
