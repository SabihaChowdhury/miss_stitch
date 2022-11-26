import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:miss_stitch/main.dart';
import 'package:miss_stitch/routeTransition/routeTransition.dart';
import 'package:miss_stitch/screens/Orders/measurementsTaking.dart';
import 'package:miss_stitch/screens/bottomNavigation.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class PopularProductDetails extends StatefulWidget {
  final productList;
  final productId;
  PopularProductDetails(this.productList, this.productId);
  @override
  _PopularProductDetailsState createState() => _PopularProductDetailsState();
}

class _PopularProductDetailsState extends State<PopularProductDetails> {
  TextEditingController reviewController = TextEditingController();
  bool _isLoading = false;
  var rating = 0.0;

  int _current = 0;
  List imgList = ['1', '2', '3'];
  int _selectedIndex = bottomNavIndex;

  var id = '0', id2 = '1', id3 = '2', id4 = '3', id5 = '4', ind = '5';

  List<String> images = [
    'assets/image/purple_dress.png',
    'Purple dress',
    'assets/image/purple_dress.png'
  ];
  var image;

  bool _isLoggedIn = false;
  var userData;
  var userId;
  var sellerFirstName, sellerLastName, sellerFullName, sellerId;
  var body, conversationList, conversationId = '0';
  var getMoreStuffBody, getMoreStuffList, getAllMsg = "";
  var productBody, productList, productMsg = '';
  bool noMoreStuff = false;

  List<String> reviews = [];
  var review;
  List newReviews = [];
  bool noData = false;
  bool newReview = false;

