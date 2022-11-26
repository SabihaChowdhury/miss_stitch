import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miss_stitch/main.dart';
import 'package:miss_stitch/models/orderSort.dart';
import 'package:miss_stitch/screens/Home/outfit.dart';
import 'package:miss_stitch/screens/Model/AllTailorModel/AllTailorModel.dart';
import 'package:miss_stitch/screens/Profile/profile.dart';
import 'package:miss_stitch/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api/registerApi.dart';
import '../../routeTransition/routeTransition.dart';
import '../bottomNavigation.dart';
import 'PopularProduct/popularProductCard.dart';
import 'PopularProduct/popularProductCardLandscape.dart';
import 'PopularServices/popularServiceCard.dart';
import 'PopularServices/popularServiceCardLandscape.dart';
import 'Search/searchCard.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  bool _text = false;
  bool _isLoading = false;

  bool _isLoggedIn = false;
  bool seeAll = false,
      seeAllServices = false,
      seeAllProducts = false,
      isSearch = false,
      noSearchData = false;
  var body, serviceBody, serviceList = [], productBody, productList = [], bodyS;
  var getAllBody, getAllList;
  var popularProductBody,
      popularProductList,
      popularServiceBody,
      popularServiceList;

  var serviceMsg = "", productMsg = "", getAllMsg = "";
  var searchDivision = "", searchSubdivision = "", searchState = "", searchCountryId = "";
  var searchDivision2 = "", searchSubdivision2 = "", searchState2 = "", searchCountryId2 = "";
  bool isSearchDivision = false, isSearchSubdivision = false, isSearchState = false, isSearchCountryId = false;

  var userData;
  var userToken;

  @override
  void initState() {
    /*_checkIfLoggedIn();
    getAllServiceList();
    getAllProductList();
    getPopularProductList();
    getPopularServiceList();*/
    _checkIfLoggedIn();
    getAllProductList();
    /// productList.length = 5;
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


  /////////////// get allProduct api ///////////
  Future _getLocalAllProductData(key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localallProductData = localStorage.getString(key);
    if (localallProductData != null) {
      productBody = json.decode(localallProductData);
      // print('dmjsvgd hdsftrstfgdhjs');
      // print(productBody);
      _allProductState();
    }
  }

  void _allProductState() {
    // print('sjshdvchbd');
    // print(productBody);
    if(productBody != null) {
       print('issue with model');
      //var productdata = AllProductModel.fromJson(productBody);
      final product = json.decode(productBody);
       print(product);

      var productdata = AllTailorModel.fromJson(product);
      //productList = productdata.product;
    if (!mounted) return;
    setState(() {
      productList = productdata.data;
    });
    }
    // var productdata = AllProductModel.fromJson(productBody);
    // if (productdata != null) {
    // if (!mounted) return;
    // setState(() {
    //   productList = productdata.product;
    // });
    // }
  }

  Future<void> getAllProductList() async {
    var keyProduct = 'all-product-list';
    await _getLocalAllProductData(keyProduct);

    var res = await CallApi().getData('/api/tailors/all');
    productBody = json.decode(res.body);
     print(productBody);
    print(res.statusCode);

    if (res.statusCode == 200) {
      var productcontent = res.body;
      final product = json.decode(productcontent);
      // print(product);

      var productdata = AllTailorModel.fromJson(product);
      productList = productdata.data;

      if (productList != null) {
        if (!mounted) return;
        setState(() {
          //  String dd = productList.created_at;
          //  var spDate = dd.split(" ");
          //  alertDate = spDate[0];
          // situation = productList.situation;
          print('productList');
          print(productList);
        });
        // print(product);
      } else {
        setState(() {
          productMsg = "No product data available!";
        });
      }

      print("productList.length");
      print(productList.length);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(keyProduct, json.encode(productcontent));
    }
  }

 

  ////////////// get allData api ////////////
  Future<void> getAllDataList(val) async {
    // var res;
    // _seqType != '' || _seqType2 != ''?
    // searchCountryId2 != '' || searchDivision2 != '' || searchSubdivision2!= '' || searchState2 != ''?
    // res = await CallApi().getData1('/app/getAll?str=$val&price=$_seqType&rate=$_seqType2&countryId=$searchCountryId2&div=$searchDivision2&subDiv=$searchSubdivision2&state=$searchState2') :
    // res = await CallApi().getData1('/app/getAll?str=$val&price=$_seqType&rate=$_seqType2') :
    // //isSearchCountryId == true || isSearchDivision == true || isSearchSubdivision == true || isSearchState == true?
    // searchCountryId2 != '' || searchDivision2 != '' || searchSubdivision2!= '' || searchState2 != ''?
    // res = await CallApi().getData1('/app/getAll?str=$val&countryId=$searchCountryId2&div=$searchDivision2&subDiv=$searchSubdivision2&state=$searchState2') :
    // res = await CallApi().getData1('/app/getAll?str=$val');
    // getAllBody = json.decode(res.body);
    // print(getAllBody);
    // print(res.statusCode);

    // if (res.statusCode == 200) {
    //   var getAllcontent = res.body;
    //   final getAll = json.decode(getAllcontent);
    //   print(getAll);

    //   var getAlldata = GetAllModel.fromJson(getAll);
    //   getAllList = getAlldata.alldata;

    //   if (getAllList.length != 0) {
    //     if (!mounted) return;
    //     setState(() {
    //       //  String dd = getAllList.created_at;
    //       //  var spDate = dd.split(" ");
    //       //  alertDate = spDate[0];
    //       // situation = getAllList.situation;
    //       //  _searchShop();
    //       isSearch = true;
    //       noSearchData = false;
    //       print('getAllList');
    //       print(getAllList);
    //     });
    //     print(getAll);
    //   } else {
    //     setState(() {
    //       isSearch = true;
    //       noSearchData = true;
    //       getAllMsg = "No data available!";
    //       print('dhjc fdgf gddhhjd $noSearchData');
    //     });
    //   }

    //   print("getAllList.length");
    //   print(getAllList.length);
    // }
  }

  Future<void> _refreshData() async{
   /// getAllServiceList();
    getAllProductList();
   /// getPopularProductList();
   /// getPopularServiceList();
  }

  // /////////////// get allProduct api ///////////
  // Future<void> getAllProductList() async {
  //   var res = await CallApi().getData('/app/getAllProduct');
  //   productBody = json.decode(res.body);
  //   print(productBody);
  //   print(res.statusCode);

  //   if (res.statusCode == 200) {
  //     var productcontent = res.body;
  //     final product = json.decode(productcontent);
  //     print(product);

  //     var productdata = AllProductModel.fromJson(product);
  //     productList = productdata.product;

  //     if (productList != null) {
  //       if (!mounted) return;
  //       setState(() {
  //         //  String dd = productList.created_at;
  //         //  var spDate = dd.split(" ");
  //         //  alertDate = spDate[0];
  //         // situation = productList.situation;
  //         print('productList');
  //         print(productList);
  //       });
  //       print(product);
  //     } else {
  //       setState(() {
  //         productMsg = "No product data available!";
  //       });
  //     }

  //     print("productList.length");
  //     print(productList.length);
  //   }
  // }

  // ////////////// get PopularService api ////////////
  // Future<void> getPopularServiceList() async {
  //   var res = await CallApi().getData('/app/getMostViewedService');
  //   popularServiceBody = json.decode(res.body);
  //   // print(popularServiceBody);
  //   print(res.statusCode);

  //   if (res.statusCode == 200) {
  //     var servicecontent = res.body;
  //     final service = json.decode(servicecontent);
  //     print(service);

  //     var servicedata = PopularServiceModel.fromJson(service);
  //     popularServiceList = servicedata.services;

  //     if (popularServiceList != null) {
  //       if (!mounted) return;
  //       setState(() {
  //         //  String dd = popularServiceList.created_at;
  //         //  var spDate = dd.split(" ");
  //         //  alertDate = spDate[0];
  //         // situation = popularServiceList.situation;
  //         print('popularServiceList');
  //         print(popularServiceList);
  //       });
  //       //print(service);
  //     } else {
  //       setState(() {
  //         serviceMsg = "No service data available!";
  //       });
  //     }

  //     print("popularServiceList.length");
  //     print(popularServiceList.length);
  //   }
  // }

  // ////////////// get PopularProduct api ///////////
  // Future<void> getPopularProductList() async {
  //   var res = await CallApi().getData('/app/getMostViewedProduct');
  //   popularProductBody = json.decode(res.body);
  //   //print(popularProductBody);
  //   print(res.statusCode);

  //   if (res.statusCode == 200) {
  //     var productcontent = res.body;
  //     final product = json.decode(productcontent);
  //     print(product);

  //     var productdata = PopularServiceModel.fromJson(product);
  //     popularProductList = productdata.services;

  //     if (popularProductList != null) {
  //       if (!mounted) return;
  //       setState(() {
  //         //  String dd = popularProductList.created_at;
  //         //  var spDate = dd.split(" ");
  //         //  alertDate = spDate[0];
  //         // situation = popularProductList.situation;
  //         print('popularProductList');
  //         print(popularProductList);
  //       });
  //       //print(product);
  //     } else {
  //       setState(() {
  //         productMsg = "No product data available!";
  //       });
  //     }

  //     print("popularProductList.length");
  //     print(popularProductList.length);
  //   }
  // }

  // ////////////// get allData api ////////////
  // Future<void> getAllDataList(val) async {
  //   var res = await CallApi().getData1('/app/getAll?str=$val');
  //   getAllBody = json.decode(res.body);
  //   print(getAllBody);
  //   print(res.statusCode);

  //   if (res.statusCode == 200) {
  //     var getAllcontent = res.body;
  //     final getAll = json.decode(getAllcontent);
  //     print(getAll);

  //     var getAlldata = GetAllModel.fromJson(getAll);
  //     getAllList = getAlldata.alldata;

  //     if (getAllList.length != 0) {
  //       if (!mounted) return;
  //       setState(() {
  //         //  String dd = getAllList.created_at;
  //         //  var spDate = dd.split(" ");
  //         //  alertDate = spDate[0];
  //         // situation = getAllList.situation;
  //         //  _searchShop();
  //         isSearch = true;
  //         noSearchData = false;
  //         print('getAllList');
  //         print(getAllList);
  //       });
  //       print(getAll);
  //     } else {
  //       setState(() {
  //         isSearch = true;
  //         noSearchData = true;
  //         getAllMsg = "No data available!";
  //         print('dhjc fdgf gddhhjd $noSearchData');
  //       });
  //     }

  //     print("getAllList.length");
  //     print(getAllList.length);
  //   }
  // }

  void choiceAction(String choice) {
    if (choice == OrderSortCity.citySort) {
      selection(2);
    }
    /*if (choice == OrderSort.citySort) {
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
    }*/
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
  var _genderType = ['Tailor', 'Outfit'];
  var _currentTypeSelected = 'low to high';
  var _currentGenderTypeSelected = 'Tailor';

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
      if (newValueSelected == 'Outfit') {
        Navigator.push(context, SlideLeftRoute(page: Outfit()));
      } else {
        Navigator.push(context, SlideLeftRoute(page: BottomNavigationPage(0)));
      }
      // if (newValueSelected == 'Outfit') {
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



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:

          ///isSearch == true || seeAll == true?
          _onWillPop2,
      //:
      // _onWillPop,
      child: Scaffold(
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
                  Icons.exit_to_app,
                  size: 20,
                  color: Colors.black54,
                ),
                onPressed: () {
                  _showDialog(context);
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
                          margin: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                          child: Column(children: <Widget>[
                            //////////  Tailor/Outfit Option Start ///////////
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 5, 8, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                      ),
                                      // width: MediaQuery.of(context).size.width / 2,
                                      margin: const EdgeInsets.only(
                                          bottom: 0, left: 15, right: 20),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0)),
                                          color: Colors.grey[200],
                                          border: Border.all(
                                              width: 0.2, color: Colors.grey)),
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(

                                              //color: Colors.red,
                                              child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    isExpanded: true,
                                                    icon: const Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        size: 25,
                                                        color:
                                                            Color(0xFFC5C2C7)),
                                                    items: _genderType.map(
                                                        (String
                                                            dropDownStringItem) {
                                                      return DropdownMenuItem<
                                                              String>(
                                                          value:
                                                              dropDownStringItem,
                                                          child: Text(
                                                            dropDownStringItem,
                                                            textAlign:
                                                                TextAlign.left,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                            Icons.sort, //Icons.filter_list,
                                            color: Colors.black54,
                                          ),
                                          itemBuilder: (BuildContext context) {
                                            return OrderSortCity.choices
                                                .map((String choice) {
                                              return PopupMenuItem<String>(
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
                              margin:
                                  const EdgeInsets.only(right: 15, left: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      autofocus: false,
                                      //textAlign: TextAlign.center,
                                      cursorColor: Colors.grey,
                                      controller: searchController,
                                      textInputAction: TextInputAction.search,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: _text
                                              ? const EdgeInsets.only(
                                                  left: 20.0, right: 10)
                                              : const EdgeInsets.only(
                                                  left: 75.0, right: 15),
                                          child: const Icon(
                                            Icons.search,
                                            color: Colors.black38,
                                            size: 21,
                                          ),
                                        ),
                                        hintText: 'Enter Designer\'s name',
                                        hintStyle: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black38,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.only(
                                            left: 15.0, top: 10.0),
                                        suffixIcon: _text
                                            ? IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _text = false;
                                                    isSearch = false;
                                                    noSearchData = false;
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
                                                    searchController.text = "";
                                                  });
                                                  // store.dispatch(CheckFilter(false));
                                                  //   _displayShops();
                                                },
                                                icon: const Icon(Icons.cancel),
                                                color: Colors.grey,
                                              )
                                            : const Icon(
                                                Icons.cancel,
                                                color: Colors.transparent,
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
                                  // _text
                                  //     ? Container(
                                  //         //height: 45.0,
                                  //         //color: Colors.red,
                                  //         padding: const EdgeInsets.fromLTRB(
                                  //             0, 0, 0, 0),
                                  //         child: PopupMenuButton<String>(
                                  //           onSelected: choiceAction,
                                  //           icon: const Icon(
                                  //             Icons
                                  //                 .more_vert, //Icons.filter_list,
                                  //             color: Colors.grey,
                                  //           ),
                                  //           itemBuilder:
                                  //               (BuildContext context) {
                                  //             return OrderSort.choices
                                  //                 .map((String choice) {
                                  //               return PopupMenuItem<String>(
                                  //                 value: choice,
                                  //                 child: Text(choice),
                                  //               );
                                  //             }).toList();
                                  //           },
                                  //         ),
                                  //       )
                                  //     : Container(),
                                ],
                              ),
                            ),
                            _isLoggedIn == true && _text == true
                                ? Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(18, 5, 12, 2),
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 3, 5, 3),
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color:
                                                      //searchDivision2 != ''?
                                                      Colors.blue[500],
                                                  //: Colors.transparent,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: const Text('Division')),
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 3, 5, 3),
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color:
                                                      //searchSubdivision2!= ''?
                                                      Colors.blue[500],
                                                  // : Colors.transparent,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: const Text('Subdivision')),
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 3, 5, 3),
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color:
                                                      //searchState2 != ''?
                                                      Colors.blue[500],
                                                  //: Colors.transparent,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: const Text('State')),
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 3, 5, 3),
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color:

                                                      ///searchCountryId2 != ''?
                                                      Colors.blue[500],

                                                  ///: Colors.transparent,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: const Text('Country')),
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
                                        seeAllProducts = false;
                                        seeAllServices = false;
                                      });
                                    },
                                    onDoubleTap: () {
                                      setState(() {
                                        seeAll = false;
                                        seeAllProducts = false;
                                        seeAllServices = false;
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        seeAll = false;
                                        seeAllProducts = false;
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
                  //                             Text(searchController.text == ""? "Search with product or service\'s name" : "No match found for ${searchController.text} !!"),
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
                  // : seeAll == true //seeAllProducts == true
                  //     ? seeAllProducts == true
                  //         ? productList == null?
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
                  //                         const Text("No product data found !!!"),
                  //                       ],
                  //                     )))))
                  //                     :
                  SliverPadding(
                    padding: const EdgeInsets.all(12),
                    sliver:
                        // productList == null
                        //     ? Center(
                        //         child: Container(
                        //             margin: EdgeInsets.only(top: 30),
                        //             child: CircularProgressIndicator()))
                        //     : productList.length == 0
                        //         ? Center(
                        //             child: Container(
                        //                 alignment: Alignment.center,
                        //           height: 170,
                        //                 child:
                        //                     Text("No product data found!")))
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
                                      child: PopularServiceCard(
                                        //index
                                          productList[index]
                                          ));
                                },
                                childCount: productList.length, // 5,
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
                                      child: PopularServiceCardLandscape(
                                        //index
                                          productList[index]
                                          ));
                                },
                                childCount: productList.length, // 5,
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
                          margin: const EdgeInsets.fromLTRB(2, 0, 2, 20),
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

                              ///////// Popular Products //////
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
                                            "Popular Products",
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
                                                seeAllProducts = true;
                                                print(seeAllProducts);
                                              });
                                              // Navigator.push(context,
                                              //     SlideLeftRoute(page:  SeeAllProducts()));
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

                              ///////// Popular Products List //////
                              /*
                                  popularProductList == null
                                      ? Center(
                                          child: Container(
                                              margin: const EdgeInsets.only(top: 50, bottom: 50),
                                              child: const CircularProgressIndicator()))
                                      : popularProductList.length == 0
                                          ? Center(
                                              child: Container(
                                                  alignment: Alignment.center,
                                            height: 170,
                                                  child: const Text(
                                                      "No product data found!")))
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

                                                  /////////// Popular Products Portrait start //////

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
                                                  child: PopularProductCard(
                                                      popularProductList[index]),
                                                ),
                                                itemCount:
                                                    popularProductList.length, //7,
                                              )

                                              )
                                               /////////// Popular Products Portrait end //////
                                              :
                                               //   /////////// Popular Products Landscape start //////
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
                                                  child: PopularProductCardLandscape(
                                                      popularProductList[index]),
                                                ),
                                                itemCount:
                                                    popularProductList.length, //7,
                                              )
                                              ),
                                              */
                              ///////////////// popular product end ///////////////////
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
      ),
    );
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
                                    itemCount: productList.length,
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

  ////////////////////////   Log Out Dialog Start   //////////////////
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return AlertDialog(
          title: new Text(
            'Do you want to log out ?',
            style: TextStyle(color: Colors.black),
          ),
          content:
              // actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: appColor,
                    // borderSide: BorderSide(
                    //   color: appColor, style: BorderStyle.solid, width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                  child: const Text(
                    "No",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: appColor,
                    // borderSide: BorderSide(
                    //   color: appColor, style: BorderStyle.solid, width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    _logout();
                  },
                ),
              ],
            ),
          ),
          //],
        );
      },
    );
  }
  ////////////////////////   Log Out Dialog End   //////////////////

  ////////////////////////  Log Out Calling  Start  //////////////////////
  void _logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    ///localStorage.remove('token');

    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => LoginScreen()));
  }
  ///////////////////////////  Log Out Calling End /////////////////////////

}
