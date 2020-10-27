import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/painter/views/quatationView/EditQuatation.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Quatation_Histroy extends StatefulWidget {
  @override
  _Quatation_HistroyState createState() => _Quatation_HistroyState();
}

class _Quatation_HistroyState extends State<Quatation_Histroy> {
  final db = Firestore.instance;

  CollectionReference contactsReference;
  DocumentReference profileReference;
  DocumentSnapshot profileSnapshot;
  static const List <String> choice = <String>[
    "Edit",
    "Delete"
  ];

  @override
  void initState() {
    super.initState();
    print(UserPreference().getUserId());

    contactsReference = db
        .collection("painter")
        .document(UserPreference().getUserId())
        .collection('customerList');

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
              "Quatation List",
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
                      return doc["toatlCost"].toString()!="null"?Container(
                        child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex:2,
                                        child: Text(doc['type'].toString()=="1"?"Saved":"Save as Draft"
                                        ,style: TextStyle(
                                          color:doc['type'].toString()=="1"?Config_File.GREEN:
                                        Config_File.GREYDARK,fontSize: 10,
                                        ),),
                                      ),
                                      Expanded(
                                        flex: 0,
                                        child:
                                        doc['type'].toString()=="1"?Container(): PopupMenuButton<dynamic>(
                                          onSelected:(action){

                                            print("onWorking");

                                             if(action=="Edit"){
                                              print("Edit");
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => EditQuatation(
                                                  doc)));
                                            }
                                            else if(action=="Delete")
                                            {
                                              print("Delete");
                                              setState(() {
                                                contactsReference.document(doc['customerlist'].toString()).delete();
                                              });

                                            }
                                            else{
                                              print("default");
                                            }
                                          },
                                          icon: Icon(Icons.more_vert,color: Config_File.GREY_LIGHT,),
                                          itemBuilder: (BuildContext context){
                                            return choice.map((String choice) {
                                              return PopupMenuItem<String>(
                                                value: choice,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        choice=="View"?Icon(Icons.remove_red_eye,color: Config_File.GREYDARK,):
                                                        choice=="Edit"?Icon(Icons.edit,color: Config_File.GREYDARK,):
                                                        Icon(Icons.delete,color: Config_File.GREYDARK,),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:5.0),
                                                          child: Text(choice,style: TextStyle(color: Config_File.GREYDARK),),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Container(
                                                      height: 0.6,
                                                      width: double.infinity,
                                                      color: Config_File.GREY_LIGHT,
                                                    )
                                                  ],
                                                ),
                                              );

                                            }).toList();

                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(doc['fullname'].toString(),style: TextStyle(
                                      color: Config_File.PRIMARY_COLOR,fontSize: 20
                                  ),),
                                  Text(doc['customerType'].toString()=="1"?"Residential":
                                  doc["customerType"].toString()=="2"?"Commercial":"Society",style: TextStyle(
                                      color: Config_File.GREY_LIGHT,fontSize: 14
                                  ),),
                                  Padding(
                                    padding: const EdgeInsets.only(top:8.0),
                                    child: Text("Amount Billed:",style: TextStyle(
                                        color: Config_File.GREY_LIGHT,fontSize: 10
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:5.0,bottom: 10),
                                    child: Text("₹"+doc["toatlCost"].toString(),style: TextStyle(
                                        color: Config_File.PRIMARY_COLOR,fontSize: 16
                                    ),),
                                  ),
                                ],
                              ),
                            )),
                      ):Container();
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
