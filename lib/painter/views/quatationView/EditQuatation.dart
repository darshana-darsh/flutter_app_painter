import 'dart:ui';

import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/painter/views/quatationView/Quatation.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:intl/intl.dart';

class EditQuatation extends StatefulWidget {
  DocumentSnapshot doc;
  EditQuatation(this.doc);
  @override
  _EditQuatationState createState() => _EditQuatationState();
}

class _EditQuatationState extends State<EditQuatation> {
  @override
  String id;
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController customerName = new TextEditingController();
  TextEditingController customerType = new TextEditingController();
  TextEditingController paintName = new TextEditingController();
  TextEditingController rate = new TextEditingController();
  TextEditingController requiredPaint = new TextEditingController();
  TextEditingController startDate = new TextEditingController();
  TextEditingController totalArea = new TextEditingController();
  TextEditingController discount = new TextEditingController();
  TextEditingController cost = new TextEditingController();
  TextEditingController tax = new TextEditingController();
  TextEditingController toatlCost = new TextEditingController();
  TextEditingController endDate = new TextEditingController();
  DateTime dateofbirth;
  final databaseReference = Firestore.instance;
  CollectionReference chatReference;
  int randomNumber;
  String _myActivity;

  ColorSwatch _tempMainColor;
  Color _tempShadeColor;
  ColorSwatch _mainColor = Colors.blue;
  Color _shadeColor = Colors.deepOrange;
  DocumentSnapshot doc;
  List<String> paintList = ["Asian Paint", "Burger Paint","Shalimar Paint","Nerolac Paint", "Nippon Paint"];

