import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:miss_stitch/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api/registerApi.dart';
import '../../routeTransition/routeTransition.dart';
import '../Model/NotificationModel/NotificationModel.dart';
import 'notificationDetails.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var body, body1, body2, notificData, userToken;
  bool _notificLoading = true;
  List bbb = ['1', '2', '3'];

  var orderData;

  var total, notificCount2 = 0, notificCount3 = '0';
  List notifList = [];

  var userData, userId;

  @override
  void initState() {
    _getUserInfo();
    //_allData();

    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    ///var token = localStorage.getString('token');
    var user = localStorage.getString('user');
    print('userrrrr');
    print(user);
    // deviceId = localStorage.getString('deviceId');
    ///if (token != null || user != null) {
    if (user != null) {
      var userinfoList = json.decode(user);
      setState(() {
        userData = userinfoList;

        /// userToken = token;
      });
      print('userData');
      print(userData);
    }
    userId =
        userData != null && userData['id'] != null ? '${userData['id']}' : '';
   
    print('User Id');
    print(userId);

    _allData();

  }

  Future<void> _allData() {
    return _showAllNotifications();
  }

  Future _getLocalNotiData(key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localOrderData = localStorage.getString(key);
    if (localOrderData != null) {
      body = json.decode(localOrderData);
      print('local data');
      print(body);
      _orderState();
    }
  }

  Future<void> _showAllNotifications() async {
    var key = 'all-notifications-list';
    await _getLocalNotiData(key);

    var res = await CallApi()
        .getData('/api/notifications/all?type=Customer&customer_id=22');
    body = json.decode(res.body);
    print(body);

    if (res.statusCode == 200) {
      _orderState();

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(key, json.encode(body));
    }
  }

  void _orderState() {
    var notifis = NotificationModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      notificData = notifis.data;
      _notificLoading = false;

      /*notifList = body['totalUnseen'];
      for (int i = 0; i < notifList.length; i++) {
        total = "${notifList[i]['total']}";
        notificCount2 = int.parse(total);
        notificCount = notificCount2;
      }
      //notificCount = notifBody["totalUnseen"]['total'];
      notificCount3 = notificCount2.toString();
      */
      print('djkhfhdbf $notificCount3');
    });

    print('notification dataddssssss');
    print(notificData);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: appColor,
            automaticallyImplyLeading: false,
            elevation: 2.9,
            centerTitle: true,
            titleSpacing: 2,
            title: Container(
              padding: const EdgeInsets.only(top: 0.0),
              child: const Text(
                'Notification',
                style: TextStyle(
                    color: Color(0XFF090909),
                    fontSize: 18.0,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic),
              ),
            ),
            // leading: Builder(
            //   builder: (BuildContext context) {
            //     return IconButton(
            //       icon: const Icon(Icons.arrow_back),
            //       onPressed: () {
            //         //Navigator.push(context, SlideLeftRoute(page: Beneficiary()));
            //       },
            //     );
            //   },
            // ),
            actions: <Widget>[
              ///(notificCount3 != '0') ?
              /*GestureDetector(
                onTap: () {
                   updateAllNotif();
                  if(notificCount > 0) {
                  notificCount = 0;
                  }
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 2),
                    child: Text('Mark all as Read',
                        style: TextStyle(
                          color: appColor,
                          fontSize: 15,
                          fontFamily: "sourcesanspro",
                        ))),
              )*/

              ///: Container(),
            ],
          ),
          body:
              //  _notificLoading
              //     ? Center(
              //         child: CircularProgressIndicator(),
              //       )
              //     :
              SafeArea(
                  child: RefreshIndicator(
                      onRefresh: _showAllNotifications,
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              margin: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                              child: Column(children: <Widget>[
                                /////////////
                                notificData == null
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    :
                                notificData.length == 0
                                    ?
                                 Center(
                                    child: Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 100),
                                    child:
                                        Text("No notifications yet!"),
                                  ))
                                :
                                SingleChildScrollView(
                                    // physics: AlwaysScrollableScrollPhysics(),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.only(
                                            left: 0, right: 0, top: 0),
                                        child: Column(
                                            children: List.generate(
                                               // notificData
                                                   // .length == null? 0 : 
                                                    notificData
                                                    .length 
                                                    //bbb.length // 5
                                                , (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     SlideLeftRoute(
                                              //         page: NotificationDetails(
                                              //             'Purple Dress',
                                              //             'Your Order of Purple Dress is recieved and is in stitching process. It will be deliverd to you 05-09-2022',
                                              //             '2')));
                                              
                                                      // //   print(notificData[index].id);
                                                      if (notificData[index].is_seen == 'no') {
                                                      updateNotify(
                                                          notificData[index]
                                                              .id);
                                                      }

                                                      if(notificCount > 0) {
                                                        notificCount = notificCount-1;
                                                      }

                                                      // // if (notificData[index].type == "Order") {
                                                      // //   //   print("orderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
                                                      // //   ////////// Me //////////////
                                                      if (notificData[index].title != null) {
                                                        Navigator.push(
                                                            context,
                                                            SlideLeftRoute(
                                                                page: NotificationDetails(notificData[index].title,
                                                                notificData[index].message, notificData[index].status)));//notificData[index].type,
                                                      }

                                                      // // }
                                                      
                                            },
                                            child: Container(
                                              //EdgeInsets.fromLTRB(0, 8, 0, 5),
                                              // decoration: BoxDecoration(
                                              //     borderRadius:
                                              //         BorderRadius.circular(8),
                                              //     boxShadow: [
                                              //       BoxShadow(
                                              //         color: Colors.grey[200],
                                              //         blurRadius: 17,
                                              //       )
                                              //     ],
                                              //     color:
                                              //     // notificData[index].isseen == 1
                                              //     //     ? Color(0XFFF0F0F0)
                                              //     //     : Color(0xFFEAF5FF)
                                              //       Color(0XFFF0F0F0)),
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 2),
                                              decoration: const BoxDecoration(
                                                  //color: Color(0XFFF0F0F0),
                                                  color:
                                                      /* notificData[index]
                                                              .isseen ==
                                                          1
                                                      ? const Color(0XFFF0F0F0)
                                                      : */
                                                      Color.fromARGB(
                                                          255,
                                                          229,
                                                          220,
                                                          243) //Color(0xFFEAF5FF)
                                                  ),
                                              padding: const EdgeInsets.only(
                                                  right: 12,
                                                  left: 5,
                                                  top: 2,
                                                  bottom: 12),
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              //color: Colors.blue,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    //color: Colors.red,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 10, 12, 5),
                                                          child: Icon(
                                                              Icons
                                                                  .notifications,
                                                              color: appColor,
                                                              size: 24),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            //color: Colors.red,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 10),
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 8),
                                                                  child:
                                                                       Text(
                                                                    //'Order Status', //
                                                                      "${notificData[index].title}", //trac,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0XFF090909),
                                                                        fontFamily:
                                                                            "Proxima Nova",
                                                                        fontSize:
                                                                            13,
                                                                        height:
                                                                            1.5,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 6),
                                                                  child: Text(
                                                                   // 'Your Order is Recevied', 
                                                                    "${notificData[index].message}", //

                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style: TextStyle(
                                                                        color: const Color(0XFF090909).withOpacity(
                                                                            0.7),
                                                                        height:
                                                                            1.6,
                                                                        fontFamily:
                                                                            "Proxima Nova",
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                        //EdgeInsets.fromLTRB(0, 8, 0, 5),
                                                        // decoration: BoxDecoration(
                                                        //     borderRadius:
                                                        //         BorderRadius.circular(8),
                                                        //     boxShadow: [
                                                        //       BoxShadow(
                                                        //         color: Colors.grey[200],
                                                        //         blurRadius: 17,
                                                        //       )
                                                        //     ],
                                                        //     color:
                                                        //     // notificData[index].isseen == 1
                                                        //     //     ? Color(0XFFF0F0F0)
                                                        //     //     : Color(0xFFEAF5FF)
                                                        //       Color(0XFFF0F0F0)),

                                                        Container(
                                                          //color: Colors.red,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5,
                                                                        right:
                                                                            3),
                                                                child:
                                                                     Text(
                                                                 // '12 Aug, 2022',
                                                                  notificData[index].created_at == null
                                                                      ? "- - -"
                                                                      : '${DateFormat.yMMMd().format(DateTime.parse(notificData[index].created_at))}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0XFF090909),
                                                                      fontFamily:
                                                                          "Proxima Nova",
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5,
                                                                        right:
                                                                            3),
                                                                child:
                                                                     Text(
                                                                  //'12:00 PM',
                                                                  notificData[index].created_at == null
                                                                      ? "- - -"
                                                                      : '${DateFormat('kk:mm:a').format(DateTime.parse(notificData[index].created_at))}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0XFF090909),
                                                                      fontFamily:
                                                                          "Proxima Nova",
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                        // Container(
                                                        //   child: Row(
                                                        //     children: <Widget>[
                                                        //       Container(
                                                        //         child: IconButton(
                                                        //           icon: Icon(
                                                        //             Icons.delete,
                                                        //             size: 18,
                                                        //             color: appColor,
                                                        //           ),
                                                        //           onPressed: () {
                                                        //             _showDeleteAlert(index);
                                                        //           },
                                                        //         ),
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }))))
                              ])))))),
    );
  }


  updateNotify(id) async {
    var data = {
      'id': id,
      /// 'isseen': 1,
    };

    var res = await CallApi().postData(data, '/api/notifications/update/data');

    body1 = json.decode(res.body);

    print(data);
    print(body1);

    if (res.statusCode == 200) {
      //    store.dispatch(SeenNotificationAction(store.state.unseenState-1));

      setState(() {
        // if(notificCount > 0) {
        // notificCount = notificCount-1;
        // }
        _showAllNotifications();
         // _showToast();
      });

      // print(notificData[index].type);
      // print(notificData[index].id);

    }
  }
