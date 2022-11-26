import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../main.dart';

class SearchCard extends StatefulWidget {
  final productList;
  SearchCard(this.productList);
  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  List<String> images = [];
  var image;
  bool _isLoading = false;

  @override
  void initState() {
    imageList();
    super.initState();
  }

  imageList() {
    for (int i = 0; i < widget.productList.images.length; i++) {
      images.add("${widget.productList.images[i].image}");
      image = "${widget.productList.images[0].image}";
    }
    print('images');
    print(image);
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
        // onLongPress: () {
        //   print("object");
        //   // _showpop();
        // },
        onTap: () {
          _addView();
          // setState(() {
          //   // isSearch = false;
          //   // print('is that $isSearch');
          // });
        },
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: 
                      widget.productList.images == null || widget.productList.images.length == 0?
                      Image.asset(
                        'assets/image/photo_placeholder.png',
                        width: 230,
                        height: MediaQuery.of(context).size.height / 5.5,//130,
                        fit: BoxFit.contain,
                      )
                      :
                      Image.network(
                              '${widget.productList.images[0].image}',//'${CallApi().getUrl()}${widget.productList.images[0].image}',
                              width: 230,
                              height: MediaQuery.of(context).size.height / 5.5,//130,
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
                    margin: EdgeInsets.only(top: 12, left: 0, bottom: 0),
                    child: Text(
                      widget.productList.name == null? '---' : '${widget.productList.name}',//'Checked Shirt',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
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
                    margin: EdgeInsets.only(top: 8, left: 0),
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'From XAF',
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Proxima Nova',
                              color: appColor,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          widget.productList.price == null? ' ---' : ' ${widget.productList.price}',//' \$452',
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
void _addView() async {

  /*  var data = {
      'id': widget.productList.id,
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
      if(widget.productList.service_type == 'service')
          {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PopularServiceDetails(widget.productList,null)),
          );
      } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PopularProductDetails(widget.productList,null)),
          );
    }
    } else {
      print(res.statusCode);
      //_showMessage("Something went wrong !!");
    }
    setState(() {
      _isLoading = false;
    });*/
  }
}
