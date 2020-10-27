import 'package:flutter_app/config/Config_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'EditCustomer.dart';

class CustomerView extends StatefulWidget {
  DocumentSnapshot doc;
  CustomerView(this.doc);
  @override
  _CustomerViewState createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Config_File.PRIMARY_COLOR,
        title: Text("Customer"),
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
              /*Center(
                child: InkWell(
                  onTap: (){

                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CircleAvatar(
                      // backgroundColor: Colors.black12,
                      radius: 50,
                      //  borderRadius: BorderRadius.circular(50),
                      child: Image.asset("assets/images/user.png",),
                    ),
                  ),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.only(left:30.0),
                child: Text("View Customer Detail",style: TextStyle(
                    color: Config_File.PRIMARY_COLOR,
                    fontSize: 22,fontWeight: FontWeight.normal
                ),),
              ),
             SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left:30.0,bottom:8),
                child: Text("Full Name",style: TextStyle(
                    color: Config_File.PRIMARY_COLOR,
                    fontSize: 18,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30),
                child: Text(widget.doc["fullname"].toString(),style: TextStyle(
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
                child: Text(widget.doc["email"].toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 16,fontWeight: FontWeight.bold
                ),),
              ),

              Padding(
                padding: const EdgeInsets.only(left:30.0,bottom:8,top:20),
                child: Text("Phone Number",style: TextStyle(
                    color: Config_File.PRIMARY_COLOR,
                    fontSize: 18,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30),
                child: Text(widget.doc['contact'].toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 16,fontWeight: FontWeight.bold
                ),),
              ),

              Padding(
                padding: const EdgeInsets.only(left:30.0,bottom:8,top:20),
                child: Text("Address",style: TextStyle(
                    color: Config_File.PRIMARY_COLOR,
                    fontSize: 18,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30),
                child: Text(widget.doc["address"].toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 16,fontWeight: FontWeight.bold
                ),),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:30,bottom:8,top:20),
                          child: Text("City",style: TextStyle(
                              color: Config_File.PRIMARY_COLOR,
                              fontSize: 18,fontWeight: FontWeight.normal
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:30),
                          child: Text(widget.doc["city"].toString(),style: TextStyle(
                              color: Config_File.GREY_2,
                              fontSize: 16,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:20.0,bottom:8,top:20),
                          child: Text("State",style: TextStyle(
                              color: Config_File.PRIMARY_COLOR,
                              fontSize: 18,fontWeight: FontWeight.normal
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20),
                          child: Text(widget.doc['state'].toString(),style: TextStyle(
                              color: Config_File.GREY_2,
                              fontSize: 16,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left:30.0,bottom:8,top:20),
                child: Text("Pin Code",style: TextStyle(
                    color: Config_File.PRIMARY_COLOR,
                    fontSize: 18,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30),
                child: Text(widget.doc['pincode'].toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 16,fontWeight: FontWeight.bold
                ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:30,bottom:8,top:20),
                          child: Text("Type of Customer",style: TextStyle(
                              color: Config_File.PRIMARY_COLOR,
                              fontSize: 18,fontWeight: FontWeight.normal
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:30),
                          child: Text(widget.doc["customerType"].toString()=="1"?"Residential":
                            widget.doc['customerType'].toString()=="2"?"Commercial":
                            "Society",style: TextStyle(
                              color: Config_File.GREY_2,
                              fontSize: 16,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:20.0,bottom:8,top:20),
                          child: Text("Customer Status",style: TextStyle(
                              color: Config_File.PRIMARY_COLOR,
                              fontSize: 18,fontWeight: FontWeight.normal
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20),
                          child: Text(widget.doc['customerStatus'].toString()=="1"?"Approved Lead":
                            widget.doc['customerStatus'].toString()=="2"?"Lost Lead":
                            "Follow Up",style: TextStyle(
                              color: Config_File.GREY_2,
                              fontSize: 16,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {
                        //  createRecord("2");
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => EditCustomer(
                              widget.doc)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 20),
                          child: Container(
                            height: 40,
                            //  width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                    color: Config_File.PRIMARY_COLOR)),
                            child: Center(
                                child: Text("Edit Info",
                                    style:
                                    TextStyle(color: Config_File.PRIMARY_COLOR))),
                          ),
                        ),
                      )),

                  Expanded(
                      child: InkWell(
                        onTap: () {
                         // createRecord("1");
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 40, top: 20),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Config_File.PRIMARY_COLOR,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Center(
                                child: Text(
                                  "Continue",
                                  style: TextStyle(color: Config_File.WHITE),
                                )),
                          ),
                        ),
                      )),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