  @override
  void initState() {
    bottomNavIndex = 0;
    //_selectedIndex = bottomNavIndex;
    /* imageList();
    reviewList();

    getConversationId();
    getMoreStuffData();
    //if( widget.productId != null) {
      //getProductData();
   // }
    _checkIfLoggedIn();
    sellerFirstName = widget.productList.users.firstName != null || widget.productList.users.firstName != ''
        ? '${widget.productList.users.firstName}'
        : '';
    sellerLastName = widget.productList.users.lastName != null || widget.productList.users.lastName != ''
        ? '${widget.productList.users.lastName}'
        : '';
    // sellerFullName = widget.productList.users.firstName != null
    //     ? '${widget.productList.users.firstName[0].toUpperCase() + widget.productList.users.firstName.substring(1)} ${widget.productList.users.lastName[0].toUpperCase() + widget.productList.users.lastName.substring(1)}'
    //     : '';
    sellerId =
        widget.productList.users.id != null ? widget.productList.users.id : ''; */
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      //_selectedIndex = index;
      bottomNavIndex = index;
    });
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

  reviewList() {
    for (int i = 0; i < widget.productList.reviews.length; i++) {
      reviews.add("${widget.productList.reviews[i].review}");
      // review = "${widget.productList.reviews[0].review}";
    }
    print('reviews');
    // print(review);
    print(reviews.length);
  }

  // void _getUserInfo() async {
  //   // setState(() {
  //   //  isLoading = true;
  //   // });
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var userJson = localStorage.getString('user');
  //   var user = json.decode(userJson);
  //   setState(() {
  //     userData = user;

  //     //isLoading = false;
  //   });
  //   userId = int.parse('${userData['id']}');
  //   print("ssfdfdgdfgbv dfh");
  //   print("${userData['id']}");
  //   print(userId);
  //   print(sellerId);
  // }

  // void _checkIfLoggedIn() async {
  //   // check if token is there
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var token = localStorage.getString('token');
  //   if (token != null) {
  //     setState(() {
  //       _isLoggedIn = true;
  //     });
  //   }
  //   if (_isLoggedIn == true) {
  //     _getUserInfo();
  //   }
  // }

  ////////////// get Conversation api ////////////
  // Future<void> getConversationId() async {
  //   var res = await CallApi()
  //       .getData('/app/getCoversationWithSeller/${widget.productList.id}');
  //   body = json.decode(res.body);
  //   //print(body);
  //   print(res.statusCode);

  //   if (res.statusCode == 200) {
  //     var convcontent = res.body;
  //     final conv = json.decode(convcontent);
  //     print(conv);

  //     var convdata = GetConversationIdModel.fromJson(conv);
  //     conversationList = convdata.conv;

  //     if (conversationList != null) {
  //       setState(() {
  //         conversationId = conversationList.id.toString();
  //         //  var spDate = dd.split(" ");
  //         //  alertDate = spDate[0];
  //         // situation = conversationList.situation;
  //         print('conversationList');
  //         print(conversationId);
  //         print(conversationList);
  //       });
  //       //print(conv);
  //     } else {
  //       setState(() {
  //         conversationId = '0';
  //       });
  //     }

  //     print("conversationList.length");
  //     print(conversationList);
  //   }
  // }

  // ////////////// get MoreStuff api ////////////
  // Future _getLocalMoreStuffData(key) async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var localmoreStuffData = localStorage.getString(key);
  //   if (localmoreStuffData != null) {
  //     getMoreStuffBody = json.decode(localmoreStuffData);
  //     print('dmjsvgd hdsftrstfgdhjs');
  //     print(getMoreStuffBody);
  //     _allMoreStuffState();
  //   }
  // }

  // void _allMoreStuffState() {
  //   print('sjshdvchbd');
  //   print(getMoreStuffBody);
  //   if(getMoreStuffBody != null) {
  //     print('issue with model');
  //     //var getAlldata = AllServiceModel.fromJson(getMoreStuffBody);
  //     final getAll = json.decode(getMoreStuffBody);
  //     print(getAll);

  //     var getAlldata = AllServiceModel.fromJson(getAll);
  //     //getMoreStuffList = getAlldata.service;
  //   if (!mounted) return;
  //   setState(() {
  //     getMoreStuffList = getAlldata.service;
  //     if (getMoreStuffList.length != 0) {
  //       if (getMoreStuffList.length <= 1) {
  //           noMoreStuff = true;

  //           // print('skldhdsghfvdbnfaklskdj $dd');
  //           //  var spDate = dd.split(" ");
  //           //  alertDate = spDate[0];
  //           // situation = getMoreStuffList.situation;
  //           //  _searchShop();
  //           // isSearch = true;
  //           // noSearchData = false;

  //       } else {
  //           noMoreStuff = false;
  //       }
  //       print(getAll);
  //     }
  //   });
  //   }
  // }

  // Future<void> getMoreStuffData() async {
  //   var keyMoreStuff = 'more-stuff-list';
  //   await _getLocalMoreStuffData(keyMoreStuff);

  //   var res = await CallApi()
  //       .getData('/app/moreServiceofaseller/${widget.productList.seller_id}');
  //   getMoreStuffBody = json.decode(res.body);
  //   print(getMoreStuffBody);
  //   print(res.statusCode);

  //   if (res.statusCode == 200) {
  //     var getAllcontent = res.body;
  //     final getAll = json.decode(getAllcontent);
  //     print(getAll);

  //     var getAlldata = AllServiceModel.fromJson(getAll);
  //     getMoreStuffList = getAlldata.service;

  //     if (getMoreStuffList.length != 0) {
  //       if (getMoreStuffList.length <= 1) {
  //         if (!mounted) return;
  //         setState(() {
  //           noMoreStuff = true;

  //           // print('skldhdsghfvdbnfaklskdj $dd');
  //           //  var spDate = dd.split(" ");
  //           //  alertDate = spDate[0];
  //           // situation = getMoreStuffList.situation;
  //           //  _searchShop();
  //           // isSearch = true;
  //           // noSearchData = false;
  //           print('getMoreStuffList');
  //           print(getMoreStuffList);
  //         });
  //       } else {
  //         setState(() {
  //           noMoreStuff = false;
  //         });
  //       }
  //       print(getAll);
  //     } else {
  //       setState(() {
  //         // isSearch = true;
  //         // noSearchData = true;
  //         getAllMsg = "No data available!";
  //         // print('dhjc fdgf gddhhjd $noSearchData');
  //       });
  //     }

  //     print("getMoreStuffList.length");
  //     print(getMoreStuffList.length);
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     localStorage.setString(keyMoreStuff, json.encode(getAllcontent));
  //   }
  // }

  //  ////////////// get Product api ////////////
  // Future<void> getProductData() async {
  //   var res = await CallApi()
  //       .getData('/app/getAllProductById/${widget.productList.id}');
  //   productBody = json.decode(res.body);
  //   print(productBody);
  //   print(res.statusCode);

  //   if (res.statusCode == 200) {
  //     var productcontent = res.body;
  //     final product = json.decode(productcontent);
  //     print(product);

  //     var productdata = GetProductByIdModel.fromJson(product);
  //     productList = productdata.product.reviews;
  //     print(productList);

  //     if (productList != null) {
  //         setState(() {
  //           productList = productdata.product.reviews;

  //     if (productList.length == 0) {
  //       noData = true;
  //     } else{
  //       newReview = true;
  //     }

  //   });
  //       print(newReviews);
  //     } else {
  //       setState(() {
  //         productMsg = "No data available!";
  //         // print('dhjc fdgf gddhhjd $noSearchData');
  //       });
  //     }

  //     // print("productList.length");
  //     // print(productList.length);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return bottomNavIndex == 0
        ? Scaffold(
            extendBodyBehindAppBar: true,
            floatingActionButton: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 65),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.extended(
                      isExtended: true,
                      heroTag: "btn2",
                      elevation: 12,
                      onPressed: () {
                        Navigator.push(context,
                            SlideLeftRoute(page: MeasurementsTakingForm(widget.productList)));
                        // if (_isLoggedIn == true) {
                        //   if (userId == sellerId) {
                        //     return _showMessage('This is your own product');
                        //   } else {
                        //     Navigator.push(
                        //         context,
                        //         SlideLeftRoute(
                        //             page: ChattingPage(
                        //                 sellerFirstName,
                        //                 sellerLastName,
                        //                 conversationId,
                        //                 userId,
                        //                 sellerId,
                        //                 userData,
                        //                 widget.productList)));
                        //   }
                        // } else {
                        //   loginFromWhere = 'productDetails';
                        //   Navigator.push(
                        //       context, SlideLeftRoute(page: LoginForm(loginFromWhere)));
                        // }
                        // // loginFromWhere = 'product';
                        // // Navigator.push(context,
                        // //   SlideLeftRoute(page: LoginForm(loginFromWhere)));
                        // // Navigator.push(context,
                        // //   SlideLeftRoute(page: ChattingPage(ind, id,id2,id3,id4,id5)));
                      },
                      backgroundColor:
                          Color(0xFFfae6d0), //appColor.withOpacity(0.6),
                      label:
                          // Container(
                          //   width: 100,
                          //   color: appColor.withOpacity(0.6), // button color
                          // child: InkWell(
                          //   //splashColor: appColor.withOpacity(0.6), // splash color
                          //   onTap: () {
                          //     // if (_isLoggedIn == true) {
                          //     //   if (userId == sellerId) {
                          //     //     return _showMessage('This is your own product');
                          //     //   } else {
                          //     //     Navigator.push(
                          //     //         context,
                          //     //         SlideLeftRoute(
                          //     //             page: ChattingPage(
                          //     //                 sellerFirstName,
                          //     //                 sellerLastName,
                          //     //                 conversationId,
                          //     //                 userId,
                          //     //                 sellerId,
                          //     //                 userData,
                          //     //                 widget.productList)));
                          //     //   }
                          //     // } else {
                          //     //   loginFromWhere = 'productDetails';
                          //     //   Navigator.push(
                          //     //       context, SlideLeftRoute(page: LoginForm(loginFromWhere)));
                          //     // }
                          //   }, // button pressed
                          //child:
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const <Widget>[
                          Icon(Icons.person,
                              color: Color.fromARGB(255, 143, 83, 234),
                              size: 27), // icon
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Order",
                            style: TextStyle(
                                color: Color.fromARGB(255, 143, 83, 234),
                                fontSize: 16,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.w600),
                          ), // text
                        ],
                      ),
                      // ),
                      // ),
                      //child: Icon(Icons.speaker_notes, color: appColor, size: 28),
                    ),
                  ),
                ),
              ],
            ),
            //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 26,
                  ),
                  label: 'Home',
                ),

                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.description_outlined,
                      size: 24,
                    ),
                    label: 'Orders'
                    //title: SizedBox.shrink(),//Text('')
                    ),
                // BottomNavigationBarItem(
                //   icon:
                //   // Icon(Icons.notifications_none,
                //   // // color: notificCount == 0 || notificCount == null?
                //   // // Colors.transparent
                //   // // :
                //   // // Colors.red[900],
                //   // ),
                //   new Stack(children: <Widget>[
                //           // notificCount != 0
                //           //     ? Container(
                //           //         margin: EdgeInsets.only(top: 5, right: 17),
                //           //         child: new Icon(
                //           //           Icons.notifications_none,
                //           //           size: 25,
                //           //         ),
                //           //       )
                //           //     :
                //               Container(
                //                   margin: EdgeInsets.only(top: 0, right: 0),
                //                   child: new Icon(
                //                     Icons.notifications_none,
                //                     size: 25,
                //                   ),
                //                 ),
                //           // notificCount == 0
                //           //     ?
                //               Positioned(
                //                   right: 0,
                //                   child: Container(
                //                     padding: EdgeInsets.only(
                //                         top: 1, bottom: 1, right: 5, left: 5),
                //                     margin: EdgeInsets.only(
                //                         right: 0, left: 0, bottom: 10),
                //                     decoration: BoxDecoration(
                //                         color: Colors.transparent,
                //                         borderRadius: BorderRadius.circular(15)),
                //                   ),
                //                 )
                //               // :
                //               // Positioned(
                //               //     left: 9,
                //               //     child: Container(
                //               //       padding: EdgeInsets.only(
                //               //           top: 2, bottom: 1, right: 5, left: 5),
                //               //       margin: EdgeInsets.only(
                //               //           right: 0, left: 0, bottom: 10),
                //               //       decoration: BoxDecoration(
                //               //           color: Colors.red[600],
                //               //           borderRadius: BorderRadius.circular(15)),
                //               //       child: Text(
                //               //         notificCount.toString(),
                //               //         textAlign: TextAlign.start,
                //               //         style: TextStyle(
                //               //             color: Colors.white,
                //               //             fontSize: 9,
                //               //             fontFamily: 'Oswald',
                //               //             fontWeight: FontWeight.w400),
                //               //       ),
                //               //     ),
                //               //   )
                //         ]),
                //   //title: SizedBox.shrink(),//Text(''),
                // ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.notifications_none,
                      size: 25,
                    ),
                    // title: SizedBox.shrink(),//Text(''),
                    label: 'Notifications'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_outline,
                      size: 26,
                    ),
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
              backgroundColor: appColor.withOpacity(0.7),
              //backgroundColor: Color(0XFFF8F8F8).withOpacity(0.7),
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0XFF090909),
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.push(
                    //     context, SlideLeftRoute(page: BottomNavigationPage(0)));
                  }),
              title: Text(
                'Details',
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              ),
              centerTitle: true,
              // actions: <Widget>[
              //   (_isLoggedIn == true && conversationId != '0') ? IconButton(
              //       icon: Icon(
              //         Icons.edit,
              //         color: Color(0XFF090909),
              //       ),
              //       onPressed: () {
              //         Navigator.push(
              //             context,
              //             SlideLeftRoute(
              //                 page: ReviewForm(widget.productList.id)));
              //       }) : Container()
              // ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                  padding: EdgeInsets.only(bottom: 30, top: 20),
                  child: Column(
                    children: <Widget>[
                      Card(
                          elevation: 0.3,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          margin: EdgeInsets.all(0),
                          child: Column(
                            children: <Widget>[
                              _buildProductImagesWidgets(),
                              _buildProductNameWidgets(),
                            ],
                          )),
                      // descriptionContainer('Category :', '- - -'),
                      descriptionContainer('Product\'s Description :', 
                      ///'Purple color gown with waist belt'
                          widget.productList.description == ''
                              ? '- - -'
                              : '${widget.productList.description}'
                          ),
                      descriptionContainer('Category Name :', 
                      ///'Cotton'
                          widget.productList.category_name == ''
                              ? '- - -'
                              : '${widget.productList.category_name}'
                          ),
                      descriptionContainer('Price :', 
                      //'15.50'
                          widget.productList.price == ''
                              ? '- - -'
                              : '£ ${widget.productList.price}'
                          ),
                      // descriptionContainer('Size :', '- - -'
                      //     // widget.productList.size == ''
                      //     //     ? '- - -'
                      //     //     : '${widget.productList.size}'
                      //     ),
                      descriptionContainer('Tailor\'s Location :', 'London'
                          // widget.productList.users.addres == '' ||
                          //         widget.productList.users.addres == null ||
                          //         widget.productList.users.addres.country ==
                          //             '' ||
                          //         widget.productList.users.addres.country ==
                          //             null
                          //     ? '- - -'
                          //     //: '${widget.productList.users.addres.countryName}'
                          //     : '${widget.productList.users.addres.SubDivisionOrZipCode}, ${widget.productList.users.addres.DivisionOrCounty}, ${widget.productList.users.addres.RegionOrState}, ${widget.productList.users.addres.country.countryName}'
                          ),

                      _buildProductPriceWidgets(),
                     // _buildReviewWidgets(),

                      ///_buildMoreStuffWidgets(),
                    ],
                  )),
            ))
        : bottomNavIndex == 1
            ? BottomNavigationPage(1)
            : bottomNavIndex == 2
                ? BottomNavigationPage(2)
                : bottomNavIndex == 3
                    ? BottomNavigationPage(3)
                    : BottomNavigationPage(4);
  }

  Container descriptionContainer(String title, String subTitle) {
    return Container(
        padding: EdgeInsets.fromLTRB(12, 20, 8, 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title, //'Category :',
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Proxima Nova',
                  color: Color(0XFF373740).withOpacity(0.7),
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                subTitle, //'- - -',
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontSize: 14.5,
                    fontFamily: 'Proxima Nova',
                    color: Color(0XFF373740),
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ));
  }

  _buildProductImagesWidgets() {
    return Container(
        margin: EdgeInsets.only(top: 25),
        child:
            // _isVideo == true && _isImage == true && _isShow == false
            //     ? imgList.length == 0
            //         ? Center(child: CircularProgressIndicator())
            //         :
            Stack(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 2.2, //250.0,
                //initialPage: 0,
                enlargeCenterPage: true,
                autoPlay: false,
                reverse: false,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                pauseAutoPlayOnTouch: true, //Duration(seconds: 10),
                scrollDirection: Axis.horizontal,
                // onPageChanged: (index) {
                //   setState(() {
                //     _current = index;
                //   });
                // },
              ),
              // height: MediaQuery.of(context).size.height / 2.2, //250.0,
              // //initialPage: 0,
              // enlargeCenterPage: true,
              // autoPlay: false,
              // reverse: false,
              // enableInfiniteScroll: false,
              // viewportFraction: 1.0,
              // autoPlayInterval: Duration(seconds: 2),
              // autoPlayAnimationDuration: Duration(milliseconds: 2000),
              // pauseAutoPlayOnTouch: Duration(seconds: 10),
              // scrollDirection: Axis.horizontal,
              // onPageChanged: (index) {
              //   setState(() {
              //     _current = index;
              //   });
              // },
              items: images.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      //margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: GestureDetector(
                          onTap: () {
                            viewImage(
                              widget.productList.cloth_name == null?
                              'Dress Name' : "${widget.productList.cloth_name}",
                               images, 3);
                            //viewImage(widget.productList.name, images, _current);
                          },
                          child:
                              widget.productList.image == null?
                              Image.asset(
                            'assets/image/purple_dress.png',
                            fit: BoxFit.contain,
                          )
                          :
                          Image.network(
                              '${widget.productList.image}',
                              width: 230,
                              height: MediaQuery.of(context).size.height / 5.5,//130,
                              fit: BoxFit.contain,
                            ),
                          // child: Image.network(
                          //   imgUrl, //'${CallApi().getUrl() + imgUrl}',
                          //   width: 50,
                          //   fit: BoxFit.fill,
                          // ),
                          ),
                    );
                  },
                );
              }).toList(),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height / 2.6, 20, 0),
              // margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.black,
                    child: Text(
                      //"${_current + 1}/${images.length}",
                      '1/2', //
                      style:
                          TextStyle(color: Colors.white, fontFamily: "Oswald"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void viewImage(String name, List imgList, int index) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new SomeDialog(name: name, imgList: imgList, id: index);
        },
        fullscreenDialog: true));
  }

  _buildProductNameWidgets() {
    return Container(
      //color: Colors.amber,
      padding: EdgeInsets.only(bottom: 12, top: 8, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              //color: Colors.blue,
              margin: EdgeInsets.fromLTRB(8, 8, 5, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  <Widget>[
                  Flexible(
                    child: Text(
                     // 'Purple Gown',
                      widget.productList.cloth_name == null
                          ? '---'
                          : '${widget.productList.cloth_name}',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Proxima Nova',
                          color: Color(0XFF373740),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Icon(
                  //         Icons.star,
                  //         size: 15,
                  //         color: Color(0XFF707070),
                  //       ),
                  //     ),
                  //     Text(
                  //   '4.5',
                  //   overflow: TextOverflow.clip,
                  //   style: TextStyle(
                  //       fontSize: 16,
                  //       fontFamily: 'Proxima Nova',
                  //       color: Color(0XFF373740),
                  //       fontWeight: FontWeight.bold),
                  // ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          // Row(
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Icon(
          //         Icons.star,
          //         size: 15,
          //         color: Color(0XFF707070),
          //       ),
          //     ),
          //     Text(
          //       // widget.productList.avgRating == null
          //       //     ? '0.0'
          //       //     : '${widget.productList.avgRating.averageRating}', //
          //       '4.5',
          //       overflow: TextOverflow.clip,
          //       style: TextStyle(
          //           fontSize: 16,
          //           fontFamily: 'Proxima Nova',
          //           color: Color(0XFF373740),
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // ),
          // Container(
          //     //color: Colors.blue,
          //     margin: EdgeInsets.only(right: 8),
          //     child: Row(
          //       children: <Widget>[
          //         Text(
          //           'Stock',
          //           overflow: TextOverflow.clip,
          //           style: TextStyle(
          //               fontSize: 12,
          //               fontFamily: 'Proxima Nova',
          //               color: Color(0XFF707070).withOpacity(0.7),
          //               fontWeight: FontWeight.normal),
          //         ),
          //         SizedBox(width: 5),
          //         Text(
          //           '100',
          //           overflow: TextOverflow.clip,
          //           style: TextStyle(
          //               fontSize: 12,
          //               fontFamily: 'Proxima Nova',
          //               color: appColor,
          //               fontWeight: FontWeight.bold),
          //         ),
          //       ],
          //     )),
        ],
      ),
    );
  }

  _buildReviewWidgets() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ////////////////  reviews /////////////
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          margin: EdgeInsets.fromLTRB(15, 15, 10, 10),
          decoration: BoxDecoration(
              // border: Border.all(color: appColor)
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Reviews :',
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Proxima Nova',
                    color: Color(0XFF373740).withOpacity(0.7), //appColor,//
                    fontWeight: FontWeight.normal),
              ),
              (_isLoggedIn == true && conversationId != '0')
                  ? GestureDetector(
                      onTap: () {
                        // if (_isLoggedIn == true) {
                        //   if (conversationId != '0') {
                        //     if (userId == sellerId) {
                        //       return _showMessage('This is your own product');
                        //     } else {
                        //       _showReviewDialog();
                        //       // Navigator.push(
                        //       // context,
                        //       // SlideLeftRoute(
                        //       //     page: ProductReviewForm(widget.productList.id)));
                        //     }
                        //   }
                        // } else {
                        //   loginFromWhere = 'productDetails';
                        //   Navigator.push(context,
                        //       SlideLeftRoute(page: LoginForm(loginFromWhere)));
                        // }
                      },
                      child: Text(
                        'Give a review',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Proxima Nova',
                            color:
                                appColor, //Color(0XFF373740).withOpacity(0.7),//
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        newReview == true
            ? productList == null || productList.length == 0
                ? Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Text('No Reviews yet !!'))
                : Container(
                    height: 170,
                    // ConstrainedBox(
                    // constraints: new BoxConstraints(
                    //   minHeight: 135.0,
                    //   maxHeight: 220.0,
                    // ),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                        itemCount: productList == null ? 0 : productList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Container(
                              alignment: Alignment.topLeft,
                              //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  height: 120,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('From '),
                                              Flexible(
                                                child: Text(
                                                    (productList == null ||
                                                                productList[index]
                                                                        .users
                                                                        .firstName ==
                                                                    null ||
                                                                productList[index]
                                                                        .users
                                                                        .lastName ==
                                                                    null) ||
                                                            (productList ==
                                                                    null ||
                                                                productList[index]
                                                                        .users
                                                                        .firstName ==
                                                                    '' ||
                                                                productList[index]
                                                                        .users
                                                                        .lastName ==
                                                                    '')
                                                        ? ''
                                                        : '${productList[index].users.firstName} ${productList[index].users.lastName}',
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0XFF373740),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 5, 2),
                                            child: new Text(
                                                productList == null ||
                                                        productList[index]
                                                                .review ==
                                                            null
                                                    ? ''
                                                    : productList[index].review,
                                                overflow: TextOverflow.clip,
                                                maxLines: 8,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Roboto',
                                                    color: Color(0XFF373740),
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.fromLTRB(
                                            //           0, 2, 0, 8),
                                            //   child: SmoothStarRating(
                                            //     allowHalfRating: true,
                                            //     rating: productList == null ||
                                            //             productList[index]
                                            //                     .rate ==
                                            //                 null
                                            //         ? 0.0
                                            //         : productList[index]
                                            //             .rate
                                            //             .toDouble(), //4,
                                            //     size: 16,
                                            //     starCount: 5,
                                            //     spacing: 2.0,
                                            //     color: appColor,
                                            //     borderColor: appColor,
                                            //     // onRatingChanged: (value) {
                                            //     //   setState(() {
                                            //     //     rating = value;
                                            //     //   });
                                            //     // },
                                            //   ),
                                            // ),
                                            SizedBox(width: 5),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 3, 0, 8),
                                              child: Text(
                                                productList == null ||
                                                        productList[index]
                                                                .rate ==
                                                            null
                                                    ? '(0/5)'
                                                    : '(${productList[index].rate}/5)', //'(4.5/5)',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Proxima Nova',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                  color: appColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }
                        // itemBuilder: (BuildContext context, int index) =>
                        // Container(
                        //   margin: EdgeInsets.only(bottom: 10, top: 5, left: 10),
                        //   child: SubscriptionCard(
                        //     reviews[index]),
                        // ),
                        // itemCount: reviews == null? 0 : reviews.length, //7,
                        ),
                  )
            : reviews == null || reviews == [] || reviews.length == 0
                ? Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Text('No Reviews yet !!'))
                : Container(
                    height: 170,
                    // color: Colors.red,
                    // ConstrainedBox(
                    // constraints: new BoxConstraints(
                    //   minHeight: 135.0,
                    //   maxHeight: 220.0,
                    // ),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                        itemCount: 0,
                        // widget.productList.reviews == null
                        //     ? 0
                        //     : widget.productList.reviews.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Container(
                              alignment: Alignment.topLeft,
                              //height: 120,
                              //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  height: 120,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const <Widget>[
                                              Text('From '),
                                              Flexible(
                                                child: Text('d K',
                                                    // (widget.productList.reviews == null ||
                                                    //  widget.productList.reviews[index].users.firstName == null ||
                                                    //  widget.productList.reviews[index].users.lastName ==null) ||
                                                    // (widget.productList.reviews == null ||
                                                    //  widget.productList.reviews[index].users.firstName == '' ||
                                                    //  widget.productList.reviews[index].users.lastName =='')
                                                    //  ? ''
                                                    //  : '${widget.productList.reviews[index].users.firstName} ${widget.productList.reviews[index].users.lastName}',
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0XFF373740),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 5, 2),
                                            child: new Text('---',
                                                // widget.productList.reviews == null
                                                // || widget.productList.reviews[index].review == null
                                                //  ? ''
                                                // : '${widget.productList.reviews[index].review}',
                                                overflow: TextOverflow.clip,
                                                //maxLines: 8,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Roboto',
                                                    color: Color(0XFF373740),
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.fromLTRB(
                                            //           0, 2, 0, 8),
                                            //   child: SmoothStarRating(
                                            //     allowHalfRating: true,
                                            //     rating: widget.productList
                                            //                     .reviews ==
                                            //                 null ||
                                            //             widget
                                            //                     .productList
                                            //                     .reviews[index]
                                            //                     .rate ==
                                            //                 null
                                            //         ? 0.0
                                            //         : widget.productList
                                            //             .reviews[index].rate
                                            //             .toDouble(), //4,
                                            //     size: 16,
                                            //     starCount: 5,
                                            //     spacing: 2.0,
                                            //     color: appColor,
                                            //     borderColor: appColor,
                                            //     // onRatingChanged: (value) {
                                            //     //   setState(() {
                                            //     //     rating = value;
                                            //     //   });
                                            //     // },
                                            //   ),
                                            // ),
                                            SizedBox(width: 5),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 3, 0, 8),
                                              child: Text(
                                                // widget.productList.reviews ==
                                                //             null ||
                                                //         widget
                                                //                 .productList
                                                //                 .reviews[index]
                                                //                 .rate ==
                                                //             null
                                                //     ? '(0/5)'
                                                //     : '(${widget.productList.reviews[index].rate}/5)',
                                                '(4.5/5)',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Proxima Nova',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                  color: appColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }),
                  ),
      ],
    );
  }

  _buildProductPriceWidgets() {
    return Container(
        margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'Unit Price',
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(width: 8),
            Text(
              'GBP ',
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              widget.productList.price == null
                  ? '- - -'
                  : '${widget.productList.price}',
              ///'15.50',
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  color: appColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  // _buildMoreStuffWidgets() {
  //   return
  //       // (noMoreStuff == true)
  //       //     ? Container()
  //       // :
  //       Container(
  //           margin: noMoreStuff
  //               ? EdgeInsets.only(top: 10)
  //               : EdgeInsets.only(top: 2),
  //           child: Column(
  //             children: <Widget>[
  //               Container(
  //                 margin: noMoreStuff
  //                     ? EdgeInsets.only(bottom: 0)
  //                     : EdgeInsets.only(bottom: 20),
  //                 child: Text(
  //                   noMoreStuff ? '' : 'More Stuff From This Seller',
  //                   textAlign: TextAlign.center,
  //                   overflow: TextOverflow.clip,
  //                   style: TextStyle(
  //                       fontSize: 18,
  //                       fontFamily: 'Roboto',
  //                       color: Theme.of(context).accentColor,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),

  //               ///////// More Products List //////
  //               // getMoreStuffList == null
  //               //     ? Center(
  //               //         child: Container(
  //               //             margin: EdgeInsets.only(top: 50, bottom: 50),
  //               //             child: CircularProgressIndicator()))
  //               //     : getMoreStuffList.length == 0
  //               //         ? Center(
  //               //             child: Container(
  //               //                 alignment: Alignment.center,
  //               //                 height: 300,
  //               //                 child: Text("No product data found!")))
  //               //         :
  //               noMoreStuff
  //                   ? Container()
  //                   : MediaQuery.of(context).orientation == Orientation.portrait
  //                       ? Container(
  //                           height:
  //                               MediaQuery.of(context).size.height / 3.3, //200,
  //                           //color: Colors.white,
  //                           width: MediaQuery.of(context).size.width,
  //                           margin: EdgeInsets.only(left: 8),
  //                           child:

  //                               /////////// More Products Portrait start //////

  //                               ListView.builder(
  //                             physics: BouncingScrollPhysics(),
  //                             scrollDirection: Axis.horizontal,
  //                             itemBuilder: (BuildContext context, int index) =>
  //                                 Container(
  //                               margin: EdgeInsets.only(
  //                                   bottom: 5, top: 5, left: 10),
  //                               // decoration: BoxDecoration(
  //                               //   color: Colors.white,
  //                               //   borderRadius: BorderRadius.only(
  //                               //       bottomLeft: Radius.circular(10),
  //                               //       bottomRight: Radius.circular(10)),
  //                               // ),
  //                               child:
  //                                   PopularProductCard(getMoreStuffList[index]),
  //                             ),
  //                             itemCount: getMoreStuffList == null
  //                                 ? 0
  //                                 : getMoreStuffList.length, //7,
  //                           ))
  //                       /////////// More Products Portrait end //////
  //                       :
  //                       //   /////////// More Products Landscape start //////
  //                       Container(
  //                           height:
  //                               MediaQuery.of(context).size.height / 2, //200,
  //                           //color: Colors.white,
  //                           width: MediaQuery.of(context).size.width,
  //                           margin: EdgeInsets.only(left: 8),
  //                           child: ListView.builder(
  //                             physics: BouncingScrollPhysics(),
  //                             scrollDirection: Axis.horizontal,
  //                             itemBuilder: (BuildContext context, int index) =>
  //                                 Container(
  //                               margin: EdgeInsets.only(
  //                                   bottom: 5, top: 5, left: 10),
  //                               // decoration: BoxDecoration(
  //                               //   color: Colors.white,
  //                               //   borderRadius: BorderRadius.only(
  //                               //       bottomLeft: Radius.circular(10),
  //                               //       bottomRight: Radius.circular(10)),
  //                               // ),
  //                               child: PopularProductCardLandscape(
  //                                   getMoreStuffList[index]),
  //                             ),
  //                             itemCount: getMoreStuffList == null
  //                                 ? 0
  //                                 : getMoreStuffList.length, //7,
  //                           )),
  //               ///////////////// More product end ///////////////////

  //               // Container(
  //               //     height: 200,
  //               //     //color: Colors.white,
  //               //     width: MediaQuery.of(context).size.width,
  //               //     margin: EdgeInsets.only(left: 8),
  //               //     child:
  //               //         //   MediaQuery.of(context).orientation ==
  //               //         //     Orientation.portrait
  //               //         // ?

  //               //         /////////// More Products Portrait start //////

  //               //         ListView.builder(
  //               //       physics: BouncingScrollPhysics(),
  //               //       scrollDirection: Axis.horizontal,
  //               //       itemBuilder: (BuildContext context, int index) => Container(
  //               //         margin: EdgeInsets.only(bottom: 5, top: 5, left: 10),
  //               //         // decoration: BoxDecoration(
  //               //         //   color: Colors.white,
  //               //         //   borderRadius: BorderRadius.only(
  //               //         //       bottomLeft: Radius.circular(10),
  //               //         //       bottomRight: Radius.circular(10)),
  //               //         // ),
  //               //         child: PopularProductCard(index),
  //               //       ),
  //               //       itemCount: 7,
  //               //     )
  //               //     ),
  //               //     /////////// More Products end ///////////
  //             ],
  //           ));
  // }

  // _showMessage(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       //timeInSecForIos: 1,
  //       backgroundColor: appColor.withOpacity(0.9),
  //       textColor: Colors.white,
  //       fontSize: 13.0);
  // }

  /////////////////////////////////  Api Calling   /////////////////////////////
  // void _reviewSubmit() async {
  //   if (reviewController.text.isEmpty) {
  //     return _showDialog("Review field is empty. Give a review");
  //   } else if (rating == 0.0) {
  //     return _showDialog("Rating field is empty. Give rating");
  //   }

  //   var data = {
  //     "review": reviewController.text,
  //     "rate": rating,
  //     'serviceId': widget.productList.id,
  //   };
  //   print(data);
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   // print(data);

  //   var res = await CallApi().postData1(data, '/app/giveReview');
  //   print(res);
  //   var body = json.decode(res.body);
  //   print(body);

  //   if (res.statusCode == 200) {
  //     _showMessage("Your review is submitted!");
  //     getProductData();
  //     setState(() {
  //       reviewController.text = '';
  //       rating = 0.0;
  //     });
  //     Navigator.pop(context);

  //     // Navigator.push(
  //     //     context,
  //     // MaterialPageRoute(builder: (context) => PopularProductDetails(null,widget.id)),
  //     //);
  //   } else {
  //     _showMessage("Something went wrong !!");
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // void _showReviewDialog() {
  //   showGeneralDialog(
  //       barrierColor: Colors.black.withOpacity(0.5),
  //       transitionBuilder: (context, a1, a2, widget) {
  //         final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
  //         return Transform(
  //           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
  //           child: Opacity(
  //             opacity: a1.value,
  //             child: AlertDialog(
  //               shape: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(16.0)),
  //               contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
  //               content: StatefulBuilder(
  //                   // You need this, notice the parameters below:
  //                   builder: (BuildContext context, StateSetter setState) {
  //                 return SingleChildScrollView(
  //                     child: Container(
  //                         width: MediaQuery.of(context).size.width,
  //                         margin: EdgeInsets.fromLTRB(5, 30, 5, 5),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: <Widget>[
  //                             Container(
  //                               margin: EdgeInsets.only(left: 2),
  //                               child: Text(
  //                                 'Write a Review',
  //                                 style: TextStyle(
  //                                   color: Color(0XFF373740),
  //                                   fontSize: 18.0,
  //                                   fontFamily: 'Proxima Nova',
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ),
  //                             ///////////////// Review Textfield  Start///////////////
  //                             Container(
  //                               margin:
  //                                   EdgeInsets.only(top: 15, left: 5, right: 5),
  //                               // padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
  //                               child: TextField(
  //                                 style: TextStyle(color: Color(0xFF000000)),
  //                                 cursorColor: Color(0xFF9b9b9b),
  //                                 minLines: 3,
  //                                 maxLines: 100,
  //                                 controller: reviewController,
  //                                 keyboardType: TextInputType.text,
  //                                 textInputAction: TextInputAction.done,
  //                                 decoration: InputDecoration(
  //                                   focusedBorder: OutlineInputBorder(
  //                                       borderRadius: BorderRadius.all(
  //                                           Radius.circular(6)),
  //                                       borderSide: BorderSide(
  //                                           color: appColor, width: 1.5)),
  //                                   enabledBorder: OutlineInputBorder(
  //                                       borderRadius: BorderRadius.all(
  //                                           Radius.circular(6)),
  //                                       borderSide: BorderSide(
  //                                           color: appColor, width: 1.5)),
  //                                   contentPadding: EdgeInsets.only(
  //                                       left: 15, bottom: 10, top: 20),
  //                                 ),
  //                               ),
  //                             ),
  //                             ///////////////// Review Textfield  End///////////////

  //                             Container(
  //                               margin: EdgeInsets.only(top: 40, left: 2),
  //                               child: Text(
  //                                 'Give Rating',
  //                                 style: TextStyle(
  //                                   color: Color(0XFF373740),
  //                                   fontSize: 18.0,
  //                                   fontFamily: 'Proxima Nova',
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ),

  //                             // Container(
  //                             //   alignment: Alignment.center,
  //                             //   padding: EdgeInsets.fromLTRB(8, 15, 0, 0),
  //                             //   child: SmoothStarRating(
  //                             //     allowHalfRating: true,
  //                             //     rating: rating,
  //                             //     size: 40,
  //                             //     starCount: 5,
  //                             //     spacing: 2.0,
  //                             //     color: appColor,
  //                             //     borderColor: appColor,
  //                             //     onRatingChanged: (value) {
  //                             //       setState(() {
  //                             //         rating = value;
  //                             //         // _showReviewDialog();
  //                             //       });
  //                             //     },
  //                             //   ),
  //                             // ),

  //                             ///////////////// Submit Button  Start///////////////
  //                             Container(
  //                                 margin: EdgeInsets.only(
  //                                     left: 2, right: 2, bottom: 20, top: 60),
  //                                 width: MediaQuery.of(context).size.width,
  //                                 height: 45,
  //                                 child: RaisedButton(
  //                                   onPressed: () {
  //                                     // if (_isLoading == true) {
  //                                     // } else {
  //                                     //   _reviewSubmit();
  //                                     // }
  //                                   },
  //                                   shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.all(
  //                                           Radius.circular(6))),
  //                                   child: Text(
  //                                     _isLoading ? "Please wait..." : "Submit",
  //                                     style: TextStyle(
  //                                       color: Color(0XFFFFFFFF),
  //                                       fontSize: 18.0,
  //                                       decoration: TextDecoration.none,
  //                                       fontFamily: 'Proxima Nova',
  //                                       fontWeight: FontWeight.bold,
  //                                     ),
  //                                   ),
  //                                   color: appColor,
  //                                   elevation: 2.0,
  //                                 )),
  //                             ///////////////// Submit Button  End///////////////
  //                             //////////////////// Skip Button  Start///////////////
  //                             GestureDetector(
  //                               onTap: () {
  //                                 setState(() {
  //                                   rating = 0.0;
  //                                   reviewController.text = '';
  //                                 });
  //                                 Navigator.pop(context);
  //                               },
  //                               child: Container(
  //                                 margin: EdgeInsets.only(top: 8),
  //                                 alignment: Alignment.center,
  //                                 child: Text(
  //                                   'Skip',
  //                                   style: TextStyle(
  //                                     color: appColor,
  //                                     fontSize: 18.0,
  //                                     fontFamily: 'Proxima Nova',
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             ///////////////// Skip Button  End///////////////
  //                           ],
  //                         )));
  //               }),
  //             ),
  //           ),
  //         );
  //       },
  //       transitionDuration: Duration(milliseconds: 300),
  //       barrierDismissible: true,
  //       barrierLabel: '',
  //       context: context,
  //       pageBuilder: (context, animation1, animation2) {});
  // }

  void _showOfferDialog() {
    showDialog(
        context: context,
        // builder: (BuildContext context) {
        builder: (_) => Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  // height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 15, right: 15),
                  padding: EdgeInsets.only(
                      left: 15.0, right: 12.0, top: 40, bottom: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0XFFF8F8F8),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Color(0XFF7176C2).withOpacity(0.16),
                          offset: Offset(6.0, 7.0),
                        ),
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                "Do you want to make a reservation?",
                                style: TextStyle(
                                  color: Color(0XFF0A0A0A),
                                  fontSize: 18.0,
                                  decoration: TextDecoration.none,
                                  height: 1.5,
                                  fontFamily: 'Proxima Nova',
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ///////////////// OK Button  Start///////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                left: 0,
                                right: 10,
                                bottom: 20,
                                top: 40,
                              ),
                              // width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontSize: 18.0,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                color: appColor,
                                elevation: 2.0,
                              )),
                          Container(
                              margin: EdgeInsets.only(
                                left: 5,
                                right: 10,
                                bottom: 20,
                                top: 40,
                              ),
                              // width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: RaisedButton(
                                onPressed: () {
                                  // Navigator.of(context).pop();
                                  // //makeOffer();
                                  // if (widget.productList != null) {
                                  //   Navigator.push(
                                  //       context,
                                  //       SlideLeftRoute(
                                  //           page: ReservationForm(
                                  //               widget.productList)));
                                  // } else {
                                  //   return _showMessage(
                                  //       'No product or service is selected');
                                  // }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontSize: 18.0,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                color: appColor,
                                elevation: 2.0,
                              )),
                        ],
                      ),
                      ///////////////// OK Button  End///////////////
                    ],
                  ),
                ),
              ),
              //   );
              // },
            ));
  }