/*
  updateAllNotif() async {
    var data = {
      //   'id': id,
    };

    var res = await CallApi().postData1(data, '/app/seenAllNotification');

    body2 = json.decode(res.body);

    print(data);
    print(body2);

    if (res.statusCode == 200) {
      //    store.dispatch(SeenNotificationAction(store.state.unseenState-1));

      setState(() {
        _showAllNotifications();
        notificCount = 0;
        // _showToast();
      });

      // Navigator.push(
      //     context, SlideLeftRoute(page: BottomNavigationPage(3)));

      // print(notificData[index].type);
      // print(notificData[index].id);

    }
  }

  deleteNotifyList(id) async {
    // var data = {
    //   'id': id,
    // };

    // var res = await CallApi()
    //     .postData(data, '/app/deleteNotification');

    // body1 = json.decode(res.body);

    // //print(data);

    // if (res.statusCode == 200) {
    //   setState(() {
    //     _showAllNotifications();
    //     //  _showToast();
    //   });
    // }
  }
*/
  // _showToast() {
  //   Fluttertoast.showToast(
  //       msg: "Deleted successfully!",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIos: 1,
  //       backgroundColor: appTealColor.withOpacity(0.9),
  //       textColor: Colors.white,
  //       fontSize: 13.0);
  // }

  void _showDeleteAlert(int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
            //    width: double.maxFinite,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //  color: Colors.red,
                  // width: double.maxFinite,
                  margin: const EdgeInsets.only(bottom: 30),
                  // height: 40,
                  alignment: Alignment.center,

                  child: const Text(
                    "Are you sure you want to remove this item from notification?",
                    textAlign: TextAlign.center,
                    //maxLines: 3,
                    style: TextStyle(
                        color: Color(0XFF414042),
                        fontFamily: "SourceSansPro",
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        ///deleteNotifyList(notificData[index].id);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 80,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: appColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50))),
                        child:
                            const Text("Yes", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        width: 80,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: appColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50))),
                        child: Text("No", style: TextStyle(color: appColor)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    return false;
  }
  /*Future<bool> _onWillPop() async {
    return (
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            //   title: new Text('Are you sure?'),
            content: const Text('Do you want to exit this App'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: TextStyle(color: appColor),
                ),
              ),
              ElevatedButton(
                onPressed: () => exit(0),
                child: Text(
                  'Yes',
                  style: TextStyle(color: appColor),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }
*/

  // Future<bool> _onWillPop() async {
  //   // Navigator.push(context,
  //   //                   SlideLeftRoute(page: Beneficiary()));
  //   return false;
  //   // WillPopScope(
  //   //       onWillPop: _onWillPop,
  // }
}

