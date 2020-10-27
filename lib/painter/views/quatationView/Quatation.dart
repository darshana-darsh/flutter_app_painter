import 'package:flutter/material.dart';
import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/painter/views/quatationView/AddQuatation.dart';
import 'package:flutter_app/painter/views/quatationView/quatationHistroy.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';

class Quatation_Page extends StatefulWidget {
  @override
  _Quatation_PageState createState() => _Quatation_PageState();
}


class _Quatation_PageState extends State<Quatation_Page> {

  int choice;
  bool addQuatation=false;

  bool quatationHistroy=true;


  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            //  height: 20,
            color: Config_File.PRIMARY_COLOR,
            child: Container(
                decoration: BoxDecoration(
                  color: Config_File.WHITE,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 0,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    if(quatationHistroy){


                                    }
                                    else{
                                      quatationHistroy=true;
                                      addQuatation=false;

                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left:0.0,right: 0,top: 100),
                                  child: Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: quatationHistroy?Config_File.PRIMARY_COLOR:Config_File.WHITE,
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    child: Center(child: RotatedBox(
                                        quarterTurns: -1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:10),
                                          child: Text("Quatation Histroy",style: TextStyle(color:quatationHistroy?Config_File.WHITE:Config_File.PRIMARY_COLOR),),
                                        ))),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    if(addQuatation){
                                    }
                                    else{
                                      addQuatation=true;

                                      quatationHistroy=false;
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left:0.0,right: 0,top: 20),
                                  child: Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: addQuatation?Config_File.PRIMARY_COLOR:Config_File.WHITE,
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    child: Center(child: RotatedBox(
                                        quarterTurns: -1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:10),
                                          child: Text("Add Quatation",style: TextStyle(color: addQuatation?Config_File.WHITE:Config_File.PRIMARY_COLOR),),
                                        ))),
                                  ),
                                ),
                              ),


                            ])),
                    addQuatation?   Expanded(
                      flex: 1,
                      child: Add_Quatation(),
                    ):

                    quatationHistroy?Expanded(
                        flex: 1,
                        child: Quatation_Histroy()):
                    Container(),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }

}
