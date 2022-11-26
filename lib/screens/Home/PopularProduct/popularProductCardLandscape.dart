import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:miss_stitch/routeTransition/routeTransition.dart';
import 'package:miss_stitch/screens/Home/outfit.dart';

import '../../../main.dart';

class PopularProductCardLandscape extends StatefulWidget {
  final productList;
  PopularProductCardLandscape(this.productList);
  @override
  _PopularProductCardLandscapeState createState() =>
      _PopularProductCardLandscapeState();
}

class _PopularProductCardLandscapeState
    extends State<PopularProductCardLandscape> {
  List<String> images = [];
  var image;
  bool _isLoading = false;

  @override
  void initState() {
    // imageList();
    super.initState();
  }

  imageList() {
    for (int i = 0; i < widget.productList.images.length; i++) {
      images.add("${widget.productList.images[i].image}");
      image = "${widget.productList.images[0].image}";
    }
    print('images');
    //print(images);
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
      width: MediaQuery.of(context).size.width / 3 - 40,
      child: GestureDetector(
        onLongPress: () {
          print("object");
          // _showpop();
        },
        onTap: () {
          ///  _addView();
          /// Navigator.push(context, SlideLeftRoute(page: Outfit()));
          // Navigator.push(
          //   context,
          // MaterialPageRoute(builder: (context) => PopularProductDetails(widget.productList,null)),
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => PopularProductDetails(widget.productList)),
          // );
        },
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: widget.productList.image == null
                          ? Image.asset(
                              'assets/image/purple_dress.png',
                              width: 230,
                              height:
                                  MediaQuery.of(context).size.height / 3, //130,
                              fit: BoxFit.contain,
                            )
                          : Image.network(
                              '${widget.productList.image}', //'${CallApi().getUrl()+image}',
                              width: 230,
                              height:
                                  MediaQuery.of(context).size.height / 3, //130,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                ),

                // ListView.builder(
                //             physics: BouncingScrollPhysics(),
                //             scrollDirection: Axis.horizontal,
                //             //shrinkWrap: true,
                //             itemBuilder: (BuildContext context, int index) =>
                //                 GestureDetector(
                //                     onTap: () {
                //                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                //                           return PreviewImage(photos[index]);
                //                         }));
                //                      // Navigator.push(context,
                //                          // SlideLeftRoute(page: PreviewVideo(photos[index])));
                //                         },
                //                   child: Container(
                //                       margin: EdgeInsets.only(left: 12),
                //                       child: Image.network(
                //                         photos[index],
                //                         height: 50,
                //                         width: 100,
                //                         fit: BoxFit.cover,
                //                       )),
                //                 ),
                //             itemCount: photos.length,
                //           )
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 5, left: 0),
                    child:  Text(
                       widget.productList.cloth_name == null? '---' 
                       : '${widget.productList.cloth_name}',
                      //'Checked Shirt',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Proxima Nova',
                          color: Color(0XFF373740),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 2, left: 0),
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Price: ',
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Proxima Nova',
                              color: appColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                        widget.productList.price == null? ' ---' : ' £${widget.productList.price}',
                          //' £452',
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Proxima Nova',
                              color: appColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // void _addView() async {
  //   if(widget.productList == null) {
  //     return _showMessage('Details are loading......');
  //   }

  //   var data = {
  //     'id': widget.productList.id,
  //   };
  //   print(data);
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   print(data);

  //   var res = await CallApi().postData1(data, '/app/addNewViewToService');
  //   print(res);
  //   var body = json.decode(res.body);
  //   print(body);

  //   // setState(() {
  //   //   regData = res.body;
  //   // });

  //   if (res.statusCode == 200) {
  //     Navigator.push(
  //           context,
  //     MaterialPageRoute(builder: (context) => PopularProductDetails(widget.productList,null)),
  //         );
  //   } else {
  //     print(res.statusCode);
  //     _showMessage("Something went wrong !!");
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // _showMessage(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: appColor.withOpacity(0.9),
  //       textColor: Colors.white,
  //       fontSize: 13.0);
  // }
}