// import 'dart:convert';

// import 'package:chatapp_new/API/api.dart';
// import 'package:chatapp_new/Cards/NotificationCard/notificationCard.dart';
// import 'package:chatapp_new/JSON_Model/NotifyModel/NotifyModel.dart';
// import 'package:chatapp_new/Loader/NotificationLoader/notifyLoader.dart';
// import 'package:chatapp_new/MainScreen/AllRequestPage/allRequestPage.dart';
// import 'package:chatapp_new/MainScreen/FriendProfileReplyPage/FriendProfileReplyPage.dart';
// import 'package:chatapp_new/MainScreen/GroupDetailsPage/groupDetailsPage.dart';
// import 'package:chatapp_new/MainScreen/ProductDetails/productDetails.dart';
// import 'package:chatapp_new/MainScreen/ProfilePages/FriendsProfilePage/friendsProfilePage.dart';
// import 'package:chatapp_new/MainScreen/ProfilePages/MyProfilePage/myProfilePage.dart';
// import 'package:chatapp_new/MainScreen/ShopPage/shopPage.dart';
// import 'package:chatapp_new/MainScreen/StatusDetailsPage/StatusDetailsPage.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';
// import 'dart:async';

// import '../../main.dart';

// class NotifyPage extends StatefulWidget {
//   @override
//   NotifyPageState createState() => NotifyPageState();
// }