//   void _showDialog(String msg) {
//     showGeneralDialog(
//         barrierColor: Colors.black.withOpacity(0.5),
//         transitionBuilder: (context, a1, a2, widget) {
//           final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
//           return Transform(
//             transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//             child: Opacity(
//               opacity: a1.value,
//               child: AlertDialog(
//                 shape: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16.0)),
//                 title: Text(
//                   msg, //'Invalid Email/Password Combination'
//                 ),
//                 content: SingleChildScrollView(
//                   child: Container(
//                     color: Color(0xFFF2F2F2),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         new RawMaterialButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: new Text("Ok Got it!"),
//                           elevation: 5.0,
//                           fillColor: Color(0xFFF2F2F2),
//                           padding: const EdgeInsets.all(15.0),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//         transitionDuration: Duration(milliseconds: 300),
//         barrierDismissible: true,
//         barrierLabel: '',
//         context: context,
//         pageBuilder: (context, animation1, animation2) {});
//   }
}

class SomeDialog extends StatefulWidget {
  final String name;
  final List imgList;
  int id;

  SomeDialog({required this.name, required this.imgList, required this.id});
  @override
  _SomeDialogPageState createState() => new _SomeDialogPageState();
}

class _SomeDialogPageState extends State<SomeDialog> {
  int _current = 0;
  int _isBack = 0;
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      // appBar: new AppBar(
      //     //title: const Text('Dialog Magic'),
      //     ),
      //body: new Text("It's a Dialog!"),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _isBack++;
                });
              },
              child: Center(
                child: new Container(
                  padding: EdgeInsets.all(0.0),
                  color: Colors.black,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height,
                      initialPage: widget.id,
                      enlargeCenterPage: true,
                      autoPlay: false,
                      reverse: false,
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                      autoPlayInterval: Duration(seconds: 2),
                      autoPlayAnimationDuration: Duration(milliseconds: 2000),
                      pauseAutoPlayOnTouch: true, // Duration(seconds: 10),
                      scrollDirection: Axis.horizontal,
                      // onPageChanged: (index) {
                      //   setState(() {
                      //     widget.id = index;
                      //   });
                      // },
                    ),
                    items: widget.imgList.map((imgUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 80),
                            decoration: BoxDecoration(
                                //color: Colors.white,
                                ),
                            child: GestureDetector(
                              onScaleStart: (ScaleStartDetails details) {
                                print(details);
                                _previousScale = _scale;
                                setState(() {});
                              },
                              onScaleUpdate: (ScaleUpdateDetails details) {
                                print(details);
                                _scale = _previousScale * details.scale;
                                setState(() {});
                              },
                              onScaleEnd: (ScaleEndDetails details) {
                                print(details);

                                _previousScale = 1.0;
                                setState(() {});
                              },
                              child: Container(
                                child: Transform(
                                  transform: Matrix4.diagonal3(
                                      Vector3(_scale, _scale, _scale)),
                                  child: Image.asset(imgUrl),
                                  // Image.network(
                                  //   imgUrl, //'${CallApi().getUrl() + imgUrl}',
                                  //   fit: BoxFit.contain,
                                  // ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: _isBack % 2 == 0
                  ? Container(
                      child: Row(
                        children: <Widget>[
                          BackButton(
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text("${widget.name}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17))),
                                  ),
                                  Text(
                                      "${widget.id + 1}/${widget.imgList.length}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
