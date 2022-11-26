import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miss_stitch/Api/registerApi.dart';
import 'package:miss_stitch/main.dart';
import 'package:miss_stitch/screens/Orders/AllOrders/ordersList.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/AllOrderModel/AllOrderModel.dart';


class OrdersHome extends StatefulWidget {
  // final statusF, date1, date2;
  // HomePage(this.statusF, this.date1, this.date2);
  @override
  _OrdersHomeState createState() => _OrdersHomeState();
}

class _OrdersHomeState extends State<OrdersHome> {
  TextEditingController searchController = TextEditingController();
  var userToken;
  bool isRefresh = false;

  bool _isLoading = true;
  var orderDetail;
  var body, bodySearch;
  var searchDetail = [], searchDetail2;
  String totalCost = '';
  String totalNumber = '';
  bool _isSearching = false;

  String statusSelect2 = '';
  String dateFr = '';
  String dateTo = '';

  var bodyStatus;
  List<String> status = ["Processing", "Dispatched", "Delivered"];
  List<String> statusForDate = ["Processing", "Dispatched", "Delivered"];
  // String _currentStatusSelected = '';
  var isStatus = true;

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();

  var _seqName = "Block";
  var _seqType = "";
  var _sendType = 'asc';
  //var _sort = ['Block', 'House', 'Road', 'Street', 'Area'];