// class NotifyPageState extends State<NotifyPage> {
//   SharedPreferences sharedPreferences;
//   String theme = "", daysAgo = "";
//   Timer _timer;
//   int _start = 3;
//   int lastNotifyID;
//   bool loading = true;
//   var notifyList, userData;
//   ScrollController _controller = new ScrollController();
//   List notificationList = [];

//   @override
//   void initState() {
//     _getUserInfo();
//     loadNotification();
//     super.initState();
//   }

//   void _getUserInfo() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var userJson = localStorage.getString('user');
//     var user = json.decode(userJson);
//     setState(() {
//       userData = user;
//       //_isLoaded = true;
//     });

//     //print("${userData['shop_id']}");
//   }

//   Future loadNotification() async {
//     //await Future.delayed(Duration(seconds: 3));
//     var postresponse = await CallApi().getData2('get-noti');
//     print(postresponse);
//     var postcontent = postresponse.body;
//     final posts = json.decode(postcontent);
//     var postdata = NotifyModel.fromJson(posts);

//     setState(() {
//       notifyList = postdata;
//       for (int i = 0; i < notifyList.allNotification.length; i++) {
//         //print(notifyList.allNotification[i].id);
//         notificationList.add(notifyList.allNotification[i]);
//         lastNotifyID = notifyList.allNotification[i].id;
//         print(lastNotifyID);
//       }

//       _controller.addListener(() {
//         if (_controller.position.atEdge) {
//           if (_controller.position.pixels == 0) {
//             setState(() {
//               print("top");
//             });
//           }
//           // you are at top position

//           else {
//             setState(() {
//               print("bottom");
//               loadMoreNotification(lastNotifyID);

//               print("lastNotifyID 1");
//               print(lastNotifyID);
//             });
//           }
//           // you are at bottom position
//         }
//       });
//     });
//     print("notifyList.allNotification.length");
//     print(notifyList.allNotification.length);

//     setState(() {
//       loading = false;
//     });
//   }

//   Future loadMoreNotification(lastNotifyID) async {
//     //await Future.delayed(Duration(seconds: 3));
//     var postresponse1 = await CallApi().getData2('more-noti/$lastNotifyID');
//     print(postresponse1);
//     var postcontent1 = postresponse1.body;
//     final posts1 = json.decode(postcontent1);
//     var postdata1 = NotifyModel.fromJson(posts1);

//     setState(() {
//       notifyList = postdata1;
//       lastNotifyID = "";
//       int last = 0;
//       for (int i = 0; i < notifyList.allNotification.length; i++) {
//         print("notifyList.allNotification[i].id");
//         print(notifyList.allNotification[i].id);
//         notificationList.add(notifyList.allNotification[i]);
//         last = notifyList.allNotification[i].id;
//       }

//       lastNotifyID = last;
//       _controller.addListener(() {
//         if (_controller.position.atEdge) {
//           if (_controller.position.pixels == 0) {
//             setState(() {
//               print("top");
//             });
//           }
//           // you are at top position

//           else {
//             setState(() {
//               print("bottom");
//               loadMoreNotification(lastNotifyID);

