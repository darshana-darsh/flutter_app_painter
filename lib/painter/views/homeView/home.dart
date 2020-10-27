import 'package:flutter_app/painter/views/moreView/MorePage.dart';
import 'package:flutter_app/painter/views/notification/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_app/config/Config_file.dart';
import 'package:flutter_app/painter/views/customerView/Customer.dart';
import 'package:flutter_app/painter/views/quatationView/Quatation.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';

import '../dashboard.dart';
import 'package:flutter_app/painter/views/notification/notificationList.dart';
import 'package:flutter_app/painter/views/homeView/customTab.dart' as mycustomtab;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final databaseReference = Firestore.instance;
  DocumentSnapshot profileSnapshot;
  DocumentReference profileReference;

  @override
  void initState() {
    super.initState();
    print("status------------------------" +UserPreference.getLoginStatus().toString());
    print("photo------------------------" +UserPreference().getImage().toString());

    setState(() {
      getData();
    });
    _controller = new TabController(length: 5, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  getData() async {
    // Config_File.showLoader(context);
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    print(firebaseUser.uid);
    var document = await databaseReference
        .collection("Users")
        .document(firebaseUser.uid)
        .get();

    print(document.data);
    if (document.data.length == 4) {
      setState(() {
        UserPreference().setUserName(document.data["username"]);
        UserPreference().setUserId(UserPreference().getUserId());
        UserPreference().setEmail(document.data["email"]);
       // UserPreference().setImage(document.data["profile_photo"]);

        // UserPreference().setImage(profileSnapshot["profileImage"]);
      });
    } else {
      setState(() {
        UserPreference().setUserId(firebaseUser.uid);
        UserPreference().setUserName(document.data["username"]);
        UserPreference().setEmail(document.data["email"]);
        UserPreference().setPhone(document.data["phone"]);
        UserPreference().setExperince(document.data["experience"]);
        UserPreference().setAddress(document.data["address"]);
        UserPreference().setRate(document.data["rate"]);
        UserPreference().setImage(document.data["profile_photo"]);
      });
    }

    //    Config_File.cancelLoader(context);
  }

  List<Widget> _widgets = [
    Dashboard_page(),
    Customer_Page(),
    Quatation_Page(),
    Dashboard_page(),
    More_page(),
  ];
  List<String> _title = [
    "Dashboard",
    "Customer",
    "Quatation",
    "Payment",
    "More"
  ];
  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      //backgroundColor: Config_File.WHITE,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Config_File.PRIMARY_COLOR,
        title: Text(_title[selectedIndex]),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new InkWell(
              child: Image.asset(
                "assets/images/icon-bell.png",
                width: 25,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Notification_Page()));
                // Get.offAllNamed("/notification");
                //  _scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new InkWell(
              child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CircleAvatar(
                          radius: 20,
                          child:UserPreference().getImage() == null
                          ?  Image.asset(
                            "assets/images/user.png",
                          ): Image.network(UserPreference().getImage()),)),

              onTap: () {
                _openEndDrawer();
              },
            ),
          )
        ],
      ),
      endDrawer: Config_File().appDrawer(context),
      body:  TabBarView(
        physics: NeverScrollableScrollPhysics(),
      controller: _controller,

      children: [
        Dashboard_page(),
        Customer_Page(),
        Quatation_Page(),
        Dashboard_page(),
        More_page(),
      ],
    ),
      //_widgets[selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        child: mycustomtab.TabBar(

          indicatorColor: Colors.white,
          controller: _controller,
          activeBackgroundColor: Config_File.DARK_PINK,
          inactiveBackgroundColor: Config_File.PRIMARY_COLOR,
          indicatorWeight: 0.1,
          unselectedLabelColor: Colors.white,



          tabs: [

            mycustomtab.MyCustomTab(
              icon: Image.asset(
                'assets/images/icon-home.png',
                height: 30,
                width: 26,
              ),
              text: "Home",
            ),
            mycustomtab.MyCustomTab(
              icon: Image.asset(
                'assets/images/icon-customer.png',
                height: 30,
                width: 26,
              ),

              text: "Customer",
            ),
            mycustomtab.MyCustomTab(
              icon: Image.asset(
                'assets/images/icon-discount.png',
                height: 30,
                width: 26,
              ),

              text: "Quatation",
            ),
            mycustomtab.MyCustomTab(
              icon: Image.asset(
                'assets/images/icon-money.png',
                height: 30,
                width: 26,
              ),

         text: "Payment",
            ),
            mycustomtab.MyCustomTab(
              icon: Image.asset(
                'assets/images/icon-more.png',
                height: 30,
                width: 26,
              ),

              text: "More",
            )
          ],
        ),
      ),
      /*bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/icon-home.png',
                height: 30,
                width: 26,
              ),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/icon-customer.png',
                height: 30,
                width: 26,
              ),
              title: Text(_title[1]),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/icon-discount.png',
                height: 30,
                width: 26,
              ),
              title: Text(_title[2]),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/icon-money.png',
                height: 30,
                width: 26,
              ),
              title: Text(_title[3]),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/icon-more.png',
                height: 30,
                width: 26,
              ),
              title: Text(_title[4]),
            ),
          ],
          currentIndex: selectedIndex,
          fixedColor: Colors.white,
          backgroundColor: Config_File.PRIMARY_COLOR,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: tapped,
          unselectedItemColor: Colors.white,
          selectedFontSize: 12,
          unselectedFontSize: 12,
        ),
      ),*/
    );
  }

  tapped(int tappedIndex) {
    setState(() {
      selectedIndex = tappedIndex;
    });
  }
}
