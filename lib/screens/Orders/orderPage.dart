import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:miss_stitch/Api/registerApi.dart';
import 'package:miss_stitch/main.dart';
import 'package:miss_stitch/screens/Orders/addAddress.dart';
import 'package:miss_stitch/screens/bottomNavigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routeTransition/routeTransition.dart';

class OrderPage extends StatefulWidget {
  //const OrderPage({Key? key}) : super(key: key);
  final productList;
  final data;
  final address;
  OrderPage(this.productList, this.data, this.address);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int up = 1;
  bool _isLoading = false;

  var userData;
  var userToken = '';
  var userId;
  var customerName;
  var mobileNumber;
  var grandTotal = 0;
  var price = 0;

  @override
  void initState() {
    print('productList');
    print(widget.productList);
    if (widget.productList.price == null) {
      price = 500;
      grandTotal = 30;
    } else {
      price = widget.productList.price;
      grandTotal = price + 30;
    }
    print(widget.data);
    print(widget.address);
    _getUserInfo();
    super.initState();
  }

  void increment() {
    setState(() {
      price = widget.productList.price;
      if (up >= 0 && up < 10) {
        up++;
        price = price * up;
        grandTotal = price + 30;
      }
    });
  }

  void decrement() {
    setState(() {
      price = widget.productList.price;
      if (up > 1) {
        up--;
        price = price * up;
        grandTotal = price + 30;
      }
    });
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
      //deviceId = userinfoList['device_id'];
      print('userData');
      print(userData);

      /// print('userToken');
      ///print(userToken);
    }
    userId = userData != null && userData['id'] != null
        ? '${userData['id']}'
        : '22';
    customerName = userData != null &&
            userData['fname'] != null &&
            userData['lname'] != null
        ? '${userData['fname']} ${userData['lname']}'
        : 'Name';
    // email.text = userData != null && userData['email'] != null
    //     ? '${userData['email']}'
    //     : 'Email';
    mobileNumber = userData != null && userData['mobile'] != null
        ? '${userData['mobile']}'
        : 'Mobile number';

    /// date = userData != null && userData['address'] != null
    ///     ? '${userData['address']}'
    ///     : '';

