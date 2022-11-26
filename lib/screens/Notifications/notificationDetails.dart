import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:miss_stitch/main.dart';
import 'package:miss_stitch/routeTransition/routeTransition.dart';
import 'package:miss_stitch/screens/bottomNavigation.dart';
import 'notifications.dart';


class NotificationDetails extends StatefulWidget {
  final title;
  final msg;
  final tracId;

  NotificationDetails(this.title, this.msg, this.tracId);

  @override
  _NotificationDetailsState createState() =>
      _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  String isReviewd = "";
  var body;
  var orderData;
  bool _isLoading = true;
  var serviceBody, serviceMsg = '';
  List serviceList = [];

  @override
  void initState() {
    // print(_isLoading);
   /// getServiceList();
    bottomNavIndex = 2;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      //_selectedIndex = index;
      bottomNavIndex = index;
    });
  }

  /*Future<void> getServiceList() async {
    var res = await CallApi().getData('/app/getAllServicesById/${widget.tracId}');
    serviceBody = json.decode(res.body);
    print(serviceBody);
    print(res.statusCode);

    if (res.statusCode == 200) {
      var servicecontent = res.body;
      final service = json.decode(servicecontent);
      print(service);

      // var servicedata = AllServiceModel.fromJson(service);
      // serviceList = servicedata.service;

      // if (serviceList != null) {
      //   if (!mounted) return;
      //   setState(() {
      //     //  String dd = serviceList.created_at;
      //     //  var spDate = dd.split(" ");
      //     //  alertDate = spDate[0];
      //     // situation = serviceList.situation;
      //     print('serviceList');
      //     print(serviceList);
      //   });
      //   print(service);
      // } else {
      //   setState(() {
      //     serviceMsg = "No service data available!";
      //   });
      // }

      print("serviceList.length");
      print(serviceList);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return 
    bottomNavIndex == 2
        ? Scaffold(
            extendBodyBehindAppBar: true,
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     if (_isLoggedIn == true) {
            //       if (userId == sellerId) {
            //         return _showMessage('This is your own product');
            //       } else {
            //         Navigator.push(
            //             context,
            //             SlideLeftRoute(
            //                 page: ChattingPage(
            //                     sellerFirstName,
            //                     sellerLastName,
            //                     conversationId,
            //                     userId,
            //                     sellerId,
            //                     userData,
            //                     widget.productList)));
            //       }
            //     } else {
            //       loginFromWhere = 'productDetails';
            //       Navigator.push(
            //           context, SlideLeftRoute(page: LoginForm(loginFromWhere)));
            //     }
            //     // loginFromWhere = 'product';
            //     // Navigator.push(context,
            //     //   SlideLeftRoute(page: LoginForm(loginFromWhere)));
            //     // Navigator.push(context,
            //     //   SlideLeftRoute(page: ChattingPage(ind, id,id2,id3,id4,id5)));
            //   },
            //   backgroundColor: Color(0XFFF8F8F8),
            //   child: Icon(Icons.speaker_notes, color: appColor, size: 28),
            // ),
            // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            bottomNavigationBar: BottomNavigationBar(
              items:  <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 26,),
            label: 'Home',
          ),
         
          
                // BottomNavigationBarItem(
                //   icon: 
                //   Stack(children: <Widget>[
                //     // chatUnseenNum != 0
                //     //     ? 
                //     //     Container(
                //     //         margin: EdgeInsets.only(top: 6, right: 17),
                //     //         child: new Icon(
                //     //           Icons.mail_outline,
                //     //           size: 23,
                //     //         ),
                //     //       )
                //     //     : 
                //         Container(
                //             margin: EdgeInsets.only(top: 0, right: 0),
                //             child: Icon(
                //               Icons.mail_outline,
                //               size: 23,
                //             ),
                //           ),
                //     // chatUnseenNum == 0
                //     //     ? 
                //         Positioned(
                //             right: 0,
                //             child: Container(
                //               padding: EdgeInsets.only(
                //                   top: 1, bottom: 1, right: 5, left: 5),
                //               margin: EdgeInsets.only(
                //                   right: 0, left: 0, bottom: 10),
                //               decoration: BoxDecoration(
                //                   color: Colors.transparent,
                //                   borderRadius: BorderRadius.circular(15)),
                //             ),
                //           )
                //         // : 
                //         // Positioned(
                //         //     left: 9,
                //         //     child: Container(
                //         //       padding: EdgeInsets.only(
                //         //           top: 2, bottom: 1, right: 5, left: 5),
                //         //       margin: EdgeInsets.only(
                //         //           right: 0, left: 0, bottom: 10),
                //         //       decoration: BoxDecoration(
                //         //           color: Colors.red[600],
                //         //           borderRadius: BorderRadius.circular(15)),
                //         //       child: Text(
                //         //         chatUnseenNum.toString(),
                //         //         textAlign: TextAlign.start,
                //         //         style: TextStyle(
                //         //             color: Colors.white,
                //         //             fontSize: 9,
                //         //             fontFamily: 'Oswald',
                //         //             fontWeight: FontWeight.w400),
                //         //       ),
                //         //     ),
                //         //   )
                //   ]),
                //   //Icon(Icons.mail_outline, size: 23),
                //   // title: SizedBox.shrink(), //Text(''),
                // ),
                const BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined, size: 24,), 
              label: 'Orders'
              //title: SizedBox.shrink(),//Text('')
              ),
                
                BottomNavigationBarItem(
                  label: 'Notifications',
                  icon: 
                  // ignore: unnecessary_new
                  new Stack(children: <Widget>[
                    // notificCount != 0
                    //     ? Container(
                    //         margin: EdgeInsets.only(top: 5, right: 17),
                    //         child: new Icon(
                    //           Icons.notifications_none,
                    //           size: 25,
                    //         ),
                    //       )
                    //     : 
                        Container(
                            margin: EdgeInsets.only(top: 0, right: 0),
                            child: const Icon(
                              Icons.notifications_none,
                              size: 25,
                            ),
                          ),
                    // notificCount == 0
                    //     ? 
                        Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 1, bottom: 1, right: 5, left: 5),
                              margin: EdgeInsets.only(
                                  right: 0, left: 0, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          )
                        // : 
                        // Positioned(
                        //     left: 9,
                        //     child: Container(
                        //       padding: EdgeInsets.only(
                        //           top: 1, bottom: 1, right: 5, left: 5),
                        //       margin: EdgeInsets.only(
                        //           right: 0, left: 0, bottom: 10),
                        //       decoration: BoxDecoration(
                        //           color: Colors.red[600],
                        //           borderRadius: BorderRadius.circular(15)),
                        //       child: Text(
                        //         notificCount.toString(),
                        //         textAlign: TextAlign.start,
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 9,
                        //             fontFamily: 'Oswald',
                        //             fontWeight: FontWeight.w400),
                        //       ),
                        //     ),
                        //   )
                  ]),
                  //Icon(Icons.notifications_none),
                 // title: SizedBox.shrink(), //Text(''),
                ),
              
          const BottomNavigationBarItem(
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
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: appColor,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
                          context, SlideLeftRoute(page: BottomNavigationPage(2)));
                    },
                  );
                },
              ),
              title: Text('Details'),
              centerTitle: true,
            ),
      body:
          // _isLoading?
          //    Center(
          //      child: Container(

          //       // color: Colors.red,
          //                               child: Text(
          //                                 "Please wait to see details.... ",
          //                                 textAlign: TextAlign.left,
          //                                 style: TextStyle(
          //                                     color: appColor,
          //                                     fontFamily: "DINPro",
          //                                     fontSize: 15,
          //                                     fontWeight: FontWeight.w500),
          //                               ),
          //                             ),
          //    ):
          SafeArea(
            child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            //color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //////// Order Number/////////

                Container(
                  margin: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text( 
                          "Title         :       ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: appColor,
                              fontFamily: "DINPro",
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          //'gg',
                          widget.title == null ? '' :
                          "${widget.title}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: appColor,
                              fontFamily: "DINPro",
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[ 
                      Text(
                        "Message  :       ",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "DINPro",
                            fontSize: 15,
                            height: 1.5,
                            fontWeight: FontWeight.normal),
                      ),
                      Expanded(
                        child: Text(
                          //'ff',
                          widget.msg == null ? '' :
                          "${widget.msg}",
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: "DINPro",
                              fontSize: 14,
                              height: 2.0,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Text(
                //         "Service name    :    ",
                //         style: TextStyle(
                //             color: Colors.black54,
                //             fontFamily: "DINPro",
                //             fontSize: 14,
                //             height: 1.5,
                //             fontWeight: FontWeight.normal),
                //       ),
                //       Expanded(
                //         child: Text(
                //           //'ff',
                //           widget.msg == null ? '' :
                //           "${widget.msg}",
                //           style: TextStyle(
                //               color: Colors.black87,
                //               fontFamily: "DINPro",
                //               fontSize: 14,
                //               height: 1.5,
                //               fontWeight: FontWeight.normal),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
        ),
      ),
          ),
    )
    : bottomNavIndex == 1
            ? BottomNavigationPage(1)
            : bottomNavIndex == 3
                ? BottomNavigationPage(3)
                : bottomNavIndex == 0
                    ? BottomNavigationPage(0)
                    : BottomNavigationPage(4);
  }

  Future<bool> _onWillPop() async {
    Navigator.push(context,
        SlideLeftRoute(page: Notifications()));
    return false;
    // WillPopScope(
  //       onWillPop: _onWillPop,
  }
}
