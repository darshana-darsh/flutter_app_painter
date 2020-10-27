import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_share/flutter_share.dart';

class ComposeNotification extends StatefulWidget {
  @override
  _ComposeNotificationState createState() => _ComposeNotificationState();
}

class _ComposeNotificationState extends State<ComposeNotification> {
  String id;
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController customerName = new TextEditingController();
  TextEditingController emailAddress = new TextEditingController();
  TextEditingController message = new TextEditingController();
  TextEditingController title = new TextEditingController();

  int _radioValueCustomer;
  int customerType;
  List<DocumentSnapshot> nameList=[];
  String fullname,email;

  final db = Firestore.instance;
  Future<QuerySnapshot> snapshot;
  setRadioButton(int value) {
    setState(() {
      _radioValueCustomer = value;
      customerType = value;
    });
  }

  void createRecord() async {
    final Email email = Email(
      body: message.text  ,
      subject: title.text,
      recipients: [emailAddress.text],
      //   cc: ['cc@example.com'],
      //  bcc: ['bcc@example.com'],
      //    attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
    print(email.subject);

    await db.collection("painter").document(id).collection("notificationShare").document(id).setData({
      "user_id": id,
      "customerName": fullname,
      "emailAddress": emailAddress.text,
      "message": message.text,
      "title": title.text,
      "option" : _radioValueCustomer

    });
    CircularProgressIndicator();
    await FlutterEmailSender.send(email);
  //  await share();


  }

  void clearRecord() {
    Config_File().hideKeyboard(context);

    setState(() {
     // fullname ='';
      emailAddress.clear();
      message.clear();
      title.clear();
     _radioValueCustomer = 0;

    });
  }
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      id = UserPreference().getUserId();
    });
    snapshot = db
        .collection("painter")
        .document(UserPreference().getUserId())
        .collection('customerList').getDocuments();

    snapshot.then((value) {
      setState(() {
        nameList=value.documents;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Compose Message",
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
            padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: Text(
              "Customer Name",
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 14,
                color: Config_File.GREY,
                fontWeight: FontWeight.w300,
                height: 1.1363636363636365,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 20),
            child:DropdownButtonFormField(
              //  controller: customerName,
              //  keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (value) {
                setState(() {
                  fullname=value;
                });
              },
              items:  nameList.map((e){

                return  DropdownMenuItem(
                  child: Text(e['fullname'].toString()),
                  value: e['fullname'].toString(),
                  onTap: (){
                    setState(() {
                    emailAddress.text=e['email'].toString();
                    });
                  },

                );
              }).toList(),

              value: fullname,
              onSaved: (value){
                setState(() {
                  fullname=value;
                });
              },
            )
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
            child: Text(
              "Email Address",
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 14,
                color: Config_File.GREY,
                fontWeight: FontWeight.w300,
                height: 1.1363636363636365,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 20),
            child: TextFormField(
              controller: emailAddress,
              enabled: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding:
            const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
            child: Text(
              "Title",
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 14,
                color: Config_File.GREY,
                fontWeight: FontWeight.w300,
                height: 1.1363636363636365,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 20),
            child: TextFormField(
              controller: title,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.only(bottom: 10, left: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
            child: Text(
              "Message",
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 14,
                color: Config_File.GREY,
                fontWeight: FontWeight.w300,
                height: 1.1363636363636365,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 20),
            child: TextFormField(
              controller: message,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Row(
            //alignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Radio(
                  value: 1,
                  groupValue: _radioValueCustomer,
                  onChanged: (val) {
                    print("value----------");
                    setRadioButton(val);
                  },
                  activeColor: Config_File.GREY,
                ),
              ),
              Text(
                "Reminder",
              ),
              Radio(
                value: 2,
                groupValue: _radioValueCustomer,
                onChanged: (value) {
                  print(value);
                  setRadioButton(value);
                },
                activeColor: Config_File.GREY,
              ),
              Text(
                "Custom Offer",
              ),
              Radio(
                value: 3,
                groupValue: _radioValueCustomer,
                onChanged: (value) {
                  print(value);
                  setRadioButton(value);
                },
                activeColor: Config_File.GREY,
              ),
              Text(
                "Follow Up",
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                    onTap: () {
                      clearRecord();
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
                            child: Text("Clear",
                                style:
                                TextStyle(color: Config_File.PRIMARY_COLOR))),
                      ),
                    ),
                  )),
              Expanded(
                  child: InkWell(
                    onTap: () {
                      createRecord();
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
                              "Share",
                              style: TextStyle(color: Config_File.WHITE),
                            )),
                      ),
                    ),
                  )),
            ],
          ),

          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
