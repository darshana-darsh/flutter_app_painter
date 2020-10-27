import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'NotificationView.dart';

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  final db = Firestore.instance;

  CollectionReference contactsReference;
  DocumentReference profileReference;
  DocumentSnapshot profileSnapshot;

  @override
  void initState() {
    super.initState();
    print(UserPreference().getUserId());

    contactsReference = db
        .collection("painter")
        .document(UserPreference().getUserId())
        .collection('notificationShare');



  }


  generateCustomerList() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Notification List",
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
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: contactsReference.snapshots(),
              builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text("No Contacts");
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot doc= snapshot.data.documents[index];
                      return Container(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => NotificationView(
                                doc)));
                          },
                          child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(left:11.0,right: 11),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: Text(doc['customerName'].toString(),style: TextStyle(
                                              color: Config_File.PRIMARY_COLOR,fontSize: 20
                                          ),),
                                        ),
                                        Expanded(
                                          flex:0,
                                          child: Text(doc['option'].toString()=='1'?"Reminder":
                                            doc['option'].toString()=='2'?'Custom Offer':'Follow up',style: TextStyle(
                                              color: Config_File.GREYDARK,fontSize: 14
                                          ),),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Text(doc['title'].toString(),style: TextStyle(
                                          color: Config_File.GREYDARK,fontSize: 14
                                      ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0,bottom: 10,right: 10),
                                      child: Text(doc['message'].toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(

                                          color: Config_File.GREY_LIGHT,fontSize: 12
                                      ),),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return generateCustomerList();
  }
}