//               print("lastNotifyID 1");
//               print(lastNotifyID);
//             });
//           }
//           // you are at bottom position
//         }
//       });

//       print("lastNotifyID 23");
//       print(lastNotifyID);
//     });
//     print("notifyList.allNotification.length");
//     print(notifyList.allNotification.length);

//     setState(() {
//       loading = false;
//     });
//   }

//   void makeSeen(id) async {
//     var data = {
//       'isseen': 'Yes',
//     };

//     //print(data);

//     var res = await CallApi().postData1(data, 'mark-as-red/$id');
//     var body = json.decode(res.body);
//     print("body");
//     print(body);

//     if (res.statusCode == 200) {
//       print("ok");
//     } else {
//       print("not ok");
//     }
//   }

//   Future<void> pageRoute(result) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     localStorage.setString('stid', result);

//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => StatusDetailsPage()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       ////// <<<<< Background color >>>>> //////
//       backgroundColor: Colors.white,

//       ////// <<<<< AppBar >>>>> //////
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.grey),
//         backgroundColor: Colors.white,
//         title: Container(
//           margin: EdgeInsets.only(top: 0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ////// <<<<< Title >>>>> //////
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(left: 5, right: 15),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(5)),
//                   ),
//                   child: Container(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Notification",
//                         style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 20,
//                             fontFamily: 'Oswald',
//                             fontWeight: FontWeight.normal),
//                       )),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),

//       ////// <<<<< Body >>>>> //////
//       body: Container(
//           height: MediaQuery.of(context).size.height,
//           child: loading
//               ? Center(child: CircularProgressIndicator())
//               : notificationList.length == 0
//                   ? Center(
//                       child: Container(
//                         child: Text("No Notification Available!"),
//                       ),
//                     )
//                   : Container(
//                       child: ListView.builder(
//                           controller: _controller,
//                           itemCount: notificationList.length,
//                           itemBuilder: (context, index) {
//                             List day = [];
//                             for (int i = 0; i < notificationList.length; i++) {
//                               DateTime date1 = DateTime.parse(
//                                   "${notificationList[i].created_at}");

//                               daysAgo = DateFormat.yMMMd().format(date1);
//                               day.add(daysAgo);
//                             }
//                             return loading == false
//                                 ? GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         String url =
//                                             notificationList[index].url;
//                                         int number = '/'.allMatches(url).length;
//                                         String result = "";
//                                         if (number > 1) {
//                                           if (number == 3) {
//                                             var urlCheck = url.split("/");
//                                             print(urlCheck);
//                                             String first = urlCheck[0];
//                                             String second = urlCheck[1];
//                                             String third = urlCheck[2];
//                                             String fourth = urlCheck[3];

//                                             print(third);
//                                             print(fourth);

//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         ProductDetailsPage(
//                                                             fourth)));
//                                           } else {
//                                             var urlCheck = url.split("/");
//                                             String first = urlCheck[1];
//                                             String second = urlCheck[2];

//                                             if (second.contains("?")) {
//                                               result = second.substring(
//                                                   0, second.indexOf('?'));
//                                             } else {
//                                               result = second;
//                                             }

//                                             print(first);
//                                             print(result);

//                                             if (first == "community") {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           GroupDetailsPage(
//                                                               result)));
//                                             } else if (first == "shop") {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           ShopPage(result,
//                                                               userData['id'])));
//                                             } else if (first == "profile") {
//                                               if (userData['userName'] ==
//                                                   result) {
//                                                 Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             MyProfilePage(
//                                                                 userData)));
//                                               } else {
//                                                 Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             FriendsProfilePage(
//                                                                 result, 2)));
//                                               }
//                                             } else {
//                                               pageRoute(result);
//                                             }
//                                           }
//                                         } else {
//                                           url = url.replaceAll("/", "");

//                                           print(url);

//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       AllRequestPage()));
//                                         }

//                                         if (notifyNum != 0) {
//                                           notifyNum--;
//                                           if (notifyNum < 0) {
//                                             notifyNum = 0;
//                                           }
//                                         }

//                                         print(notifyNum);

//                                         notificationList[index].isseen = "Yes";

