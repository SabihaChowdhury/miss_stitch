import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miss_stitch/main.dart';
import 'package:miss_stitch/models/orderSort.dart';
import 'package:miss_stitch/screens/Model/AllClothModel/AllClothModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api/registerApi.dart';
import '../../routeTransition/routeTransition.dart';
import '../bottomNavigation.dart';
import 'PopularProduct/popularProductCard.dart';
import 'PopularProduct/popularProductCardLandscape.dart';
import 'PopularServices/popularServiceCard.dart';
import 'PopularServices/popularServiceCardLandscape.dart';
import 'Search/searchCard.dart';

class Outfit extends StatefulWidget {
  //const Outfit({Key? key}) : super(key: key);

  @override
  State<Outfit> createState() => _OutfitState();
}

class _OutfitState extends State<Outfit> {
  TextEditingController searchController = TextEditingController();
  bool _text = false;
  bool _isLoading = false;

  bool _isLoggedIn = false;
  bool seeAll = false,
      seeAllServices = false,
      seeAllCloths = false,
      isSearch = false,
      noSearchData = false;
  var body, serviceBody, serviceList = [], clothBody, clothList = [], bodyS;
  var getAllBody, getAllList;
  var popularClothBody,
      popularClothList,
      popularServiceBody,
      popularServiceList;
  var serviceMsg = "", clothMsg = "", getAllMsg = "";
  
  var userData;
  var userToken;

  @override
  void initState() {
    bottomNavIndex = 0;
    /*_checkIfLoggedIn();
    getAllServiceList();
    getAllClothList();
    getPopularClothList();
    getPopularServiceList();*/
    _checkIfLoggedIn();
    getAllClothList();
    /// clothList.length = 5;
    //getAllDataList();
    // setState(() {
    //   seeAll2 = false;
    //   print('seeAll2');
    // });
    super.initState();
  }


    void _checkIfLoggedIn() async {
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    ///var token = localStorage.getString('token');
    var user = localStorage.getString('user');
    // print('userrrrr');
    // print(user);
    // if (token != null) {
    //   setState(() {
    //     _isLoggedIn = true;
    //   });
    // }
    if (user != null) {
      var userinfoList = json.decode(user);
      setState(() {
        _isLoggedIn = true;
        userData = userinfoList;
        ///userToken = token;
      });
      //deviceId = userinfoList['device_id'];
      print('userData');
      print(userData);
      // print('userToken');
      // print(userToken);
    }
    // searchCountryId = (userData != null && userData['addres'] != null) || (userData != null && userData['addres'] != '')?
    //           '${userData['addres']['CountryId']}': '';
    // searchDivision = (userData != null && userData['addres'] != null) || (userData != null && userData['addres'] != '')?
    //           '${userData['addres']['DivisionOrCounty']}': '';
    // searchSubdivision = (userData != null && userData['addres'] != null) || (userData != null && userData['addres'] != '')?
    //           '${userData['addres']['SubDivisionOrZipCode']}': '';
    // searchState = (userData != null && userData['addres'] != null) || (userData != null && userData['addres'] != '')?
    //           '${userData['addres']['RegionOrState']}': '';
    // print('searchCountryId');
    // print(searchCountryId);
    // print(searchDivision);
    // print(searchSubdivision);
    // print(searchState);
  }


  /////////////// get allCloth api ///////////
  Future _getLocalAllClothData(key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localallClothData = localStorage.getString(key);
    if (localallClothData != null) {
      clothBody = json.decode(localallClothData);
      // print('dmjsvgd hdsftrstfgdhjs');
      // print(clothBody);
      _allClothState();
    }
  }

  void _allClothState() {
    // print('sjshdvchbd');
    // print(clothBody);
    if(clothBody != null) {
       print('issue with model');
      //var clothdata = AllclothModel.fromJson(clothBody);
      final cloth = json.decode(clothBody);
       print(cloth);

      var clothdata = AllClothModel.fromJson(cloth);
      //clothList = clothdata.cloth;
    if (!mounted) return;
    setState(() {
      clothList = clothdata.data;
    });
    }
    // var clothdata = AllclothModel.fromJson(clothBody);
    // if (clothdata != null) {
    // if (!mounted) return;
    // setState(() {
    //   clothList = clothdata.cloth;
    // });
    // }
  }

  Future<void> getAllClothList() async {
    var keyCloth = 'all-cloth-list';
    await _getLocalAllClothData(keyCloth);

    var res = await CallApi().getData('/api/cloths/all');
    clothBody = json.decode(res.body);
     print(clothBody);
    print(res.statusCode);

    if (res.statusCode == 200) {
      var clothcontent = res.body;
      final cloth = json.decode(clothcontent);
      // print(cloth);

      var clothdata = AllClothModel.fromJson(cloth);
      clothList = clothdata.data;

      if (clothList != null) {
        if (!mounted) return;
        setState(() {
          //  String dd = clothList.created_at;
          //  var spDate = dd.split(" ");
          //  alertDate = spDate[0];
          // situation = clothList.situation;
          print('clothList');
          print(clothList);
        });
        // print(cloth);
      } else {
        setState(() {
          clothMsg = "No cloth data available!";
        });
      }

      print("clothList.length");
      print(clothList.length);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(keyCloth, json.encode(clothcontent));
    }
  }

 