    /// _showImage = userData != null && userData['image'] != null
    ///     ? '${userData['image']}'
    ///     : '';
    // _showImage = null;
    ///print(_showImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          elevation: 1,
          centerTitle: true,
          leading: Container(
            padding: EdgeInsets.only(top: 5.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 26,
              ),
              color: Color(0XFF090909),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          titleSpacing: 2,
          title: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 0.0, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/blackLogoImg.png',
                  width: 40,
                  height: 40,
                  alignment: Alignment.topLeft,
                  fit: BoxFit.fitHeight,
                ),
                const Text(
                  'MissStitch',
                  style: TextStyle(
                      //fontFamily: 'Proxima Nova',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Container(
              child: Column(
                children: [
                  Card(
                    elevation: 3.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 5),
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
                      child: Column(
                        children: [
                          _buildProductWidget(),
                        ],
                      ),
                    ),
                  ),
                  ///////   Customer  Details  Start ////////
                  Divider(),
                  Card(
                    elevation: 3.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(15, 12, 15, 10),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildCustomerDetailsWidget(),
                          // _buildCustomerIdWidget(),
                          SizedBox(height: 8),
                          _buildAddressWidget(),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  ///////   Customer  Details  End ////////
                  ///////   Payment Details  Start ////////
                  Divider(),
                  Card(
                    elevation: 3.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 5),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildPaymentWidget(),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  ///////   Payment Details  End ////////
                  ///////////////// Place Order Button Start///////////////
                  Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, bottom: 20, top: 30),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 244, 173, 98),
                            width: 0.6),
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        color: Color.fromARGB(255, 244, 173, 98),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // if (selectedRadioTile == 0) {
                          //   return _showMessage('Please select one category');
                          // } else {
                          // Navigator.push(context,
                          //     SlideLeftRoute(page: ProductSellerForm(value)));
                          // }
                          _submitForm();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 2.0,
                          primary: Color(0xFFfae6d0),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                        ),
                        child: Text(
                          _isLoading ? "Please wait..." : "Confirm Order",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  ///////////////// Place Order Button End///////////////
                ],
              ),
            ),
          ),
        ));
  }

  _showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        //timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 15.0);
  }

  void _submitForm() async {
    //_showDialog();
    //Navigator.push(context, SlideLeftRoute(page: BottomNavigationPage(0)));
    if (widget.address['area'].isEmpty) {
      return _showMessage(
          'Delivery address field is empty, add delivery address');
    }
    // else if (placeController.text.isEmpty) {
    //   return _showMessage("Place field is empty");
    // }

    var data;

    data = {
      'cloth_id': widget.productList.id,
      'cloth_name': widget.productList.cloth_name,
      'tailor_id': '23',
      'customer_id': userId.toString(),
      'sleeves': widget.data['sleeves'].toString(),
      'type_of_sleeves': widget.data['typesOfSleeves'].toString(),
      'type_of_neck': widget.data['typesOfNeck'].toString(),
      'neck': widget.data['neck'].toString(),
      'waist': widget.data['waist'].toString(),
      'bust': widget.data['bust'].toString(),
      'length': widget.data['length'].toString(),
      'quantity': up.toString(),
      'delivered_to_name': customerName,
      'delivered_to_phone': mobileNumber.toString(),
      'delivered_to_area': widget.address['area'],
      'delivered_to_house': widget.address['house'],
      'delivered_to_city': widget.address['city'],
      'delivered_to_state': widget.address['state'],
      'delivered_to_post_code': widget.address['postCode'],
      'delivered_to_country': widget.address['country'],
      'order_status': 'Approved',
      'order_date':
          "${DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()}"
    };

    print(data);

    setState(() {
      _isLoading = true;
    });

    var res = await CallApi().postData(data, '/api/orders/create/new/order');
    print(res);
    var body = json.decode(res.body);
    print(body);

    if (res.statusCode == 200) {
      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('service', json.encode(body['user']));
      // localStorage.setString('deviceId', deviceId);

      // setState(() {
      //   // amountController.text = '';
      //   // timeName = '';
      //   reservationId = body['reservation']['id'];
      // });
      _showMessage("Your order is placed sucessfully!");
      Navigator.push(context, SlideLeftRoute(page: BottomNavigationPage(0)));
    } else {
      _showMessage("Something went wrong !!");
    }
    setState(() {
      _isLoading = false;
    });
  }

  _buildProductWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Product Details : ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: appColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                //'Product Id : 2',
                'Product No : ${widget.productList.id}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    color: Colors.black54,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                // height: 50,
                // width: 50,
                margin: EdgeInsets.only(right: 5.0, bottom: 2),
                child: ClipOval(
                    child: widget.productList.image == null
                        ? Image.asset(
                            'assets/image/dress2.png',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.productList.image,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 10.0),
            child: Column(
              children: <Widget>[
                // getProductInfo(
                //     "Product Id : ", '2'
                //     // widget.data.productId == null
                //     //     ? ""
                //     //     : '${widget.data.productId}'
                //         ),
                getProductInfo(
                    "Product Name : ",
                    //'Purple Dress'
                    widget.productList.cloth_name == null
                        ? ""
                        : '${widget.productList.cloth_name}'),
                getProductInfo("Sleeves : ", '19, Half Sleeves'
                    // widget.data.product.color == null
                    //     ? "---"
                    //     : '${widget.data.product.color}'
                    ),
                getProductInfo("Neck : ", '6, V-Shape Collor'
                    // widget.data.product.size == null
                    //     ? "---"
                    //     : '${widget.data.product.size}'
                    ),
                getProductInfo("Waist : ", '18'
                    // widget.data.product.warranty == null
                    //     ? "---"
                    //     : '${widget.data.product.warranty}'
                    ),
                getProductInfo("Bust : ", '15'
                    // widget.data.price == null
                    //     ? "0.00 BHD"
                    //     : '${widget.data.price} BHD'
                    ),
                getProductInfo("Length : ", '36'
                    // widget.data.price == null
                    //     ? "0.00 BHD"
                    //     : '${widget.data.price} BHD'
                    ),
                // getProductInfo(
                //     "Quantity : ",'3'
                //     // widget.data.quantity == null
                //     //     ? ""
                //     //     : '${widget.data.quantity}'
                //         ),
                getQuantity("Quantity : ", '1'
                    // widget.data.totalPrice == null
                    //     ? "0.00 BHD"
                    //     : '${widget.data.totalPrice} BHD'
                    ),

                SizedBox(
                  height: 5,
                ),
                // widget.data == widget.length
                //     ? Container()
                //     :
                // Padding(
                //     padding: const EdgeInsets.only(left: 20, top: 10),
                //     child: Divider(
                //       color: Colors.grey[350],
                //     ),
                //   )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container getProductInfo(String costTitle, String cost) {
    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            costTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 3.0),
              child: Text(
                cost,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container getQuantity(String costTitle, String cost) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              costTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(0, 0),
                    ),
                    onPressed: () {
                      increment();
                    },
                    child: const Icon(
                      Icons.add,
                      size: 18,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 10,
                    color: Colors.white,
                    child: Text(
                      '$up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(20, 20),
                    ),
                    onPressed: () {
                      decrement();
                    },
                    child: Text("-"))
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////  Customer Details  Widget Start   /////
  _buildCustomerDetailsWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Deliverd to : ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                color: appColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // direction: Axis.vertical,
              // runSpacing: 5.0,
              // spacing: 4.0,
              children: <Widget>[
                // _buildCustomerIdWidget(),
                SizedBox(height: 8),
                _buildCustomerNameWidget(),
                SizedBox(height: 8),
                _buildMobileNumberWidget(),
                // _buildAddressWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

////////////////   Customer Id    //////////////
  _buildCustomerIdWidget() {
    return Container(
      child: Wrap(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              "Customer Id : ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Text(
            '2', //widget.data.customerId == null ? "" : '${widget.data.customerId}',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto',
                color: Colors.black87,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

////////////////   Customer Name    //////////////
  _buildCustomerNameWidget() {
    return Container(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              "Name : ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Text(
            '', //widget.data.firstName == null ? "" : widget.data.firstName,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: Colors.black87,
                fontWeight: FontWeight.w400),
          ),
          Text(
            //'Sabiha Chy',
            customerName == null ? "" : " " + customerName,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: Colors.black87,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

////////////////   Customer Address    //////////////
  _buildAddressWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add delivery address : ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Roboto',
                    color: appColor,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        SlideLeftRoute(
                            page: AddAddressForm(
                                widget.productList, widget.data)));
                  },
                  style: ElevatedButton.styleFrom(),
                  child: Icon(Icons.note_alt_outlined))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Wrap(
              direction: Axis.vertical,
              runSpacing: 3.0,
              spacing: 5.0,
              children: <Widget>[
                getAddress(
                    'Area :  ',
                    //'- - -'
                    widget.address['area'] == null
                        ? "- - -"
                        : " ${widget.address['area']}"),
                getAddress(
                    'House :  ',
                    //'- - -'
                    widget.address['house'] == null
                        ? "- - -"
                        : " ${widget.address['house']}"),
                // getAddress(
                //     'Road :  ', '- - -'
                //     // widget.data.road == null
                //     //     ? "- - -"
                //     //     : " " + widget.data.road
                //         ),
                // getAddress(
                //     'Block :  ', '- - -'
                //     // widget.data.block == null
                //     //     ? "- - -"
                //     //     : " " + widget.data.block
                //         ),
                // getAddress(
                //     'Street :  ', '- - -'
                //     // widget.data.street == null
                //     //     ? "- - -"
                //     //     : " " + widget.data.street
                //         ),
                getAddress(
                    'State :  ',
                    // '- - -'
                    widget.address['state'] == null
                        ? "- - -"
                        : " ${widget.address['state']}"),
                getAddress(
                    'City :  ',
                    // '- - -'
                    widget.address['city'] == null
                        ? "- - -"
                        : " ${widget.address['city']}"),
                getAddress(
                    'Country :  ',
                    // '- - -'
                    widget.address['country'] == null
                        ? "- - -"
                        : " ${widget.address['country']}"),
                getAddress(
                    'Post Code :  ',
                    //'- - -'
                    widget.address['postCode'] == null
                        ? "- - -"
                        : " ${widget.address['postCode']}"),
                // getAddress(
                //     "",
                //     widget.data.house == null
                //         ? ""
                //         : widget.data.house +
                //             ', ' +
                //             widget.data.street +
                //             ', ' +
                //             widget.data.road +
                //             ', ' +
                //             '${widget.data.block}' +
                //             ', ' +
                //             widget.data.area +
                //             ', ' +
                //             widget.data.state
                //             ),
                // getAddress(
                //     "City :  ",
                //     widget.data.city == null
                //         ? ""
                //         : widget.data.city + ', ' + widget.data.country + '.'),
                // getAddress("House no: ", "34"),
                // getAddress("Road no: ", "34"),
                // getAddress("Block no: ", "34"),
                // getAddress("State no: ", "34"),
                // getAddress("Block no: ", "34"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container getAddress(String title, String dataOfTitle) {
    return Container(
      child: Wrap(
        children: <Widget>[
          Text(
            title, //"House no: ",
            maxLines: 1,
            //overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15.5,
                fontFamily: 'Roboto',
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          Text(
            dataOfTitle, //"34",
            maxLines: 5,
            //overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15.5,
                fontFamily: 'Roboto',
                color: Colors.black54,
                fontWeight: FontWeight.w400),
          ),
          // Text(
          //   ", ",
          //   maxLines: 1,
          //   style: TextStyle(
          //       fontSize: 15,
          //       fontFamily: 'Roboto',
          //       color: Colors.black87,
          //       fontWeight: FontWeight.w400),
          // ),
        ],
      ),
    );
  }

////////////////   Customer Phone Number    //////////////
  _buildMobileNumberWidget() {
    return Container(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              "Mobile :  ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Text(
            //'07723342455',
            mobileNumber == null ? "" : mobileNumber,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto',
                color: Colors.black87,
                fontWeight: FontWeight.w400),
          ),
          // Text(
          //   ',  001122334455',//widget.data.mobile2 == null ? "" : ", " + widget.data.mobile2,
          //   maxLines: 1,
          //   overflow: TextOverflow.ellipsis,
          //   style: TextStyle(
          //       fontSize: 15,
          //       fontFamily: 'Roboto',
          //       color: Colors.black87,
          //       fontWeight: FontWeight.w400),
          // ),
        ],
      ),
    );
  }
////////////////////////////////////////  Customer Details  Widget End   /////

///////////////////////////////////////////  Payment  Widget Start   /////
  _buildPaymentWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(3, 5, 3, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Payment : ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                color: appColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 10.0),
            child: Column(
              // direction: Axis.vertical,
              // runSpacing: 5.0,
              // spacing: 5.0,
              children: <Widget>[
                getCost("Payment Type : ", '---'
                    // widget.data.paymentType == null
                    //     ? "---"
                    //     : widget.data.paymentType
                    ),
                SizedBox(
                  height: 3.0,
                ),
                getCost("Discount ", '0.00%'
                    // widget.data.discount == null
                    //     ? "0.00 %"
                    //     : '${widget.data.discount.toStringAsFixed(2)} %'
                    ),
                SizedBox(
                  height: 3,
                ),
                getCost(
                  "SubTotal ",
                  //'15.50'
                  widget.productList.price == null ? "0.00 GBP" : '$price GBP',
                  // widget.data.subTotal == null
                  //     ? ""
                  //     : '${widget.data.subTotal}'
                ),
                SizedBox(
                  height: 3,
                ),
                getCost("ShippingPrice ", '30 GBP'
                    // widget.data.shippingPrice == null
                    //     ? "0.00 BHD"
                    //     : '${widget.data.shippingPrice} BHD'
                    ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 10),
                  child: Divider(
                    color: Colors.grey[600],
                  ),
                ),
                getGrandTotal(
                    "Total Price ",
                    //'18.50'
                    widget.productList.price == null
                        ? "18.50 GBP"
                        : '$grandTotal GBP')

                // SizedBox(height: 12,),
                // getGrandTotal("Payment Type ", widget.data.paymentType == null? "" : widget.data.paymentType),
                //_buildPaymentTypeWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container getCost(String costTitle, String cost) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            costTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(
                cost,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container getGrandTotal(String costTitle, String cost) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              costTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Flexible(
            child: Text(
              cost,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
//////////////////  Payment  Widget End   /////////////////

///// Success dialog Start ////
  void _showDialog() {
    showDialog(
        context: context,
        builder: (_) => Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  // height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 40, bottom: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0XFFF8F8F8),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Color(0XFF7176C2).withOpacity(0.16),
                          offset: Offset(6.0, 7.0),
                        ),
                      ]),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
                            child: Text(
                              "Your order has been placed successfully !",
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Color(0XFF0A0A0A),
                                fontSize: 18.0,
                                decoration: TextDecoration.none,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      //     ),
                      //   ],
                      // ),

                      ///////////////// OK Button  Start///////////////
                      Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(
                            left: 0,
                            right: 85,
                            bottom: 20,
                            top: 15,
                          ),
                          //width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationPage(0)));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 2.0, shadowColor: appColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              primary: appColor, // Background color
                            ),
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                color: Color(0XFFFFFFFF),
                                fontSize: 18.0,
                                decoration: TextDecoration.none,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                      ///////////////// OK Button  End///////////////
                    ],
                  ),
                ),
              ),
              //   );
              // },
            ));
  }
  //// Success dialog End /////

}