//                                         makeSeen(notificationList[index].id);
//                                       });
//                                     },
//                                     child: Container(
//                                       padding:
//                                           EdgeInsets.only(top: 0, bottom: 0),
//                                       decoration: BoxDecoration(
//                                         color:
//                                             notificationList[index].isseen == "No"
//                                                 ? Colors.grey.withOpacity(0.2)
//                                                 : Colors.white,
//                                         borderRadius: BorderRadius.circular(15),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             blurRadius: 1.0,
//                                             color: notificationList[index]
//                                                         .isseen ==
//                                                     "No"
//                                                 ? Colors.grey.withOpacity(0.1)
//                                                 : Colors.black38
//                                                     .withOpacity(0.3),
//                                           ),
//                                         ],
//                                       ),
//                                       margin: EdgeInsets.only(
//                                           top: 2.5,
//                                           bottom: 2.5,
//                                           left: 10,
//                                           right: 10),
//                                       child: Container(
//                                         margin: EdgeInsets.all(15),
//                                         child: Row(
//                                           children: <Widget>[
//                                             Stack(
//                                               children: <Widget>[
//                                                 ////// <<<<< Picture >>>>> //////
//                                                 // Container(
//                                                 //   margin: EdgeInsets.only(right: 0, top: 0),
//                                                 //   padding: EdgeInsets.all(1.0),
//                                                 //   child: CircleAvatar(
//                                                 //     radius: 25.0,
//                                                 //     backgroundColor: Colors.transparent,
//                                                 //     backgroundImage: index % 2 == 0
//                                                 //         ? AssetImage('assets/images/man.png')
//                                                 //         : AssetImage('assets/images/man2.jpg'),
//                                                 //   ),
//                                                 //   decoration: new BoxDecoration(
//                                                 //     color: Colors.grey[300],
//                                                 //     shape: BoxShape.circle,
//                                                 //   ),
//                                                 // ),

//                                                 ////// <<<<< React Icon along with picture >>>>> //////
//                                                 Container(
//                                                   margin: EdgeInsets.only(
//                                                       left: 0, top: 0),
//                                                   padding: EdgeInsets.all(4.0),
//                                                   decoration: new BoxDecoration(
//                                                       color: Colors.white,
//                                                       shape: BoxShape.circle,
//                                                       border: Border.all(
//                                                           width: 0.4,
//                                                           color: header)),
//                                                   child: Icon(
//                                                     Icons.notifications,
//                                                     size: 15,
//                                                     color: header,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Expanded(
//                                               child: Container(
//                                                 margin:
//                                                     EdgeInsets.only(left: 10),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: <Widget>[
//                                                     Text.rich(
//                                                       TextSpan(
//                                                         children: <TextSpan>[
//                                                           ////// <<<<< Who reacted >>>>> //////
//                                                           TextSpan(
//                                                               text: notificationList[
//                                                                               index]
//                                                                           .name ==
//                                                                       null
//                                                                   ? ""
//                                                                   : "${notificationList[index].name}",
//                                                               style: TextStyle(
//                                                                 color: Colors
//                                                                     .black,
//                                                                 fontSize: 15,
//                                                                 fontFamily:
//                                                                     'Oswald',
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                               )),

//                                                           ////// <<<<< Reacted for what >>>>> //////
//                                                           TextSpan(
//                                                               text:
//                                                                   " ${notificationList[index].notiTxt}",
//                                                               style: TextStyle(
//                                                                 color: Colors
//                                                                     .black54,
//                                                                 fontSize: 15,
//                                                                 fontFamily:
//                                                                     'Oswald',
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w300,
//                                                               )),
//                                                         ],
//                                                       ),
//                                                     ),

//                                                     ////// <<<<< Time >>>>> //////
//                                                     Container(
//                                                       margin: EdgeInsets.only(
//                                                           top: 5),
//                                                       child: Text(
//                                                         "${day[index]}",
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.black45,
//                                                             fontFamily:
//                                                                 'Oswald',
//                                                             fontWeight:
//                                                                 FontWeight.w300,
//                                                             fontSize: 12),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),

//                                             ////// <<<<< More Icon >>>>> //////
//                                             // Container(
//                                             //     margin: EdgeInsets.only(
//                                             //         left: 12, right: 0),
//                                             //     child: Icon(
//                                             //       Icons.more_horiz,
//                                             //       color: Colors.black45,
//                                             //     ))
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 : NotifyLoaderCard();
//                           }),
//                     )
//           //NotificationCard(notifyList.allNotification, loading),
//           ),
//     );
//   }
// }
