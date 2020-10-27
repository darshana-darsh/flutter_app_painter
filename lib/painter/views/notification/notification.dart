import 'package:flutter/material.dart';
import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/painter/views/notification/Compose_Notification.dart';
import 'package:flutter_app/painter/views/notification/NotificationList.dart';

class Notification_Page extends StatefulWidget {
  @override
  _Notification_PageState createState() => _Notification_PageState();
}

class _Notification_PageState extends State<Notification_Page> {

  int choice;
  bool notificationList=true;

  bool composeNotification=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config_File.PRIMARY_COLOR,
        title: Text("Notification"),
        leading: InkWell(onTap:(){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back_ios)),
      ),
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
                                    if(notificationList){
                                    }
                                    else{
                                      notificationList=true;
                                      composeNotification=false;
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left:0.0,right: 0,top: 100),
                                  child: Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: notificationList?Config_File.PRIMARY_COLOR:Config_File.WHITE,
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    child: Center(child: RotatedBox(
                                        quarterTurns: -1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:10),
                                          child: Text("Notification List",style: TextStyle(color: notificationList?Config_File.WHITE:Config_File.PRIMARY_COLOR),),
                                        ))),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    if(composeNotification){


                                    }
                                    else{
                                      composeNotification=true;
                                      notificationList=false;

                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left:0.0,right: 0,top: 20),
                                  child: Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: composeNotification?Config_File.PRIMARY_COLOR:Config_File.WHITE,
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    child: Center(child: RotatedBox(
                                        quarterTurns: -1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:10),
                                          child: Text("Compose Notification",style: TextStyle(color:composeNotification?Config_File.WHITE:Config_File.PRIMARY_COLOR),),
                                        ))),
                                  ),
                                ),
                              ),

                            ])),
                    notificationList?   Expanded(
                      flex: 1,
                      child: NotificationList(),
                    ):

                    composeNotification?Expanded(
                        flex: 1,
                        child: ComposeNotification()):
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
