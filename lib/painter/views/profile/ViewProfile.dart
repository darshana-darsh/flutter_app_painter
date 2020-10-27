import 'package:flutter_app/painter/views/profile/EditProfile.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';
import 'package:flutter_share/flutter_share.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override

  Future<void> share() async {
    await FlutterShare.share(
        title: UserPreference().getUserNAme().toString(),
        text: UserPreference().getEmail().toString(),
        linkUrl: UserPreference().getPhone(),
        chooserTitle: 'Profile'
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config_File.PRIMARY_COLOR,
        title: Text("Profile"),
        leading: InkWell(onTap:(){
            Navigator.pop(context);
        },child: Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        children: [
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60,),
              Center(
                child: InkWell(
                  onTap: (){

                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CircleAvatar(
                      // backgroundColor: Colors.black12,
                      radius: 50,
                      //  borderRadius: BorderRadius.circular(50),
                      child: UserPreference().getImage()==null?Image.asset("assets/images/user.png",):
                      Image.network(UserPreference().getImage()),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Change Photo",style: TextStyle(
                      color: Config_File.PRIMARY_COLOR,
                      fontSize: 14,fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left:50.0,bottom:2),
                child: Text("Full Name",style: TextStyle(
                    color: Config_File.GREY_LIGHT,
                    fontSize: 14,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:50),
                child: Text(UserPreference().getUserNAme().toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 14,fontWeight: FontWeight.bold
                ),),
              ),

              Padding(
                padding: const EdgeInsets.only(left:50.0,bottom:2,top:15),
                child: Text("Email",style: TextStyle(
                    color: Config_File.GREY_LIGHT,
                    fontSize: 14,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:50),
                child: Text(UserPreference().getEmail().toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 14,fontWeight: FontWeight.bold
                ),),
              ),

              Padding(
                padding: const EdgeInsets.only(left:50.0,bottom:2,top:15),
                child: Text("Phone Number",style: TextStyle(
                    color: Config_File.GREY_LIGHT,
                    fontSize: 14,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:50),
                child: Text(UserPreference().getPhone()==null?"":UserPreference().getPhone().toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 14,fontWeight: FontWeight.bold
                ),),
              ),

              Padding(
                padding: const EdgeInsets.only(left:50.0,bottom:2,top:15),
                child: Text("Address",style: TextStyle(
                    color: Config_File.GREY_LIGHT,
                    fontSize: 14,fontWeight: FontWeight.normal
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:50),
                child: Text(UserPreference().getAddress()==null?"":UserPreference().getAddress().toString(),style: TextStyle(
                    color: Config_File.GREY_2,
                    fontSize: 14,fontWeight: FontWeight.bold
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
                         padding: const EdgeInsets.only(left:50.0,bottom:2,top:15),
                         child: Text("Experince(Years)",style: TextStyle(
                             color: Config_File.GREY_LIGHT,
                             fontSize: 14,fontWeight: FontWeight.normal
                         ),),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left:50),
                         child: Text(UserPreference().getExperince()==null?"":UserPreference().getExperince().toString(),style: TextStyle(
                             color: Config_File.GREY_2,
                             fontSize: 14,fontWeight: FontWeight.bold
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
                          padding: const EdgeInsets.only(left:20.0,bottom:2,top:15),
                          child: Text("Rate per sq foot",style: TextStyle(
                              color: Config_File.GREY_LIGHT,
                              fontSize: 14,fontWeight: FontWeight.normal
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20),
                          child: Text(UserPreference().getRate()==null?"":UserPreference().getRate().toString(),style: TextStyle(
                              color: Config_File.GREY_2,
                              fontSize: 14,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));

                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0, top: 50,right: 50),
                  child: Container(
                    height: 40,
                    //  width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0)),
                        border: Border.all(
                            color: Config_File.PRIMARY_COLOR)),
                    child: Center(
                        child: Text("Edit Profile",
                            style:
                            TextStyle(color: Config_File.PRIMARY_COLOR))),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  //  createRecord();
                  share();
                },
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 50.0, right: 50, top: 30),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Config_File.PRIMARY_COLOR,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Center(
                        child: Text(
                          "Share Profile",
                          style: TextStyle(color: Config_File.WHITE),
                        )),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
