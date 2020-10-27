import 'package:flutter_app/painter/views/moreView/AddTexture.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/painter/views/customerView/CustomerDetailPage.dart';
import 'package:flutter_app/painter/views/customerView/CustomerList.dart';

class Customer_Page extends StatefulWidget {
  @override
  _Customer_PageState createState() => _Customer_PageState();
}

class _Customer_PageState extends State<Customer_Page> {

  int choice;
  bool addCustomer=false;
  bool customerList=true;


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
                                   if(customerList){


                                   }
                                   else{
                                     customerList=true;
                                     addCustomer=false;
                                   }
                                 });
                               },
                               child: Padding(
                                 padding: const EdgeInsets.only(left:0.0,right: 0,top: 100),
                                 child: Container(
                                   width: 40,
                                   decoration: BoxDecoration(
                                     color: customerList?Config_File.PRIMARY_COLOR:Config_File.WHITE,
                                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                     //  border: Border.all(color: Config_File.PRIMARY_COLOR,)
                                   ),
                                   child: Center(child: RotatedBox(
                                       quarterTurns: -1,
                                       child: Padding(
                                         padding: const EdgeInsets.only(left:8.0,right:10),
                                         child: Text("Customer List",style: TextStyle(color: customerList?Config_File.WHITE:Config_File.PRIMARY_COLOR),),
                                       ))),
                                 ),
                               ),
                             ),
                             InkWell(
                               onTap: (){
                                 setState(() {
                                   if(addCustomer){
                                   }
                                   else{
                                     addCustomer=true;
                                     customerList=false;
                                   }
                                 });
                               },
                               child: Padding(
                                 padding: const EdgeInsets.only(left:0.0,right: 0,top: 20),
                                 child: Container(
                                   width: 40,
                                   decoration: BoxDecoration(
                                     color: addCustomer?Config_File.PRIMARY_COLOR:Config_File.WHITE,
                                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                   ),
                                   child: Center(child: RotatedBox(
                                       quarterTurns: -1,
                                       child: Padding(
                                         padding: const EdgeInsets.only(left:8.0,right:10),
                                         child: Text("Add Customer",style: TextStyle(color: addCustomer?Config_File.WHITE:Config_File.PRIMARY_COLOR),),
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
                   addCustomer?   Expanded(
                     flex: 1,
                     child: CustomerDetailPage(),
                   ):
                   customerList?Expanded(
                       flex: 1,
                       child: UserHome()):

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