  void _onItemTapped(int index) {
    setState(() {
      //_selectedIndex = index;
      if (index == 0) {
        Navigator.push(context, SlideRightRoute(page: BottomNavigationPage(0)));
      } else {
        bottomNavIndex = index;
      }
    });
  }

  void choiceAction(String choice) {
    if (choice == OrderSortPrice.priceSort) {
      selection(2);
    }
   /* if (choice == OrderSort.citySort) {
      //selection(2);
      setState(() {
        _seqType = '';
        // searchState2 = '';
        // searchDivision2 = '';
        // searchSubdivision2 = '';
        // searchCountryId2 = '';
        _seqType2 = '1';
      });

      // I did getAllDataList(searchController.text);
    } */
    // if (choice == OrderSort.stateSort) {
    //   selection(3);
    // }
    // if (choice == OrderSort.countrySort) {
    //   selection(3);
    // }
  }

  var _seqName = "Price";
  var _seqType = "";
  var _seqType2 = "";
  var _sendType = 'asc';

  var _type = ['low to high', 'high to low'];
  var _genderType = ['Female', 'Male'];
  var _currentTypeSelected = 'low to high';
  var _currentGenderTypeSelected = 'Female';

  void _typeDropDownSelected(String newValueSelected) {
    setState(() {
      _currentTypeSelected = newValueSelected;
      if (newValueSelected == 'low to high') {
        _sendType = 'asc';
        _seqType = '1';
        _seqType2 = '';
      } else {
        _sendType = 'desc';
        _seqType = '2';
        _seqType2 = '';
      }
    });

    Navigator.pop(context);

    selection(3);
  }

  void _genderTypeDropDownSelected(String newValueSelected) {
    setState(() {
      _currentGenderTypeSelected = newValueSelected;
      // if (newValueSelected == 'Female') {
      //   _sendType = 'asc';
      //   _seqType = '1';
      //   _seqType2 = '';
      // } else {
      //   _sendType = 'desc';
      //   _seqType = '2';
      //   _seqType2 = '';
      // }
    });
  }

