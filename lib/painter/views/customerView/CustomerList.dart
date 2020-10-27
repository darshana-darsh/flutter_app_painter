import 'package:flutter_app/painter/views/customerView/CustomerView.dart';
import 'package:flutter_app/painter/views/customerView/EditCustomer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  final db = Firestore.instance;
  TextEditingController searchController = new TextEditingController();
  CollectionReference contactsReference;
  DocumentReference profileReference;
  DocumentSnapshot profileSnapshot;
  static const List <String> choice = <String>[
     "View",
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
            padding: const EdgeInsets.only(top:20.0,left: 10,bottom: 20),
            child: Text(
              "Customer List",
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
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10,bottom: 10),
            child: TextFormField(
              controller: searchController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Config_File.Grey_Light_shade,
                filled: true,
                hintText: "Search",
                  hintStyle: TextStyle(color: Config_File.SEARCHBARCOLOR),
                  prefixIcon: Icon(Icons.search,color: Config_File.SEARCHBARCOLOR,),
                  contentPadding: EdgeInsets.only(bottom: 10, left: 10),

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  focusColor: Config_File.SEARCHBARCOLOR),

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

                   return Padding

                     (
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       child: Card(
                           child: Padding(
                             padding: const EdgeInsets.only(left:11.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Row(
                                   children: [
                                     Expanded(
                                       flex:2,
                                       child: Text(doc['customerStatus'].toString()=="1"?"Approved Lead":
                                         doc["customerStatus"].toString()=="2"?"Lost Lead":"Follow Up",style: TextStyle(
                                           color:doc['customerStatus'].toString()=="1"?Config_File.GREEN:
                                           doc["customerStatus"].toString()=="2"?Config_File.GREYDARK:Config_File.ORANGE,fontSize: 10,
                                       ),),
                                     ),
                                     Expanded(
                                       flex: 0,
                                       child:PopupMenuButton<dynamic>(
                                         onSelected:(action){

                                           print("onWorking");
                                           if(action=="View"){
                                             print("View");
                                             Navigator.push(
                                                 context, MaterialPageRoute(builder: (context) => CustomerView(
                                                 doc)));
                                           }
                                           else if(action=="Edit"){
                                             print("Edit");
                                             Navigator.push(
                                                 context, MaterialPageRoute(builder: (context) => EditCustomer(
                                                 doc)));
                                           }
                                           else if(action=="Delete")
                                           {
                                             print("Delete");
                                             setState(() {
                                               contactsReference.document(doc['customerId'].toString()).delete();
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
                                 Row(
                                   children: [
                                     Expanded(
                                       flex: 0,
                                       child: Padding(
                                         padding: const EdgeInsets.only(top:8.0),
                                         child: Text("Start Date: ",style: TextStyle(
                                             color: Config_File.GREY_LIGHT,fontSize: 12
                                         ),),
                                       ),
                                     ),
                                     Expanded(
                                       child: Padding(
                                         padding: const EdgeInsets.only(top:8.0),
                                         child: Text(doc['startDate'].toString(),style: TextStyle(
                                             color: Config_File.GREYDARK,fontSize: 12
                                         ),),
                                       ),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   children: [
                                     Expanded(
                                       flex: 0,
                                       child: Padding(
                                         padding: const EdgeInsets.only(top:5.0,bottom: 10),
                                         child: Text("End Date: ",style: TextStyle(
                                             color: Config_File.GREY_LIGHT,fontSize: 12
                                         ),),
                                       ),
                                     ),
                                     Expanded(

                                       child: Padding(
                                         padding: const EdgeInsets.only(top:5.0,bottom: 10),
                                         child: Text(doc['endDate'].toString(),style: TextStyle(
                                             color: Config_File.GREYDARK,fontSize: 12
                                         ),),
                                       ),
                                     ),
                                   ],
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

