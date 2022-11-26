// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:miss_stitch/screens/Orders/orderPage.dart';
import 'package:miss_stitch/screens/login.dart';
import 'package:miss_stitch/screens/Profile/profile.dart';

import '../main.dart';
import 'Home/home.dart';
import 'Notifications/notifications.dart';
import 'Orders/AllOrders/ordersHome.dart';

class BottomNavigationPage extends StatefulWidget {
  //const BottomNavigationPage({Key? key}) : super(key: key);
  final index;
  BottomNavigationPage(this.index);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
// class BottomNavigationPage extends StatefulWidget {
//   // final index;
//   // BottomNavigationPage(this.index);
//   @override
//   _BottomNavigationPageState createState() => _BottomNavigationPageState();
// }

// class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = bottomNavIndex;
  bool _isLoggedIn = false;

  var notifBody, notificData, total;
  List notifList = [];

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    OrdersHome(),//ProductDetails('dd', 2,'dd'),//OrderDetail(),
    Notifications(),
    Profile(),
    //LoginScreen()
  ];

  void _onItemTapped(int index) {
    // _isLoggedIn == false && index != 0?
    // setState(() {
    //   if(index == 1) { loginFromWhere = 'inbox' ;}
    //   else if(index == 2) { loginFromWhere = 'minidashboard' ;}
    //   else if(index == 3) { loginFromWhere = 'notifications' ;}
    //   else if(index == 4) { loginFromWhere = 'profile' ;}
    //   Navigator.push(context,
    //         SlideLeftRoute(page: LoginForm(loginFromWhere)));
    //         print(loginFromWhere);
    // })
    // :
    setState(() {
      bottomNavIndex = index;
    //   if(index == 0){
    //     bottomNavIndex = index;
    //     seeAll2 = false;
    //   seeAllServices2 = false;
    //   seeAllProducts2 = false;
    //   print(seeAll2);
    //   print(seeAllServices2);
    //   print(seeAllProducts2);
    // }else {
    //   bottomNavIndex = index;
    // }
    });
  }

  @override
  void initState() {
    bottomNavIndex = widget.index;
   // _checkIfLoggedIn();
    print('is logged in true $_isLoggedIn');
    //notifyCount();
    super.initState();
  }


  // void _checkIfLoggedIn() async {
  //   // check if token is there
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var token = localStorage.getString('token');
  //   // notificCount = int.parse(localStorage.getString('notifCount'));
  //   if (token != null) {
  //     setState(() {
  //       _isLoggedIn = true;
  //     });
  //   print('is logged in true $_isLoggedIn');
  //   print('djsgdh $notificCount');
  //   }
  // }

  // Future<void> notifyCount() async {
  //   var res = await CallApi().getData('/app/getUserNotification');
  //   notifBody = json.decode(res.body);
  //   print(notifBody);

  //   if (res.statusCode == 200) {
  //     _orderState();
  //   }
  // }

  // Future<void> _orderState() async {
  //   if (!mounted) return;
  //   setState(()  {
  //     notifList = notifBody['totalUnseen'];
  //     for (int i = 0; i < notifList.length; i++) {
  //     total = "${notifList[i]['total']}";
  //     notificCount = int.parse(total);
  //   }
  //     //notificCount = notifBody["totalUnseen"]['total'];
  //     var notif = notificCount.toString();
  //     print('djkhfhdbf $notif');
  //     // store.dispatch(UnseenNotificationAction(notificCount));
  //     // print("unseen");
  //     // print(store.state.unseenState);

  //     // print("seen");
  //     // print(store.state.seenState);
  //     // showNumber = store.state.unseenState - store.state.seenState;
  //     // print("show numberrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
  //     // print(showNumber);
  //     // _notificLoading = false;
  //   });
  //   // SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   //   localStorage.setString('notifCount', '$notificCount');
  //   print("count");
  //   print(notificCount);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFc5a3f9),
      body: SafeArea(
        child: Container(
          child: Center(
            child: _widgetOptions.elementAt(bottomNavIndex),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 26,),
            label: 'Home',
          ),
         
          BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined, size: 24,), 
              label: 'Orders'
              //title: SizedBox.shrink(),//Text('')
              ),
          // BottomNavigationBarItem(
          //   icon:
          //   // Icon(Icons.notifications_none,
          //   // // color: notificCount == 0 || notificCount == null?
          //   // // Colors.transparent
          //   // // :
          //   // // Colors.red[900],
          //   // ),
          //   new Stack(children: <Widget>[
          //           // notificCount != 0
          //           //     ? Container(
          //           //         margin: EdgeInsets.only(top: 5, right: 17),
          //           //         child: new Icon(
          //           //           Icons.notifications_none,
          //           //           size: 25,
          //           //         ),
          //           //       )
          //           //     : 
          //               Container(
          //                   margin: EdgeInsets.only(top: 0, right: 0),
          //                   child: new Icon(
          //                     Icons.notifications_none,
          //                     size: 25,
          //                   ),
          //                 ),
          //           // notificCount == 0
          //           //     ? 
          //               Positioned(
          //                   right: 0,
          //                   child: Container(
          //                     padding: EdgeInsets.only(
          //                         top: 1, bottom: 1, right: 5, left: 5),
          //                     margin: EdgeInsets.only(
          //                         right: 0, left: 0, bottom: 10),
          //                     decoration: BoxDecoration(
          //                         color: Colors.transparent,
          //                         borderRadius: BorderRadius.circular(15)),
          //                   ),
          //                 )
          //               // : 
          //               // Positioned(
          //               //     left: 9,
          //               //     child: Container(
          //               //       padding: EdgeInsets.only(
          //               //           top: 2, bottom: 1, right: 5, left: 5),
          //               //       margin: EdgeInsets.only(
          //               //           right: 0, left: 0, bottom: 10),
          //               //       decoration: BoxDecoration(
          //               //           color: Colors.red[600],
          //               //           borderRadius: BorderRadius.circular(15)),
          //               //       child: Text(
          //               //         notificCount.toString(),
          //               //         textAlign: TextAlign.start,
          //               //         style: TextStyle(
          //               //             color: Colors.white,
          //               //             fontSize: 9,
          //               //             fontFamily: 'Oswald',
          //               //             fontWeight: FontWeight.w400),
          //               //       ),
          //               //     ),
          //               //   )
          //         ]),
          //   //title: SizedBox.shrink(),//Text(''),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none, size: 25,),
           // title: SizedBox.shrink(),//Text(''),
           label: 'Notifications'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 26,),
            label: 'Profile'
           // title: SizedBox.shrink(),//Text(''),
          ),
        ],
        currentIndex: bottomNavIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 26,
        unselectedItemColor: Color(0XFF090909),
        selectedItemColor: Color.fromARGB(255, 143, 83, 234),
        onTap: _onItemTapped,
      ),
    );
  }
}
