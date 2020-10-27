import 'package:flutter/material.dart';

import 'package:flutter_app/config/Config_file.dart';
import 'AddTexture.dart';
import 'Albumn.dart';

class More_page extends StatefulWidget {
  @override
  _More_pageState createState() => _More_pageState();
}

class _More_pageState extends State<More_page> {

  int choice;
  bool albumn=true;

  bool addtexture=false;


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
                                    if(albumn){
                                    }
                                    else{
                                      albumn=true;
                                      addtexture=false;
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left:0.0,right: 0,top: 100),
                                  child: Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: albumn?Config_File.PRIMARY_COLOR:Config_File.WHITE,
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    child: Center(child: RotatedBox(
                                        quarterTurns: -1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:10),
                                          child: Text("Album",style: TextStyle(color: albumn?Config_File.WHITE:Config_File.PRIMARY_COLOR),),
                                        ))),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    if(addtexture){


                                    }
                                    else{
                                      addtexture=true;
                                      albumn=false;
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left:0.0,right: 0,top: 20),
                                  child: Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: addtexture?Config_File.PRIMARY_COLOR:Config_File.WHITE,
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      //  border: Border.all(color: Config_File.PRIMARY_COLOR,)
                                    ),
                                    child: Center(child: RotatedBox(
                                        quarterTurns: -1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:10),
                                          child: Text("Add Texture",style: TextStyle(color: addtexture?Config_File.WHITE:Config_File.PRIMARY_COLOR),),
                                        ))),
                                  ),
                                ),
                              ),

                              /* InkWell(
                               onTap: (){
                                 setState(() {
                                   if(addtexture){


                                   }
                                   else{
                                     addtexture=true;
                                     addCustomer=false;
                                     customerList=false;
                                   }
                                 });
                               },
                               child: Padding(
                                 padding: const EdgeInsets.only(left:0.0,right: 0,top: 20),
                                 child: Container(
                                   width: 40,
                                   decoration: BoxDecoration(
                                     color: addtexture?Config_File.PRIMARY_COLOR:Config_File.WHITE,
                                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                   ),
                                   child: Center(child: RotatedBox(
                                       quarterTurns: -1,
                                       child: Padding(
                                         padding: const EdgeInsets.only(left:8.0,right:10),
                                         child: Text("Add Texture",style: TextStyle(color:addtexture?Config_File.WHITE:Config_File.PRIMARY_COLOR),),
                                       ))),
                                 ),
                               ),
                             ),*/
                            ])),
                    albumn?   Expanded(
                      flex: 1,
                      child: Albumn(),
                    ):
                    addtexture?Expanded(
                        flex: 1,
                        child: Add_Texture()):
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
