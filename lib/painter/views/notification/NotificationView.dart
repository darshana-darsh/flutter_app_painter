import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/Config_file.dart';


class NotificationView extends StatefulWidget {
  DocumentSnapshot doc;
  NotificationView(this.doc);
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left:30.0),
                child: Text("View Notification Detail",style: TextStyle(
                    color: Config_File.PRIMARY_COLOR,
                    fontSize: 22,fontWeight: FontWeight.normal
                ),),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left:30.0,bottom:8),
                child: Text("Customer Name",style: TextStyle(
                    color: Config_File.PRIMARY_COLOR,
                    fontSize: 18,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30),
                child: Text(widget.doc["customerName"].toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 16,fontWeight: FontWeight.bold
                ),),
              ),

              Padding(
                padding: const EdgeInsets.only(left:30.0,bottom:8,top:20),
                child: Text("Email",style: TextStyle(
                    color: Config_File.PRIMARY_COLOR,
                    fontSize: 18,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30),
                child: Text(widget.doc["emailAddress"].toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 16,fontWeight: FontWeight.bold
                ),),
              ),

              Padding(
                padding: const EdgeInsets.only(left:30.0,bottom:8,top:20),
                child: Text("Title",style: TextStyle(
                    color: Config_File.PRIMARY_COLOR,
                    fontSize: 18,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30),
                child: Text(widget.doc['title'].toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 16,fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30.0,bottom:8,top:20),
                child: Text("Message",style: TextStyle(
                    color: Config_File.PRIMARY_COLOR,
                    fontSize: 18,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30),
                child: Text(widget.doc['message'].toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 16,fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30.0,bottom:8,top:20),
                child: Text("Type",style: TextStyle(
                    color: Config_File.PRIMARY_COLOR,
                    fontSize: 18,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30),
                child: Text(widget.doc['option'].toString()=='1'?"Reminder":
                widget.doc['option'].toString()=='2'?'Custom Offer':'Follow up',style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 16,fontWeight: FontWeight.bold
                ),),
              ),
            ],
          )
        ],
      ),
    );
  }
}