  Future<void> _refreshData() async {
    // getAllServiceList();
    // getAllclothList();
    // getPopularclothList();
    // getPopularServiceList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:

            ///isSearch == true || seeAll == true?
            _onWillPop2,
        //:
        // _onWillPop,
        child: bottomNavIndex == 0
            ? Scaffold(
                extendBodyBehindAppBar: true,
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
                  elevation: 1,
                  automaticallyImplyLeading: false,
                  backgroundColor: appColor,
                  //backgroundColor: Colors.white.withOpacity(0.2),
                  centerTitle: false,
                  // leading: Padding(
                  //   padding: const EdgeInsets.only(left: 5),
                  //   child: Image.asset(
                  //     'assets/image/Color logo - no background.png',
                  //     width: 80,
                  //    height: 120,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                  //titleSpacing: 2.5,
                  title: Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 3, 10),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/image/blackLogoImg.png',
                          width: 40,
                          height: 30,
                          fit: BoxFit.fitHeight,
                        ),
                        const Text(
                          'MissStitch',
                          style: TextStyle(
                              //fontFamily: 'Proxima Nova',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87),
                        )
                      ],
                    ),
                  ),
                  // Text(
                  //   isSearch == true ? 'Search' : 'Home',
                  //   style: TextStyle(
                  //       fontFamily: 'Proxima Nova',
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       color: appColor),
                  // ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: const Icon(
                          Icons.logout_sharp,
                          size: 20,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          // Navigator.push(context,
                          // SlideLeftRoute(page: Subscription(2)));
                        },
                      ),
                    )
                  ],
                ),
                body: SafeArea(
                  child: RefreshIndicator(
                    onRefresh: _refreshData,
                    child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: <Widget>[
                          SliverToBoxAdapter(
                              child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(2, 10, 2, 5),
                                  child: Column(children: <Widget>[
                                    //////////  Male/Female Option Start ///////////
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5, 5, 8, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                              ),
                                              // width: MediaQuery.of(context).size.width / 2,
                                              margin: const EdgeInsets.only(
                                                  bottom: 0,
                                                  left: 15,
                                                  right: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                  color: Colors.grey[200],
                                                  border: Border.all(
                                                      width: 0.2,
                                                      color: Colors.grey)),
                                              alignment: Alignment.center,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(

                                                      //color: Colors.red,
                                                      child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child: DropdownButton<
                                                              String>(
                                                            isExpanded: true,
                                                            icon: const Icon(
                                                                Icons
                                                                    .keyboard_arrow_down,
                                                                size: 25,
                                                                color: Color(
                                                                    0xFFC5C2C7)),
                                                            items: _genderType
                                                                .map((String
                                                                    dropDownStringItem) {
                                                              return DropdownMenuItem<
                                                                      String>(
                                                                  value:
                                                                      dropDownStringItem,
                                                                  child: Text(
                                                                    dropDownStringItem,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey[600]),
                                                                  ));
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValueSelected) {
                                                              _genderTypeDropDownSelected(
                                                                  newValueSelected!);
                                                            },
                                                            value:
                                                                _currentGenderTypeSelected,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            //height: 45.0,
                                            //decoration: BoxDecoration(
                                            //color: appColor,
                                            //borderRadius: BorderRadius.circular(15)
                                            // ),
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Sort',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    //fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                                PopupMenuButton<String>(
                                                  onSelected: choiceAction,
                                                  icon: const Icon(
                                                    Icons
                                                        .sort, //Icons.filter_list,
                                                    color: Colors.black54,
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return OrderSortPrice.choices
                                                        .map((String choice) {
                                                      return PopupMenuItem<
                                                          String>(
                                                        value: choice,
                                                        child: Text(choice),
                                                      );
                                                    }).toList();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          /* ElevatedButton(
                                    //style: ButtonStyle(backgroundColor: ),
                                    onPressed: () {

                                  }, 
                                  style: ElevatedButton.styleFrom(
                                  primary: appColor.withOpacity(0.9),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                                  child: 
                                  Row(
                                    children: const [
                                      Text('Sort'),
                                      SizedBox(width: 10,),
                                      Icon(Icons.sort),
                                    ],
                                  )
                                  ),*/
                                        ],
                                      ),
                                    ),
                                    //////////////  Search Start  ///////////////////
                                    //isSearch == true?
                                    Container(
                                      height: 45.0,
                                      margin: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.grey[200],
                                        //     blurRadius: 5,
                                        //   )
                                        // ],
                                        //color: const Color(0XFFE1E1E1),
                                        color: Colors.grey[300],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Expanded(
                                            child: TextField(
                                              autofocus: false,
                                              //textAlign: TextAlign.center,
                                              cursorColor: Colors.grey,
                                              controller: searchController,
                                              textInputAction:
                                                  TextInputAction.search,
                                              decoration: InputDecoration(
                                                prefixIcon: Padding(
                                                  padding: _text
                                                      ? const EdgeInsets.only(
                                                          left: 20.0, right: 10)
                                                      : const EdgeInsets.only(
                                                          left: 60.0,
                                                          right: 10),
                                                  child: const Icon(
                                                    Icons.search,
                                                    color: Colors.black38,
                                                    size: 22,
                                                  ),
                                                ),
                                                hintText:
                                                    'What are you looking for?',
                                                hintStyle: const TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black38,
                                                ),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 15.0, top: 10.0),
                                                suffixIcon: _text
                                                    ? IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _text = false;
                                                            isSearch = false;
                                                            noSearchData =
                                                                false;
                                                            /* isSearchCountryId = false;
                                                isSearchDivision = false;
                                                isSearchSubdivision = false;
                                                isSearchState = false;
                                                searchState2 = '';
                                                searchDivision2 = '';
                                                searchSubdivision2 = '';
                                                searchCountryId2 = ''; */
                                                            _seqType = '';
                                                            _seqType2 = '';
                                                            searchController
                                                                .text = "";
                                                          });
                                                          // store.dispatch(CheckFilter(false));
                                                          //   _displayShops();
                                                        },
                                                        icon: const Icon(
                                                            Icons.cancel),
                                                        color: Colors.grey,
                                                      )
                                                    : const Icon(
                                                        Icons.cancel,
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                              ),
                                              onChanged: (val) {
                                                setState(() {
                                                  //  _searchShop();
                                                  // isSearch = true;
                                                  _text = true;
                                                  /* if(searchController.text != "") {getAllDataList(searchController.text);}
                                    if(searchController.text == "") {
                                                isSearchCountryId = false;
                                                isSearchDivision = false;
                                                isSearchSubdivision = false;
                                                isSearchState = false;
                                                searchState2 = '';
                                                searchDivision2 = '';
                                                searchSubdivision2 = '';
                                                searchCountryId2 = '';
                                                _seqType = '';
                                                _seqType2 = '';} */
                                                });
                                              },
                                            ),
                                          ),
                                          _text
                                              ? Container(
                                                  //height: 45.0,
                                                  //color: Colors.red,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child:
                                                      PopupMenuButton<String>(
                                                    onSelected: choiceAction,
                                                    icon: const Icon(
                                                      Icons
                                                          .more_vert, //Icons.filter_list,
                                                      color: Colors.grey,
                                                    ),
                                                    itemBuilder:
                                                        (BuildContext context) {
                                                      return OrderSortPrice.choices
                                                          .map((String choice) {
                                                        return PopupMenuItem<
                                                            String>(
                                                          value: choice,
                                                          child: Text(choice),
                                                        );
                                                      }).toList();
                                                    },
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    _isLoggedIn == true && _text == true
                                        ? Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                18, 5, 12, 2),
                                            alignment: Alignment.topLeft,
                                            child: const Text(
                                              'See results in your :',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: 'Proxima Nova',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.blue),
                                            ))
                                        : Container(),
                                    _isLoggedIn == true && _text == true
                                        ? Container(
                                            height: 25,
                                            margin: const EdgeInsets.fromLTRB(
                                                25, 5, 15, 10),
                                            child: ListView(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _seqType = '';
                                                      _seqType2 = '';
                                                      /* searchState2 = '';
                                    searchSubdivision2 = '';
                                    searchCountryId2 = '';
                                    searchDivision2 = searchDivision;
                                    isSearchDivision = true;*/
                                                    });

                                                    /// getAllDataList(searchController.text);
                                                  },
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 3, 5, 3),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(),
                                                          color:
                                                              //searchDivision2 != ''?
                                                              Colors.blue[500],
                                                          //: Colors.transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      child: const Text(
                                                          'Division')),
                                                ),
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _seqType = '';
                                                      _seqType2 = '';
                                                      /*searchState2 = '';
                                    searchDivision2 = '';
                                    searchCountryId2 = '';
                                    searchSubdivision2 = searchSubdivision;
                                    isSearchSubdivision = true;*/
                                                    });

                                                    /// getAllDataList(searchController.text);
                                                  },
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 3, 5, 3),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(),
                                                          color:
                                                              //searchSubdivision2!= ''?
                                                              Colors.blue[500],
                                                          // : Colors.transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      child: const Text(
                                                          'Subdivision')),
                                                ),
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _seqType = '';
                                                      _seqType2 = '';
                                                      /*searchDivision2 = '';
                                    searchSubdivision2 = '';
                                    searchCountryId2 = '';
                                    searchState2 = searchState;
                                    isSearchState = true;*/
                                                    });

                                                    /// getAllDataList(searchController.text);
                                                    //searchCountryId2 != '' || searchDivision2 != '' || searchSubdivision2!= '' || searchState2 != ''
                                                  },
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 3, 5, 3),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(),
                                                          color:
                                                              //searchState2 != ''?
                                                              Colors.blue[500],
                                                          //: Colors.transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      child:
                                                          const Text('State')),
                                                ),
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _seqType = '';
                                                      _seqType2 = '';
                                                      /*searchState2 = '';
                                    searchDivision2 = '';
                                    searchSubdivision2 = '';
                                    searchCountryId2 = searchCountryId;
                                    isSearchCountryId = true;*/
                                                    });

                                                    /// getAllDataList(searchController.text);
                                                  },
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 3, 5, 3),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(),
                                                          color:

                                                              ///searchCountryId2 != ''?
                                                              Colors.blue[500],

                                                          ///: Colors.transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      child: const Text(
                                                          'Country')),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    //:
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     //getAllDataList('');
                                    //     setState(() {
                                    //       isSearch = true;
                                    //       print('searching is $isSearch');
                                    //     });

                                    //       // Navigator.push(context,
                                    //       //     SlideLeftRoute(page: SearchPage()));
                                    //     //showSearch(context: context, delegate: Search(getAllList));
                                    //   },
                                    //   child: Container(
                                    //       margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                                    //       padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.all(Radius.circular(6)),
                                    //         color: Color(0XFFE1E1E1), //Colors.blueGrey[100],//
                                    //       ),
                                    //       child: Row(
                                    //         mainAxisAlignment: MainAxisAlignment.center,
                                    //         children: <Widget>[
                                    //           Icon(
                                    //             MyFlutterApp.search,
                                    //             color: Color(0XFF8F8F8F).withOpacity(0.8),
                                    //             size: 16,
                                    //           ),
                                    //           // Icon(
                                    //           //   Icons.search,
                                    //           //   color: Color(0XFF8F8F8F),
                                    //           //   size: 20,
                                    //           // ),
                                    //           SizedBox(width: 10),
                                    //           Text(
                                    //             'What are you looking for?',
                                    //             style: TextStyle(
                                    //                 fontFamily: 'Roboto',
                                    //                 fontSize: 14,
                                    //                 fontWeight: FontWeight.normal,
                                    //                 color: Theme.of(context)
                                    //                     .accentColor
                                    //                     .withOpacity(0.2)),
                                    //           ),
                                    //         ],
                                    //       )),
                                    // ),
                                    seeAll == true
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                seeAll = false;
                                                seeAllCloths = false;
                                                seeAllServices = false;
                                              });
                                            },
                                            onDoubleTap: () {
                                              setState(() {
                                                seeAll = false;
                                                seeAllCloths = false;
                                                seeAllServices = false;
                                              });
                                            },
                                            onLongPress: () {
                                              setState(() {
                                                seeAll = false;
                                                seeAllCloths = false;
                                                seeAllServices = false;
                                              });
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  15, 14, 0, 5),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.arrow_back_ios,
                                                    color: appColor,
                                                    size: 16,
                                                  ),
                                                  Icon(
                                                    Icons.arrow_back_ios,
                                                    color: appColor,
                                                    size: 16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ]))),

                          /////////////// Search End ///////////////
                          // isSearch == true
                          //     ? noSearchData
                          //         ? SliverToBoxAdapter(
                          //             child: Container(
                          //                 child: Center(
                          //                     child: Container(
                          //                         alignment: Alignment.center,
                          //                   height: 170,
                          //                         margin: const EdgeInsets.only(top: 80),
                          //                         //color: Colors.red,
                          //                         child: Column(
                          //                           children: <Widget>[
                          //                             /*Image.asset(
                          //                               'assets/image/photo_placeholder.png',
                          //                               width: 80,
                          //                               height: 100,
                          //                               fit: BoxFit.contain,
                          //                             ),*/
                          //                             Text(searchController.text == ""? "Search with cloth or service\'s name" : "No match found for ${searchController.text} !!"),
                          //                           ],
                          //                         )))))
                          //         : SliverPadding(
                          //             padding: const EdgeInsets.all(5),
                          //             sliver: Container(
                          //               child: SliverGrid(
                          //                 gridDelegate:
                          //                     const SliverGridDelegateWithFixedCrossAxisCount(
                          //                         crossAxisCount: 2,
                          //                         childAspectRatio: 0.85,
                          //                         mainAxisSpacing: 2.5,
                          //                         crossAxisSpacing: 0.0),
                          //                 delegate: SliverChildBuilderDelegate(
                          //                   (BuildContext context, int index) {
                          //                     return
                          //                         //         getAllList == null
                          //                         // ? Center(
                          //                         //                 child: Container(
                          //                         //                     margin: EdgeInsets.only(top: 30),
                          //                         //                     child: CircularProgressIndicator()))
                          //                         //             : getAllList.length == 0
                          //                         //                 ? Center(
                          //                         //                     child: Container(
                          //                         //                         alignment: Alignment.center,
                          //                         //                   height: 170,
                          //                         //                         color: Colors.red,
                          //                         //                         child:
                          //                         //                             Text("${getAllMsg[index]}")))
                          //                         //                 :
                          //                         Container(
                          //                             margin: const EdgeInsets.only(
                          //                                 bottom: 5,
                          //                                 top: 5,
                          //                                 left: 5.5,
                          //                                 right: 5.5),
                          //                             decoration: BoxDecoration(
                          //                                 color: Colors.white,
                          //                                 borderRadius: const BorderRadius.all(
                          //                                     Radius.circular(6)),
                          //                                 boxShadow: [
                          //                                   BoxShadow(
                          //                                     blurRadius: 2,
                          //                                     color: const Color(0XFF000000)
                          //                                         .withOpacity(0.16),
                          //                                     //offset: Offset(6.0, 7.0),
                          //                                   ),
                          //                                 ]),
                          //                             child: SearchCard(getAllList[index]));
                          //                   },
                          //                   childCount: getAllList == null? 0 : getAllList.length,
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          // : seeAll == true //seeAllCloths == true
                          //     ? seeAllCloths == true
                          //         ? clothList == null?
                          //         SliverToBoxAdapter(
                          //         child: Container(
                          //             child: Center(
                          //                 child: Container(
                          //                     alignment: Alignment.center,
                          //               height: 170,
                          //                     margin: const EdgeInsets.only(top: 80),
                          //                     //color: Colors.red,
                          //                     child: Column(
                          //                       children: <Widget>[
                          //                         Image.asset(
                          //                           'assets/image/photo_placeholder.png',
                          //                           width: 80,
                          //                           height: 100,
                          //                           fit: BoxFit.contain,
                          //                         ),
                          //                         const Text("No cloth data found !!!"),
                          //                       ],
                          //                     )))))
                          //                     :
                          SliverPadding(
                            padding: const EdgeInsets.all(12),
                            sliver:
                                // clothList == null
                                //     ? Center(
                                //         child: Container(
                                //             margin: EdgeInsets.only(top: 30),
                                //             child: CircularProgressIndicator()))
                                //     : clothList.length == 0
                                //         ? Center(
                                //             child: Container(
                                //                 alignment: Alignment.center,
                                //           height: 170,
                                //                 child:
                                //                     Text("No cloth data found!")))
                                //         :
                                Container(
                              child: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? SliverGrid(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.85,
                                              mainAxisSpacing: 4.5,
                                              crossAxisSpacing: 5.0),
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5,
                                                  top: 5,
                                                  left: 6.5,
                                                  right: 6.5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(6)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 2,
                                                      color: const Color(
                                                              0XFF000000)
                                                          .withOpacity(0.16),
                                                      //offset: Offset(6.0, 7.0),
                                                    ),
                                                  ]),
                                              child: PopularProductCard(
                                                //index
                                                  clothList[index]
                                                  ));
                                        },
                                        childCount: clothList.length, // 5,
                                      ),
                                    )
                                  : //,
                                  SliverGrid(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              childAspectRatio: 0.9,
                                              mainAxisSpacing: 4.5,
                                              crossAxisSpacing: 0.0),
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5,
                                                  top: 5,
                                                  left: 6.5,
                                                  right: 6.5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(6)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 2,
                                                      color: const Color(
                                                              0XFF000000)
                                                          .withOpacity(0.16),
                                                      //offset: Offset(6.0, 7.0),
                                                    ),
                                                  ]),
                                              child:
                                                  PopularProductCardLandscape(
                                                      //index
                                                      clothList[index]
                                                      ));
                                        },
                                        childCount: clothList.length, // 5,
                                      ),
                                    ),
                            ),
                          ),
                          // : serviceList == null? SliverToBoxAdapter(
                          // child: Container(
                          //     child: Center(
                          //         child: Container(
                          //             alignment: Alignment.center,
                          //       height: 170,
                          //             margin: const EdgeInsets.only(top: 80),
                          //             //color: Colors.red,
                          //             child: Column(
                          //               children: <Widget>[
                          //                 Image.asset(
                          //                   'assets/image/photo_placeholder.png',
                          //                   width: 80,
                          //                   height: 100,
                          //                   fit: BoxFit.contain,
                          //                 ),
                          //                 const Text("No service data found !!!"),
                          //               ],
                          //             )))))
                          //             :
                          /*SliverPadding(
                    padding: const EdgeInsets.all(5),
                    sliver:
                        // serviceList == null
                        //     ? Center(
                        //         child: Container(
                        //             margin: EdgeInsets.only(top: 30),
                        //             child: CircularProgressIndicator()))
                        //     : serviceList.length == 0
                        //         ? Center(
                        //             child: Container(
                        //                 alignment: Alignment.center,
                        //           height: 170,
                        //                 child:
                        //                     Text("No service data found!")))
                        //         :
                        Container(
                      child: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.9,
                                      mainAxisSpacing: 2.5,
                                      crossAxisSpacing: 0.0),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 5,
                                          top: 5,
                                          left: 5.5,
                                          right: 5.5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 2,
                                              color: const Color(0XFF000000)
                                                  .withOpacity(0.16),
                                              //offset: Offset(6.0, 7.0),
                                            ),
                                          ]),
                                      child: PopularServiceCard(index
                                          //serviceList[index]
                                          ));
                                },
                                childCount: 5,//serviceList.length,
                              ),
                            )
                          : //,
                          SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 0.9,
                                      mainAxisSpacing: 4.5,
                                      crossAxisSpacing: 0.0),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 5,
                                          top: 5,
                                          left: 5.5,
                                          right: 5.5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 2,
                                              color: const Color(0XFF000000)
                                                  .withOpacity(0.16),
                                              //offset: Offset(6.0, 7.0),
                                            ),
                                          ]),
                                      child: PopularProductCardLandscape(index
                                         // serviceList[index]
                                          ));
                                },
                                childCount: 5, //serviceList.length,
                              ),
                            ),
                    ),
                  )
                  */
                          ///

                          ///:
                          SliverToBoxAdapter(
                              child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(2, 0, 2, 20),
                                  child: Column(
                                    children: const <Widget>[
                                      ///////// Popular Services //////
                                      /* Container(
                                    margin: const EdgeInsets.only(top: 25, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(left: 20),
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Popular Services",
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Proxima Nova',
                                                color:
                                                    Theme.of(context).accentColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right: 15),
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                seeAll = true;
                                                seeAllServices = true;
                                                print(seeAllServices);
                                              });
                                              // Navigator.push(context,
                                              //     SlideLeftRoute(page: AllNewArrivalProduct()));
                                            },
                                            child: Text(
                                              "See  All",
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Proxima Nova',
                                                  color: appColor,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ),
                                        )
                                        // : Container(),
                                        // Container(
                                        //     child: Icon(
                                        //   Icons.keyboard_arrow_right,
                                        //   color: Color(0XFF09324B),
                                        //   size: 20,
                                        // )),
                                      ],
                                    ),
                                  ),

                                  ///////// Popular Services List //////

                                  popularServiceList == null
                                      ? Center(
                                          child: Container(
                                              margin: const EdgeInsets.only(top: 50, bottom: 50),
                                              child: const CircularProgressIndicator()))
                                      : popularServiceList.length == 0
                                          ? Center(
                                              child: Container(
                                                  alignment: Alignment.center,
                                            height: 170,
                                                  child: const Text(
                                                      "No service data found!")))
                                          :
                                          // seeAllServices == false?
                                            MediaQuery.of(context).orientation ==
                                                      Orientation.portrait
                                                  ?Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3.5, // 200,
                                              //color: Colors.red,
                                              width:
                                                  MediaQuery.of(context).size.width,
                                              margin: const EdgeInsets.only(left: 8),
                                              child:
                                                  /////////// Popular Services Portrait start //////

                                                  ListView.builder(
                                                physics: const BouncingScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (BuildContext context,
                                                        int index) =>
                                                    Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10, top: 5, left: 10),
                                                  // decoration: BoxDecoration(
                                                  //   color: Colors.white,
                                                  //   borderRadius: BorderRadius.only(
                                                  //       bottomLeft: Radius.circular(10),
                                                  //       bottomRight: Radius.circular(10)),
                                                  // ),
                                                  child: PopularServiceCard(
                                                      popularServiceList[index]),
                                                ),
                                                itemCount:
                                                    popularServiceList.length, //7,
                                              )

                                              )
                                              /////////// Popular Services Portrait end //////
                                              :
                                              //   /////////// Popular Services Landscape start //////

                                              Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2, // 200,
                                              //color: Colors.red,
                                              width:
                                                  MediaQuery.of(context).size.width,
                                              margin: const EdgeInsets.only(left: 8),
                                              child:

                                                  ListView.builder(
                                                physics: const BouncingScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (BuildContext context,
                                                        int index) =>
                                                    Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10, top: 5, left: 10),
                                                  // decoration: BoxDecoration(
                                                  //   color: Colors.white,
                                                  //   borderRadius: BorderRadius.only(
                                                  //       bottomLeft: Radius.circular(10),
                                                  //       bottomRight: Radius.circular(10)),
                                                  // ),
                                                  child: PopularServiceCardLandscape(
                                                      popularServiceList[index]),
                                                ),
                                                itemCount:
                                                    popularServiceList.length, //7,
                                              )
                                              ),
                                              */
                                      /////////// Popular Services end ///////////

                                      ///////// Popular cloths //////
                                      /*
                                  Container(
                                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(left: 20),
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Popular cloths",
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Proxima Nova',
                                                color:
                                                    Theme.of(context).accentColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right: 15),
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                seeAll = true;
                                                seeAllcloths = true;
                                                print(seeAllcloths);
                                              });
                                              // Navigator.push(context,
                                              //     SlideLeftRoute(page:  SeeAllcloths()));
                                            },
                                            child: Text(
                                              "See  All",
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Proxima Nova',
                                                  color: appColor,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //     child: Icon(
                                        //   Icons.keyboard_arrow_right,
                                        //   color: Color(0XFF09324B),
                                        //   size: 20,
                                        // )),
                                      ],
                                    ),
                                  ),
                                  */

                                      ///////// Popular cloths List //////
                                      /*
                                  popularclothList == null
                                      ? Center(
                                          child: Container(
                                              margin: const EdgeInsets.only(top: 50, bottom: 50),
                                              child: const CircularProgressIndicator()))
                                      : popularclothList.length == 0
                                          ? Center(
                                              child: Container(
                                                  alignment: Alignment.center,
                                            height: 170,
                                                  child: const Text(
                                                      "No cloth data found!")))
                                          :
                                            MediaQuery.of(context).orientation ==
                                                      Orientation.portrait
                                                  ?
                                          Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3.3, //200,
                                              //color: Colors.white,
                                              width:
                                                  MediaQuery.of(context).size.width,
                                              margin: const EdgeInsets.only(left: 8),
                                              child:

                                                  /////////// Popular cloths Portrait start //////

                                                  ListView.builder(
                                                physics: const BouncingScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (BuildContext context,
                                                        int index) =>
                                                    Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5, top: 5, left: 10),
                                                  // decoration: BoxDecoration(
                                                  //   color: Colors.white,
                                                  //   borderRadius: BorderRadius.only(
                                                  //       bottomLeft: Radius.circular(10),
                                                  //       bottomRight: Radius.circular(10)),
                                                  // ),
                                                  child: PopularclothCard(
                                                      popularclothList[index]),
                                                ),
                                                itemCount:
                                                    popularclothList.length, //7,
                                              )

                                              )
                                               /////////// Popular cloths Portrait end //////
                                              :
                                               //   /////////// Popular cloths Landscape start //////
                                              Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2, //200,
                                              //color: Colors.white,
                                              width:
                                                  MediaQuery.of(context).size.width,
                                              margin: const EdgeInsets.only(left: 8),
                                              child:

                                                  ListView.builder(
                                                physics: const BouncingScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (BuildContext context,
                                                        int index) =>
                                                    Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5, top: 5, left: 10),
                                                  // decoration: BoxDecoration(
                                                  //   color: Colors.white,
                                                  //   borderRadius: BorderRadius.only(
                                                  //       bottomLeft: Radius.circular(10),
                                                  //       bottomRight: Radius.circular(10)),
                                                  // ),
                                                  child: PopularclothCardLandscape(
                                                      popularclothList[index]),
                                                ),
                                                itemCount:
                                                    popularclothList.length, //7,
                                              )
                                              ),
                                              */
                                      ///////////////// popular cloth end ///////////////////
                                    ],
                                  )))

                          ///
                        ]),
                  ),
                ),
                // floatingActionButton: isSearch
                //     ? Container()
                //     : Container(
                //         margin: const EdgeInsets.only(bottom: 10),
                //         padding: const EdgeInsets.fromLTRB(3, 2, 2, 2),
                //         decoration: BoxDecoration(
                //           color: appColor,
                //           borderRadius: const BorderRadius.all(Radius.circular(25)),
                //           boxShadow: [
                //             BoxShadow(
                //               color: const Color(0XFF373740).withOpacity(0.2),
                //               blurRadius: 6,
                //             )
                //           ],
                //         ),
                //         width:
                //             MediaQuery.of(context).orientation == Orientation.portrait
                //                 ? MediaQuery.of(context).size.width / 2.09
                //                 : MediaQuery.of(context).size.width / 3.09,
                //         height: 50,
                //         // alignment: Alignment.bottomRight,
                //         child: FlatButton(
                //           onPressed: () {
                //             /* if (_isLoggedIn == true) {
                //               Navigator.push(
                //                   context, SlideLeftRoute(page: SellYourStuffForm()));
                //             } else {
                //               loginFromWhere = 'sellYourStuff';
                //               Navigator.push(context,
                //                   SlideLeftRoute(page: LoginForm(loginFromWhere)));
                //               // _isLoggedIn ? Navigator.push(context, SlideLeftRoute(page: SellYourStuffForm())) :
                //               // Navigator.push(context, SlideLeftRoute(page: LoginForm()));
                //             }*/
                //           },
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: <Widget>[
                //               Expanded(
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: <Widget>[
                //                     Center(
                //                       child: Icon(Icons.call,
                //                           color: Colors.white.withOpacity(0.9),
                //                           size: 18),
                //                     ),
                //                     const SizedBox(width: 8),
                //                     Text(
                //                       'Call Your Tailor',
                //                       overflow: TextOverflow.visible,
                //                       style: TextStyle(
                //                           fontSize: 16,
                //                           fontFamily: 'Proxima Nova',
                //                           color: Colors.white.withOpacity(0.9),
                //                           fontWeight: FontWeight.normal),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
              ) //,kk
            : bottomNavIndex == 1
                ? BottomNavigationPage(1)
                : bottomNavIndex == 2
                    ? BottomNavigationPage(2)
                    : bottomNavIndex == 3
                        ? BottomNavigationPage(3)
                        : BottomNavigationPage(4));
  }

  Future<bool> _onWillPop2() async {
    Navigator.push(context, SlideLeftRoute(page: BottomNavigationPage(0)));
    return false;
    // WillPopScope(
    //       onWillPop: _onWillPop,
  }

  Future<Object> _onWillPop() async {
    return (Container());
  }
  /* Future<bool> _onWillPop() async {
    return ( 
      showDialog(
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
        )
        ) ??
        false;}*/

  void selection(int num) {
    num == 1
        ? showDialog(
            ////////////////////////   Filter By Status Dialog   /////////////////////
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                  //contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  title: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(top: 5, bottom: 12),
                            child: new Text("Select Status")),
                        Divider(
                          height: 0,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                  content: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            // height: 450,
                            //padding: EdgeInsets.only(left: 5),
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: clothList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 0),
                                        onTap: () {
                                          setState(() {
                                            // statusSelect2 = status[index];
                                            // isRefresh = true;
                                            // print('isRefresh');
                                            // print(isRefresh);
                                            // print(statusSelect2);
                                            // _showSearchStatus();
                                            Navigator.of(context).pop();
                                            // selection(2);
                                          });
                                        },
                                        leading: Container(
                                            child: const Text(
                                          'status[index]',
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      );
                                    },
                                  )),
                      ],
                    ),
                  ));
            },
          )
        : showDialog(
            /////////////////////////////   Sort By Price Dialog    /////////////////////////
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                contentPadding: const EdgeInsets.all(5),
                title: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child: new Text(
                              "Sort by Price",
                              style: TextStyle(color: Colors.grey[600]),
                            )),
                        Divider(
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        ////////////   Sort  start ///////////

                        Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                                left: 25, top: 5, bottom: 8),
                            child: Text("Sort",
                                textAlign: TextAlign.left,
                                style:
                                    TextStyle(color: appColor, fontSize: 13))),

                        ////////////   Sort Dropdown ///////////

                        Container(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          margin: const EdgeInsets.only(
                              bottom: 15, left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.grey[100],
                              border:
                                  Border.all(width: 0.2, color: Colors.grey)),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(

                                  //color: Colors.red,
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 25,
                                              color: Color(0xFFC5C2C7)),
                                          items: _type
                                              .map((String dropDownStringItem) {
                                            return DropdownMenuItem<String>(
                                                value: dropDownStringItem,
                                                child: Text(
                                                  dropDownStringItem,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.grey[600]),
                                                ));
                                          }).toList(),
                                          onChanged:
                                              (String? newValueSelected) {
                                            _typeDropDownSelected(
                                                newValueSelected!);
                                          },
                                          value: _currentTypeSelected,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                            ],
                          ),
                        ),

                        ////////////   Sort end ///////////
                      ],
                    ),
                  ],
                ),
                content: Container(
                    height: 70,
                    width: 250,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              width: 110,
                              height: 45,
                              margin: const EdgeInsets.only(
                                top: 25,
                                bottom: 15,
                              ),
                              child: ElevatedButton(
                                child: new Text(
                                  "Ok",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                //color: Colors.white,
                                onPressed: () {
                                  if (_seqType == '') {
                                    _seqType = '1';
                                    _seqType2 = '';
                                    Navigator.of(context).pop();

                                    /// getAllDataList(searchController.text);
                                  } else {
                                    _seqType2 = '';
                                    Navigator.of(context).pop();

                                    ///   getAllDataList(searchController.text);
                                    // isRefresh = true;
                                    // print('isRefresh');
                                    // print(isRefresh);
                                    ///////////////// _showOrderDetails();
                                  }
                                },
                                // borderSide: BorderSide(
                                //     color: Colors.black, width: 0.5),
                                // shape: new RoundedRectangleBorder(
                                //     borderRadius:
                                //         new BorderRadius.circular(20.0)),
                              )),
                        ])),
              );
            },
          );
  }
}
