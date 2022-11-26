import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:miss_stitch/screens/Orders/AllOrders/productDetails.dart';

import '../../../../main.dart';

class OrderDetail extends StatefulWidget {
  final status;
  final data;
  OrderDetail(this.data, this.status);
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  //var _status;
  var productDetails = [];
  @override
  void initState() {
    ///print(widget.data.order_details.length);
    // print('widget.data.street');
    // print(widget.data.street);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        automaticallyImplyLeading: true,
        elevation: 2.9,
        centerTitle: true,
        titleSpacing: 2,
        title: Container(
          padding: const EdgeInsets.only(top: 0.0),
          child: const Text(
            'Order Details',
            style: TextStyle(
                color: Colors.white, //(0XFF090909),
                fontSize: 18.0,
                fontFamily: 'Proxima Nova',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          // height: MediaQuery.of(context).size.height,
          //margin: EdgeInsets.only(top: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.fromLTRB(5, 20, 5, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
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
                    ////////////////////////////   Calling widgets start     //////////////////////
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildOrderIdWidget(),
                        SizedBox(height: 10),
                        _buildDateWidget("Order Date : ", widget.data.order_date == null ? "" : widget.data.order_date),
                        SizedBox(height: 5),
                        _buildDateWidget("Delivery Date : ", "${DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.data.updated_at))}"),
                        SizedBox(height: 5),
                        _buildStatusWidget(),
                        SizedBox(height:8),
                        // _buildDriverIdWidget(),
                        // SizedBox(height: 5),
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
                ///////   Product Details  Start ////////
                Divider(),
                // (widget.data.order_details.length == 0)? Container(child:Text('dd')) :
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
                   child:  ProductDetails(widget.data, widget.data.id , 'ii')
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: _showItems(),
                    // ),
                  ),
                ),
                ///////   Product Details  End ////////
              ],
            ),
            ////////////////////////////   Calling widgets end   //////////////////////
          ),
        ),
      ),
    );
  }

////////////////   Product List   //////////////
  List<Widget> _showItems() {
    ///print(widget.data.order_details);
    List<Widget> list = [];
    int i = 0;
    ///int len = 2;
    int len = widget.data.cloth.length;

    for (var d in widget.data.cloth // productDetails//
    ) {
      i++;
      list.add(ProductDetails(d, i, len));
    }
    

    return list;
  }

////////////////   Order Id    //////////////
  _buildOrderIdWidget() {
    return Container(
      child: Wrap(
        children: <Widget>[
          Text(
            "Order ID : ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          Text(
          // '1',
            widget.data.id == null ? "" : '${widget.data.id}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

////////////////   Order Date    //////////////
  _buildDateWidget(String dateName, String date) {
    return Container(
      child: Wrap(
        children: <Widget>[
          Text(
            dateName, 
            //"Date : ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold)),
          Text(
            date, //widget.data.date == null ? "" : widget.data.date,
            // "23-08-2022",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  color: Colors.black87,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

////////////////   Order Status    //////////////
  _buildStatusWidget() {
    return Container(
      child: Wrap(
        children: <Widget>[
          Text(
            "Order Status : ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: appColor,
                fontWeight: FontWeight.bold),
          ),
          Text(
           /// 'Pending',
           widget.data.order_status == null ? "" : widget.data.order_status,
            maxLines: 2,
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

////////////////   Driver Id    //////////////
  _buildDriverIdWidget() {
    return Container(
      child: Wrap(
        children: <Widget>[
          Text(
            "Driver Id : ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: appColor,
                fontWeight: FontWeight.bold),
          ),
          Text(
            '2', //widget.data.driverId == null ? "" : '${widget.data.driverId}',
            maxLines: 2,
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

  ///////////////////////////////////////  Customer Details  Widget Start   /////
  _buildCustomerDetailsWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Customer Info : ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: appColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // direction: Axis.vertical,
              // runSpacing: 5.0,
              // spacing: 4.0,
              children: <Widget>[
                 _buildCustomerIdWidget(),
                 SizedBox(height: 2),
                _buildCustomerNameWidget(),
                SizedBox(height: 2),
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
            widget.data.customer_id == null ? "" : '${widget.data.customer_id}',
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
              "Customer Name : ",
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
                fontSize: 15,
                fontFamily: 'Roboto',
                color: Colors.black87,
                fontWeight: FontWeight.w400),
          ),
          Text(
            widget.data.delivered_to_name == null ? "" : " " + widget.data.delivered_to_name,
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

////////////////   Customer Address    //////////////
  _buildAddressWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Address : ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: appColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Wrap(
              direction: Axis.vertical,
              runSpacing: 3.0,
              spacing: 3.0,
              children: <Widget>[
                getAddress(
                    'Area :  ', 
                    widget.data.delivered_to_area == null
                        ? "- - -"
                        : " " + widget.data.delivered_to_area
                        ),
                getAddress(
                    'House :  ', 
                    widget.data.delivered_to_house == null
                        ? "- - -"
                        : " " + widget.data.delivered_to_house
                        ),
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
                    widget.data.delivered_to_state == null
                        ? "- - -"
                        : " " + widget.data.delivered_to_state
                        ),
                getAddress(
                    'City :  ',
                    widget.data.delivered_to_city == null
                        ? "- - -"
                        : " " + widget.data.delivered_to_city
                        ),
                getAddress(
                    'Country :  ',
                    widget.data.delivered_to_country == null
                        ? "- - -"
                        : " " + widget.data.delivered_to_country
                        ),
                getAddress(
                    'Post Code :  ',
                    widget.data.delivered_to_post_code == null
                        ? "- - -"
                        : " " + widget.data.delivered_to_post_code
                        )
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
                fontSize: 15,
                fontFamily: 'Roboto',
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          Text(
            dataOfTitle, //"34",
            maxLines: 5,
            //overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15,
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
              "Mobile Number :  ",
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
           widget.data.delivered_to_phone == null ? "" : widget.data.delivered_to_phone,
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
                fontSize: 16,
                fontFamily: 'Roboto',
                color: appColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0, right: 10.0),
            child: Column(
              // direction: Axis.vertical,
              // runSpacing: 5.0,
              // spacing: 5.0,
              children: <Widget>[
                getCost(
                    "Payment Type : ", 'Card'
                    // widget.data.paymentType == null
                    //     ? "---"
                    //     : widget.data.paymentType
                        ),
                //SizedBox(height: 8.0,),
                getCost(
                    "Discount ", '0.00%'
                    // widget.data.discount == null
                    //     ? "0.00 %"
                    //     : '${widget.data.discount.toStringAsFixed(2)} %'
                        ),
                getCost(
                  "SubTotal ", 
                  //'15.50'
                  widget.data.cloth.price == null
                      ? "0.00 GBP"
                      : '${widget.data.cloth.price} GBP',
                  // widget.data.subTotal == null
                  //     ? ""
                  //     : '${widget.data.subTotal}'
                ),
                getCost(
                    "ShippingPrice ", '0.00'
                    // widget.data.shippingPrice == null
                    //     ? "0.00 BHD"
                    //     : '${widget.data.shippingPrice} BHD'
                        ),
                getGrandTotal(
                    "GrandTotal ",
                    //'18.50'
                    widget.data.cloth.price == null
                        ? "0.00 GBP"
                        : '${widget.data.cloth.price} GBP'
                        ),

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
////////////////////////////////////////////  Payment  Widget End   /////

}
