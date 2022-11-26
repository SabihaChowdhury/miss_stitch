import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miss_stitch/main.dart';
import 'package:miss_stitch/routeTransition/routeTransition.dart';
import 'package:miss_stitch/screens/Home/outfit.dart';

import 'outfitFromTailor.dart';

class PopularServiceCard extends StatefulWidget {
  final serviceList;
  PopularServiceCard(this.serviceList);
  @override
  _PopularServiceCardState createState() => _PopularServiceCardState();
}

class _PopularServiceCardState extends State<PopularServiceCard> {
  List<String> images = [];
  var image;
  bool _isLoading = false;

  @override
  void initState() {
    //imageList();
    super.initState();
  }

  imageList() {
    for (int i = 0; i < widget.serviceList.images.length; i++) {
      images.add("${widget.serviceList.images[i].image}");
      image = "${widget.serviceList.images[0].image}";
    }
    print('images');
    //print(image);
    print(images.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6)),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Color(0XFF000000).withOpacity(0.16),
              //offset: Offset(6.0, 7.0),
            ),
          ]),
      width: MediaQuery.of(context).size.width / 2 - 30,
      child: GestureDetector(
        onLongPress: () {
          print("object");
          // _showpop();
        },
        onTap: () {
          ///   _addView();
          Navigator.push(context, SlideLeftRoute(page: Outfit()));
          //   Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => PopularServiceDetails(widget.serviceList,null)),
          // );
          // if(widget.serviceList.view == 1)
          // {
          //   Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => PopularServiceDetails(widget.serviceList)),
          // );
          // } else {  _addView(); }
        },
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child:

                              /// image == null?
                              Image.asset(
                            'assets/image/camera.png',
                            width: 100,
                            height:
                                MediaQuery.of(context).size.height / 9, // 130,
                            fit: BoxFit.contain,
                          )
                          /*  :
                        Image.network(
                              '$image',//'${CallApi().getUrl()+image}',
                              width: 230,
                              height: MediaQuery.of(context).size.height / 5.5,//130,
                              fit: BoxFit.cover,
                            ),*/
                          ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                           widget.serviceList.fname == null && widget.serviceList.lname == null?
                          'Kelvin'
                          : '${widget.serviceList.fname} ${widget.serviceList.lname}', //'Kelvin',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Proxima Nova',
                              color: Color(0XFF373740),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                     widget.serviceList.address == null || widget.serviceList.address == 'address'?
                    'Sawston, Cambridge'
                    : '${widget.serviceList.address}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Proxima Nova',
                        color: appColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /*void _addView() async {

    if(widget.serviceList == null) {
      return _showMessage('Details are loading......');
    }

    var data = {
      'id': widget.serviceList.id,
    };
    print(data);
    setState(() {
      _isLoading = true;
    });

    print(data);

    var res = await CallApi().postData1(data, '/app/addNewViewToService');
    print(res);
    var body = json.decode(res.body);
    print(body);

    // setState(() {
    //   regData = res.body;
    // });

    if (res.statusCode == 200) {
      print('pressed view');
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PopularServiceDetails(widget.serviceList,null)),
          );
    } else {
      print(res.statusCode);
      //_showMessage("Something went wrong !!");
    }
    setState(() {
      _isLoading = false;
    });
  }

  _showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: appColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
  }*/
}

// child: ListTile(
//           contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//           title: Container(
//             width: MediaQuery.of(context).size.width / 2 - 30,
//             child: Stack(
//               children: <Widget>[
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       height: 80,
//                       alignment: Alignment.center,
//                       width: MediaQuery.of(context).size.width / 2 - 35,
//                       child: Image.asset(
//                         'assets/image/introbg.png',
//                         height: 80,
//                         width: 80,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                     Container(
//                       /// color: Colors.red,
//                       //padding: EdgeInsets.only(left: 15, right: 15),
//                       width: MediaQuery.of(context).size.width / 2 - 35,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Container(
//                             padding: EdgeInsets.only(top: 8),
//                             child: Text(
//                               "Product Name",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontFamily: 'Roboto',
//                                   color: Colors.black87,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             margin: EdgeInsets.only(top: 8, left: 0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     margin: EdgeInsets.only(
//                                         right: 0, top: 0, bottom: 10),
//                                     child: Text("USD 300.00",
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             fontFamily: 'Roboto',
//                                             color: appColor,
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
