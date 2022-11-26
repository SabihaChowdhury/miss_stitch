import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../keyValueModel.dart';
import 'ordersDetails.dart';

get_list_status() {
  List<KeyValueModel> datas = [
    KeyValueModel(key: "Processing", value: "Value 1"),
    KeyValueModel(key: "Dispatched", value: "Value 2"),
    KeyValueModel(key: "Delivered", value: "Value 3"),
  ];
  return datas;
}

class OrdersList extends StatefulWidget {
  final index;
  OrdersList(this.index);
  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  ////////////////////////   Date Picker   //////////////////
  // String t = "text";
  DateTime selectedDate = DateTime.now();
  final f = new DateFormat('yyyy-MM-dd');
  String date =
      ''; //DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
      String statusDate = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1964, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = "${DateFormat("yyyy-MM-dd").format(selectedDate)}";
        Navigator.pop(context);
        /// _showDialog(context);
        // date == ''? null : _onStatusPostponed();
      });
    }
  }



  var update = '';

  String _currentStatusSelected = '';
  bool _isLoading = false;
  var userToken;
  var driverId;
  var id;
  var orderDetail;
  var body, body1;
  List<String> status = [];

  String categoryName = "";
  var categoryId = "";
  // var userId;
  // var customerId;
  // var categorysData;
  late KeyValueModel categoryModel;
  List<KeyValueModel> categoryList = <KeyValueModel>[];

  List<KeyValueModel> _status = <KeyValueModel>[];
  String timeName = "";
  var timeId = "";
  List listan = get_list_status();
  String currentStatusSelected = '';


  @override
  void initState() {
    userInfo();
    // id = widget.index.id;
    // categoryName = '';
    // print(_isLoading);

    for (int i = 0; i < listan.length; i++) {
      _status.add(
          KeyValueModel(key: "${listan[i].key}", value: "${listan[i].value}"));
    }
   /// _showOrderStatusForChange();
    super.initState();
  }

  userInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    userToken = localStorage.getString('token');
    // print("userToken");
    // print(userToken);
  }

  ////////////////////////// get status data start //////////////////

  Future _getLocalOrderStatusDataForChange(key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localorderStatusData = localStorage.getString(key);
    if (localorderStatusData != null) {
      body1 = json.decode(localorderStatusData);
    }
  }

  void _orderStatusStateForChange() {
    // var orderStatus = OrderStatusModel.fromJson(body1);
    // // print("orderStatus");
    // // print(orderStatus);
    // if (!mounted) return;
    // setState(() {
    //   var statuses = orderStatus.status;
    //   // print("statuses");
    //   // print(statuses.length);
    //   for (int i = 0; i < statuses.length; i++) {
    //     //_status.add(statuses[i].name);
    //     categoryList.add(KeyValueModel(
    //         key: "${statuses[i].name}", value: "${statuses[i].id}"));
    //     // print(statuses[i].name);
    //   }
    //   _isLoading = false;
    // });

    // // print("status isssss");
    // // print(categoryList.length);
  }

  Future<void> _showOrderStatusForChange() async {
    // var key = 'order-status-list-forchange';
    // await _getLocalOrderStatusDataForChange(key);

    // var res = await CallApi().getData('/app/showStatusForDriver');
    // // print(res);
    // body1 = json.decode(res.body);
    // // print("body1");
    // // print(body1);
    // if (res.statusCode == 200) {
    //   _orderStatusStateForChange();

    //   SharedPreferences localStorage = await SharedPreferences.getInstance();
    //   localStorage.setString(key, json.encode(body1));
    // }
  }
  //////////////////////////// get status data end //////////////////////////

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
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderDetail(widget.index, categoryName)
                  //OrderDetail(widget.index, categoryName)
                  ),
            );
          },
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            title: Stack(
              children: <Widget>[
                Card(
                  elevation: 1.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.5,
                          color: Color(0XFF377FA8).withOpacity(0.5),
                          //offset: Offset(6.0, 7.0),
                        ),
                      ],
                    ),
                    //height: 150,
                    width: MediaQuery.of(context).size.width / 1,
                    padding: EdgeInsets.fromLTRB(20, 20, 8, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _buildOrderIdWidget(),
                        SizedBox(height: 8),
                        _buildDateWidget(),
                        SizedBox(height: 8),
                        _buildMobileNumberWidget(),
                        SizedBox(height: 8),
                        _buildStatusWidget(),
                        SizedBox(height: 8),
                        _buildStatusDateWidget(),
                        SizedBox(height: 8),
                        _buildBlockWidget(),
                        SizedBox(height: 8),
                        _buildTotalPriceWidget(),
                        SizedBox(height: 5),
                        // _buildNoteWidget(),
                        // SizedBox(height: 0),
                       /// _buildChangeStatusWidget(),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildOrderIdWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  "Order no",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Roboto',
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    ": ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        color: appColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  widget.index.id == null
                      ? "- - -"
                      : '${widget.index.id}',
                 // "# 1",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
       
        ],
      ),
    );
  }

  _buildDateWidget() {
    return Container(
      //color: Colors.red,
      child: Row(
        children: <Widget>[
          Text("Order Date",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              ": ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
              widget.index.order_date == null
                  ? "- - -"
                  : widget.index.order_date,
              //"23-08-2022",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  _buildStatusDateWidget() {
    return Container(
      child: Row(
        children: <Widget>[
          Text("Status Date",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              ": ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
              widget.index.updated_at == null
                  ? "- - -"
                  //: widget.index.updated_at,
                 : DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.index.updated_at)),
              //"23-08-2022",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  _buildNoteWidget() {
    return Container(
      child: Row(
        children: <Widget>[
          Text("Note",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              ": ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
              // widget.index.note == null
              //     ? "- - -"
              //     : widget.index.note,
              "23-08-2022",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

//////////////   Customer Phone Number    //////////////
  _buildMobileNumberWidget() {
    return Container(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              "Mobile Number :  ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            //'07763496992',

            widget.index.delivered_to_phone == null ? 
            "- - -" : widget.index.delivered_to_phone,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto',
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),
          const Text(
            '',
           //  widget.index.delivered_to_phone == null ? "" : ", " + widget.index.delivered_to_phone,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto',
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  _buildBlockWidget() {
    return Container(
      child: Row(
        children: <Widget>[
          Text("Post Code",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              ": ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
              widget.index.delivered_to_post_code == null
                  ? "- - -"
                  : " " + widget.index.delivered_to_post_code,
              ///"CB22 3BU",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  _buildTotalPriceWidget() {
    return Container(
      child: Row(
        children: <Widget>[
          Text("Total Price",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              ": ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
              widget.index.cloth.price == null
                  ? "0.00 GBP"
                  : '${widget.index.cloth.price} GBP',
              //"18.50",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  _buildStatusWidget() {
    return Container(
      child: Wrap(
        children: <Widget>[
          Text("Order Status  :  ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold)),
          Text(
              // d.status==null?"---":'Order Status is '+d.status.toString(),
              // style: TextStyle(
              //                              color: Color(0xFF343434),
              //                              fontFamily: "sourcesanspro",
              //                              fontSize: 14,
              //                              fontWeight: FontWeight.normal),
              //'Pending', 
              widget.index.order_status == null ? "" : widget.index.order_status,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: Colors.black87,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }


}