  void createRecord(type) async {

    await databaseReference.collection("painter").document(id).collection("customerList").document(randomNumber.toString()).updateData({
      "user_id": id,
      "quatatonId":randomNumber,
      "customerName": customerName.text,
      "customerType": customerType.text,
      "paintName": _myActivity,
      'color': _tempShadeColor.toString(),
      "rate": rate.text,
      "requiredPaint": requiredPaint.text,
      "startDate": startDate.text,
      "endDate": endDate.text,
      "totalArea": totalArea.text,
      "discount": discount.text,
      "cost": cost.text,
      "tax": tax.text,
      "toatlCost": toatlCost.text,
      "type": type,

    });
   CircularProgressIndicator();
    await clearRecord();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Quatation_Page()));


  }

  void clearRecord() {
    Config_File().hideKeyboard(context);

    setState(() {

      paintName.clear();
      rate.clear();
      requiredPaint.clear();
      startDate.clear();
      totalArea.clear();
      discount.clear();
      cost.clear();
      tax.clear();
      toatlCost.clear();

    });
  }
  final format = DateFormat("yyyy-MM-dd");
  @override
  void initState() {
    super.initState();
    setState(() {
      id = UserPreference().getUserId();
    });

    getData();
  }
  getData(){
    print(widget.doc.data);
    setState(() {
      customerName.text=widget.doc["fullname"].toString();
      customerType.text=widget.doc["customerType"].toString()=='1'?"Residential":
                        widget.doc["customerType"].toString()=='2'?"Commercial":"Society";
      rate.text=widget.doc["rate"].toString();
      _myActivity=widget.doc["paintName"].toString();
      requiredPaint.text=widget.doc["requiredPaint"].toString();
      startDate.text=widget.doc["startDate"].toString();
      endDate.text=widget.doc["endDate"].toString();
      totalArea.text=widget.doc["totalArea"].toString();
      discount.text=widget.doc["discount"].toString();
      cost.text=widget.doc["cost"].toString();
      tax.text=widget.doc["tax"].toString();
      toatlCost.text=widget.doc["toatlCost"].toString();
      //type=widget.doc["type"];
      randomNumber=widget.doc["customerId"];
    //  _tempShadeColor=widget.doc['color'];
      print(widget.doc['color']);

    });


  }

  Future<Null> datePicker(BuildContext context,String type) async {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        //   pickerHeight: 50.0,
        showTitle: true,
        /* title: Container(
            width: double.infinity,
            height: 40.0,
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Date',style: AppTextStyle.getDynamicFontStyle(ColorInfo.WHITE, 16,
                  FontType.Light, StringFontFamiliy.bold),),
            ),
            decoration: BoxDecoration(color: Color(0xFF454547)),
          ),*/
        backgroundColor: Config_File.PRIMARY_COLOR,
        itemTextStyle: TextStyle(color: Colors.white,fontSize: 14),
        cancel: Text("Cancel",style: TextStyle(color: Config_File.WHITE),),
        confirm: Text("Save",style: TextStyle(color: Config_File.WHITE)),
        // pickerHeight: 300.0,
        // titleHeight: 24.0,
        itemHeight: 50.0,
      ),
      minDateTime: new DateTime((new DateTime(1960).year)),
      pickerMode: DateTimePickerMode.date,
      maxDateTime: DateTime.now(),
      initialDateTime: dateofbirth == null ? new DateTime.now() : dateofbirth,
      dateFormat: "dd,MMMM,yyyy",

      locale: DateTimePickerLocale.en_us,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        print("onchange" + dateTime.toString());
      },
      onConfirm: (dateTime, List<int> index) {
        print("onconform" + dateTime.toString());
        setState(() {
          FocusScope.of(context).requestFocus(new FocusNode());
        });
        if (dateTime != null) {
          dateofbirth = dateTime;
          // String date = new DateFormat("MM-dd-yyyy").format(picked);
          String date = Config_File.getDate(dateTime);
          // String date2 = new DateFormat("yyyy-MM-dd").format(dateTime);
          print(date);
          setState(() {
            if(type=="startDate"){
              startDate.text = date;}
            else{
              endDate.text=date;
            }


            // dob = dateTime.millisecondsSinceEpoch;

            // ageToController.text = "";
          });
        }
      },
    );
  }

  void _openColorPicker(Title) async {
    showColorPopup(
      Title,
      MaterialColorPicker(
        selectedColor: _shadeColor,
        onColorChange: (color) => setState(() => _tempShadeColor = color),
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
        onBack: () => print("Back button pressed"),
      ),
    );
  }

  void showColorPopup(String title, Widget content){

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                //  backgroundColor: ColorInfo.LIGHT_SHADE_BLACK,
                contentPadding: const EdgeInsets.all(0.0),
                elevation: 0.0,
                title: Column(
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 10.0,
                          ),
                          flex: 2,
                        ),
                        Expanded(
                            flex: 0,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 10.0),
                                child:Icon(Icons.clear),
                              ),
                            ))
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0,
                          right: 20.0,
                          top: 20.0,
                          bottom: 0.0),
                      child: Center(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              //  fontFamily: StringFontFamiliy.semibold,
                              color: Config_File.PRIMARY_COLOR,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, left: 10.0, right: 20.0),
                      child: Text(
                        "Pick Color",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Config_File.PRIMARY_COLOR,
                            fontWeight: FontWeight.bold
                          //  fontFamily: StringFontFamiliy.semibold
                        ),
                      ),
                    ),
                  ],
                ),
                content:  content,
                actions: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 10.0, right: 40, top: 20),
                      child: Container(
                        height: 40,width: 150,
                        decoration: BoxDecoration(
                          color: Config_File.PRIMARY_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Center(
                            child: Text(
                              "OK",
                              style: TextStyle(color: Config_File.WHITE),
                            )),
                      ),
                    ),
                  ),
                ],
                actionsPadding: EdgeInsets.all(40),

              );
            }));
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config_File.PRIMARY_COLOR,
        title: Text("Customer"),
        leading: InkWell(onTap:(){
      Navigator.pop(context);
        },child: Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        children: [
          Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "New Quatation",
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
                  child: TextFormField(
                    controller: customerName,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                  child: Text(
                    "Customer Type",
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
                    controller: customerType,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                            child: Text(
                              "Project Start Date",
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
                            padding: const EdgeInsets.only(right: 15.0, left: 20),
                            child: DateTimeField(
                              style: TextStyle(fontSize: 14),
                              controller: startDate,
                              keyboardType: TextInputType.number,

                              format: format,
                              onShowPicker: (context, currentValue) {
                                return datePicker(context,"startDate");
                              },
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.calendar_today),
                                  contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                            child: Text(
                              "Project End Date",
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
                            padding: const EdgeInsets.only(right: 30.0, left: 5),
                            child: DateTimeField(
                              controller: endDate,
                              keyboardType: TextInputType.number,
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return datePicker(context,"endDate");
                              },
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.calendar_today),
                                  contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                  child: Text(
                    "Name of the paint",
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
                  child: DropdownButtonFormField(
                    // controller: paintName,
                    //  keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    value: _myActivity,
                    onChanged: (value) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        _myActivity = value;
                      });
                      _openColorPicker(_myActivity);
                    },
                    onSaved: (value) {
                      setState(() {
                        _myActivity = value;
                      });
                    },
                    items: paintList.map((String paint) {
                      return DropdownMenuItem(
                          child: Text(paint),
                          value: paint);
                    }).toList(),
                  ),
                ),
/*          SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                  child: Text(
                    "Address",
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
                    controller: address,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),*/
                SizedBox(
                  height: 30,
                ),
                _tempShadeColor==null?Container():
                Padding(
                  padding: const EdgeInsets.only(left:20),
                  child: Container(
                    height: 100,width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.red
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [

                            Expanded(
                              flex:1,
                              child: Container(

                              ),
                            ),
                            Expanded(
                              flex:0,
                              child: InkWell(
                                  onTap:(){
                                    setState(() {
                                      _tempShadeColor=null;
                                    });
                                  },
                                  child: Icon(Icons.clear,color: Colors.red,)),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Container(
                            color: _tempShadeColor,
                            height: 50,width: 50,


                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _tempShadeColor==null?Container():   SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                            child: Text(
                              "Total Area(Sq.foot)",
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
                            padding: const EdgeInsets.only(right: 30.0, left: 20),
                            child: TextFormField(
                              controller: totalArea
                              ,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 0.0, top: 0, bottom: 10),
                            child: Text(
                              "Required Paint(in ltr)",
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
                            padding: const EdgeInsets.only(right: 40.0),
                            child: TextFormField(
                              controller: requiredPaint,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                /*Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                            child: Text(
                              "Pincode",
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
                            padding: const EdgeInsets.only(right: 30.0, left: 20),
                            child: TextFormField(
                              controller: pincode,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),*/
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                            child: Text(
                              "Charges per sqft",
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
                            padding: const EdgeInsets.only(right: 30.0, left: 20),
                            child: TextFormField(
                              controller: rate,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 0.0, top: 0, bottom: 10),
                            child: Text(
                              "Discount(%)",
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
                            padding: const EdgeInsets.only(right: 40.0),
                            child: TextFormField(
                              controller: discount,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                            child: Text(
                              "Cost",
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
                            padding: const EdgeInsets.only(right: 30.0, left: 20),
                            child: TextFormField(
                              controller: cost,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 0.0, top: 0, bottom: 10),
                            child: Text(
                              "Tax(%)",
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
                            padding: const EdgeInsets.only(right: 40.0),
                            child: TextFormField(
                              controller: tax,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(bottom: 10, left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 0, bottom: 10),
                  child: Text(
                    "Total Cost",
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
                    controller: toatlCost,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            createRecord("2");
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
                                  child: Text("Save in Draft",
                                      style:
                                      TextStyle(color: Config_File.PRIMARY_COLOR))),
                            ),
                          ),
                        )),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            createRecord("1");
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
                                    "Save",
                                    style: TextStyle(color: Config_File.WHITE),
                                  )),
                            ),
                          ),
                        )),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {

                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 40, top: 30),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Config_File.PRIMARY_COLOR),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Center(
                          child: Text(
                            "Share",
                            style: TextStyle(color: Config_File.PRIMARY_COLOR),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