  @override
  void initState() {
    //userInfo();
    /// _showOrderStatus();
    _showOrderDetails();

    // _currentStatusSelected = '';

    // print('searchDetail fggf');
    // print(searchDetail);

    // print('_isSearching');
    // print(_isSearching);

    // print('isSearching2');
    // print(isSearching2);

    // if (isSearching2 == true) {
    //   _showSearchStatus();
    // } else {
    //   _showOrderDetails();
    // }
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    //Scaffold.of(context).showSnackBar(snackBar);
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            //   title: new Text('Are you sure?'),
            content: new Text('Do you want to exit this App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'No',
                  style: TextStyle(color: appColor),
                ),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text(
                  'Yes',
                  style: TextStyle(color: appColor),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  // //////////////////////////////////// get status data start /////////////////
  // Future _getLocalOrderStatusData(key) async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var localorderStatusData = localStorage.getString(key);
  //   if (localorderStatusData != null) {
  //     bodyStatus = json.decode(localorderStatusData);
  //   }
  // }

  // void _orderStatusState() {
  //   // var orderStatus = OrderStatusModel.fromJson(bodyStatus);
  //   // // print("orderStatus");
  //   // // print(orderStatus);
  //   // if (!mounted) return;
  //   // setState(() {
  //   //   var statuses = orderStatus.status;
  //   //   // print("statuses");
  //   //   // print(statuses.length);
  //   //   for (int i = 0; i < statuses.length; i++) {
  //   //     status.add("${statuses[i].name}");
  //   //   }
  //   //   isStatus = false;
  //   // });

  //   // // print("status isssss");
  //   // // print(status.length);
  //   // // print(status);
  // }

  // Future<void> _showOrderStatus() async {
  //   // var key = 'order-status-list-sort';
  //   // await _getLocalOrderStatusData(key);

  //   // var res = await CallApi().getData('/app/showStatus');
  //   // // print(res);
  //   // bodyStatus = json.decode(res.body);
  //   // // print("bodyStatus");
  //   // // print(bodyStatus);
  //   // if (res.statusCode == 200) {
  //   //   _orderStatusState();

  //   //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   //   localStorage.setString(key, json.encode(bodyStatus));
  //   // }
  // }
  // ////////////////////////////////// get status data end /////////////////

  /////////// Refresh Method Start //////////////
  Future<void> _allData() async {
    print('searchDetail.length');
    print(isRefresh);
    /*if (isRefresh == true) {
      setState(() {
        _showSearchStatus();
      });
    } else {*/
    _showOrderDetails();

    ///}
  }
  /////////// Refresh Method End //////////////



  userInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    userToken = localStorage.getString('user[id]');
    // searchDetail2 = localStorage.getString('status-search-list');
    print(userToken);
  }

  //////////////////////////// get order data start ////////////////////////
  Future _getLocalOrderDetailsData(key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localorderDetailsData = localStorage.getString(key);
    if (localorderDetailsData != null) {
      body = json.decode(localorderDetailsData);
    }
  }

  void _orderDetailsState() {
    var orderDetails = AllOrderModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      orderDetail = orderDetails.data;
      print('orderDetail');
      print(orderDetail);
      _isLoading = false;
    });
  }

  Future<void> _showOrderDetails() async {
    var key = 'order-details-list';
    await _getLocalOrderDetailsData(key);

    var res;
    // _seqName != "" && _seqType != ""
    //     ? res = await CallApi().getData1(
    //         '/app/allTripOfMyStatus?status=$statusSelect2&order=$_seqName,$_seqType')
    //     :
    res = await CallApi().getData('/api/orders/all?type=Customer&customer_id=28');

    // var res = await CallApi().getData('/app/allTripOfMyStatus');
    print('response');
    print(res);
    body = json.decode(res.body);
    print('body');
    print(body);
    if (res.statusCode == 200) {
      _orderDetailsState();
      _isSearching = false;
      // _showOrderStatus();

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(key, json.encode(body));
      // print('orderDetail');
      // print(orderDetail);
    }
  }
  ////////////////////////////// get order data end ///////////////////////////


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: appColor,
          automaticallyImplyLeading: false,
          elevation: 2.9,
        centerTitle: true,
        titleSpacing: 2,
        title: Container(
          padding: const EdgeInsets.only(top: 0.0),
          child: const Text(
            'Orders',
            style: TextStyle(
                color: Colors.white, //(0XFF090909),
                fontSize: 18.0,
                fontFamily: 'Proxima Nova',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          ),
        ),

        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
              padding:
                  EdgeInsets.only(top: 15, bottom: 8.0, left: 2, right: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
              ),
              child: !_isSearching && orderDetail.length == 0
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 100,
                            height: 110,
                            decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new AssetImage(
                                      'assets/image/missStitch.png'),
                                ))),
                        Text(
                          "You have no assigned order",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: appColor,
                              fontFamily: "sourcesanspro",
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ))
                  // SingleChildScrollView(
                  //     physics: AlwaysScrollableScrollPhysics(),
                  //     child: Container(
                  //         height: MediaQuery.of(context).size.height,
                  //         alignment: Alignment.topCenter,
                  //         padding: EdgeInsets.only(top: 50),
                  //         child: Text(
                  //           'No Order Assigned !!',
                  //           style: TextStyle(fontSize: 16),
                  //         )),
                  //   )
                  : _isSearching && searchDetail.length == 0
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 100,
                                height: 110,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage(
                                          'assets/image/missStitch.png'),
                                    ))),
                            Text(
                              "No \" $statusSelect2 \" Order Found",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: appColor,
                                  fontFamily: "sourcesanspro",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ))

                      // SingleChildScrollView(
                      //         physics: AlwaysScrollableScrollPhysics(),
                      //         child: Container(
                      //             height: MediaQuery.of(context).size.height,
                      //             alignment: Alignment.topCenter,
                      //             padding: EdgeInsets.only(top: 50),
                      //             child: Text(
                      //               'No Order Found !!',
                      //               style: TextStyle(fontSize: 16),
                      //             )),
                      //       )
                      : RefreshIndicator(
                          onRefresh: _allData,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children:
                                      // [ OrdersPage(orderDetail),

                                      // ]
                                          _showOrdersList()),
                            ),
                          ),
                        ),

            ),

      ),
    );
  }

  List<Widget> _showOrdersList() {
    List<Widget> list = [];

    for (var d in orderDetail) {
      //   print(d.status);

      list.add(OrdersList(d));
    }

    return list;
  }
}
