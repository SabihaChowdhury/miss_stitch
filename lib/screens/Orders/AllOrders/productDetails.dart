import 'package:flutter/material.dart';

import '../../../main.dart';

class ProductDetails extends StatefulWidget {
  final data, length, ii;
  ProductDetails(this.data, this.length, this.ii);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //width: MediaQuery.of(context).size.width / 2 - 30,
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => OrderDetail(widget.index)),
          // );
        },
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          title: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildProductWidget(),
              ],
            ),
          ),
        ),
      ),
    );
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
            children: <Widget>[
              Text(
               //'Product No : 2', 
               'Product No : ${widget.length}',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                // height: 50,
                // width: 50,
                margin: EdgeInsets.only(right: 5.0, bottom: 2),
                child: ClipOval(
                    child: 
                    widget.length == 0
                        ? 
                        Image.asset(
                            'assets/image/dress2.png',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.data.cloth.image,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                          ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0, right: 10.0),
            child: Column(
              children: <Widget>[
                getProductInfo(
                    "Product Id : ",
                    // '2'
                    widget.data.cloth_id == null
                        ? ""
                        : '${widget.data.cloth_id}'
                        ),
                getProductInfo(
                    "Product Name : ", 
                    //'Purple Gown'
                    widget.data.cloth_name == null
                        ? ""
                        : '${widget.data.cloth_name}'
                        ),
                // getProductInfo(
                //     "Color : ",'green'
                //     // widget.data.product.color == null
                //     //     ? "---"
                //     //     : '${widget.data.product.color}'
                //         ),
                // getProductInfo(
                //     "Size : ",'40'
                //     // widget.data.product.size == null
                //     //     ? "---"
                //     //     : '${widget.data.product.size}'
                //         ),
                // getProductInfo(
                //     "Warranty : ",'ee'
                //     // widget.data.product.warranty == null
                //     //     ? "---"
                //     //     : '${widget.data.product.warranty}'
                //         ),
                getProductInfo(
                    "Price : ",
                    //'15.50'
                    widget.data.cloth.price == null
                        ? "0.00 GBP"
                        : '${widget.data.cloth.price} GBP'
                        ),
                getProductInfo(
                    "Quantity : ",'1'
                    // widget.data.quantity == null
                    //     ? ""
                    //     : '${widget.data.quantity}'
                        ),
                getProductInfo(
                    "Note : ",'- - -'
                    // widget.data.quantity == null
                    //     ? ""
                    //     : '${widget.data.quantity}'
                        ),
                getTotalPrice(
                    "Total Price : ",
                    //'15.50'
                    widget.data.cloth.price == null
                        ? "0.00 GBP"
                        : '${widget.data.cloth.price} GBP'
                        ),
                SizedBox(
                  height: 5,
                ),
                // widget.data == widget.length
                //     ? Container()
                //     : 
                    Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Divider(
                          color: Colors.grey[350],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container getProductInfo(String costTitle, String cost) {
    return Container(
      padding: EdgeInsets.only(top: 3, bottom : 3),
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

  Container getTotalPrice(String costTitle, String cost) {
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
}
