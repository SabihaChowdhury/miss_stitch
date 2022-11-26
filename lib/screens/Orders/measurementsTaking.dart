import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miss_stitch/main.dart';
import 'package:miss_stitch/routeTransition/routeTransition.dart';
import 'package:miss_stitch/screens/Orders/orderPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'keyValueModel.dart';

get_list_sleeves() {
  List<KeyValueModel> datas = [
    KeyValueModel(key: "Half Sleeves", value: "Value 1"),
    KeyValueModel(key: "Full Sleeves", value: "Value 2"),
  ];
  return datas;
}

get_list_neck() {
  List<KeyValueModel> datas = [
    KeyValueModel(key: "Full Collor", value: "Value 1"),
    KeyValueModel(key: "Half Collor", value: "Value 2"),
    KeyValueModel(key: "Round-Shape Collor", value: "Value 3"),
    KeyValueModel(key: "U-Shape Collor", value: "Value 4"),
    KeyValueModel(key: "V-Shape Collor", value: "Value 5"),
  ];
  return datas;
}

class MeasurementsTakingForm extends StatefulWidget {
  final service;
  MeasurementsTakingForm(this.service);
  @override
  _MeasurementsTakingFormState createState() => _MeasurementsTakingFormState();
}

class _MeasurementsTakingFormState extends State<MeasurementsTakingForm> {
  TextEditingController sleevesController = TextEditingController();
  TextEditingController neckController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController wristController = TextEditingController();
  TextEditingController bustController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  bool _isLoading = false;
  var userData, userId, userPhone, reservationId;

  late KeyValueModel categoryModel;
  List<KeyValueModel> _times = <KeyValueModel>[];
  String timeName = "";
  var timeId = "";
  List listan = get_list_sleeves();
  String currentTimeSelected = '';
  bool _validate = false;
  bool isProvidedType = false;

  
  List<KeyValueModel> _neckTypes = <KeyValueModel>[];
  String neckName = "";
  var neckId = "";
  List listan2 = get_list_neck();
  String currentNeckSelected = '';

  @override
  void initState() {
    ///_getUserInfo();
    for (int i = 0; i < listan.length; i++) {
      _times.add(
          KeyValueModel(key: "${listan[i].key}", value: "${listan[i].value}"));
    }
    for (int i = 0; i < listan2.length; i++) {
      _neckTypes.add(
          KeyValueModel(key: "${listan2[i].key}", value: "${listan2[i].value}"));
    }
    super.initState();
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
  //   userPhone = int.parse('${userData['phone']}');
  //   print("ssfdfdgdfgbv dfh");
  //   print("${userData['id']}");
  //   print(userData);
  //   print(userPhone);
  // }

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
              margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    
                    // const Text(
                    //   // widget.service.service_type == 'product'
                    //   //     ?
                    //   'Item Name',
                    //   // : 'Service Name',
                    //   overflow: TextOverflow.clip,
                    //   style: TextStyle(
                    //       fontSize: 16,
                    //       height: 1.8,
                    //       fontFamily: 'Proxima Nova',
                    //       color: Color(0XFF090909),
                    //       fontWeight: FontWeight.normal),
                    // ),
                    // const Text(
                    //   // widget.service.name == null || widget.service.name == ''
                    //   //     ? '---'
                    //   //     : '${widget.service.name}',
                    //   'T-Shirt',
                    //   overflow: TextOverflow.clip,
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       height: 1.8,
                    //       fontFamily: 'Proxima Nova',
                    //       color: Color(0XFF707070),
                    //       fontWeight: FontWeight.bold),
                    // ),

                   const Center(
                      child:  Text(
                        // widget.service.service_type == 'product'
                        //     ?
                        'Your Measurements',
                        // : 'Service Name',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.8,
                            fontFamily: 'Proxima Nova',
                            color: Color(0XFF090909),
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    SizedBox(height: 2),
                    const Center(
                      child: Text(
                        // widget.service.service_type == 'product'
                        //     ? 
                            'All measurements are in inches'
                            ,
                           // : 'Service Seller Name',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 15,
                           // height: 1.8,
                            fontFamily: 'Proxima Nova',
                            color: Color(0XFF090909),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    /*
                    Text(
                      // (widget.service.users.firstName == null ||
                      //             widget.service.users.lastName == null) ||
                      //         (widget.service.users.firstName == '' ||
                      //             widget.service.users.lastName == '')
                      //     ? '---'
                      //     : '${widget.service.users.firstName[0].toUpperCase() + widget.service.users.firstName.substring(1)} ${widget.service.users.lastName[0].toUpperCase() + widget.service.users.lastName.substring(1)}', 
                           'Moynul Chowdhury',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontSize: 18,
                          height: 1.8,
                          fontFamily: 'Proxima Nova',
                          color: Color(0XFF707070),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Mobile Number',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.8,
                          fontFamily: 'Proxima Nova',
                          color: Color(0XFF090909),
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      // widget.service.users == null ||
                      //         widget.service.users.phone == null ||
                      //         widget.service.users.phone == ''
                      //     ? ''
                      //     : '${widget.service.users.phone}', 
                          '+445050545491',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontSize: 18,
                          height: 1.8,
                          fontFamily: 'Proxima Nova',
                          color: Color(0XFF707070),
                          fontWeight: FontWeight.bold),
                    ),*/

                    SizedBox(height: 10),
                    sleevesTypeDropdownButton(context),
                    buildTextfield(
                        sleevesController,
                        'Sleeves',
                        // widget.service.service_type == 'product'
                        //     ? 'Quantity Of Goods*'
                        //     : 'Duration to reserve Service (Hours)*',
                        TextInputType.number),
                    neckTypeDropdownButton(context),
                    buildTextfield(
                        neckController,
                        'Neck',
                        // widget.service.service_type == 'product'
                        //     ? 'Place of Exchange of Goods*'
                        //     : 'Place of offer of Services*',
                        TextInputType.number),
                    buildTextfield(
                        wristController, 'Waist', TextInputType.number),

                    buildTextfield(
                        bustController, 'Bust', TextInputType.number),

                    buildTextfield(
                        lengthController, 'Length', TextInputType.number),
                    
                    buildCommentTextfield(
                        commentController, 'Are there any other customization you would like your tailor to know?', TextInputType.text),

                    ///////////////// Continue Button Start///////////////
                    Container(
                        margin: EdgeInsets.only(
                            left: 15, right: 15, bottom: 20, top: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        decoration:  BoxDecoration(
                          border: Border.all(color: Color.fromARGB(255, 244, 173, 98), width: 0.6),
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
                            elevation: 3.0,
                            primary: Color(0xFFfae6d0),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                          ),
                          child: Text(
                            _isLoading ? "Please wait..." : "Continue",
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    ///////////////// Continue Button End///////////////
                    
                  ]),
            )));
  }

  Column sleevesTypeDropdownButton(BuildContext context) {
    return Column(
                  children: <Widget>[
                    // widget.data['service_type'] == 'service' ?
                     Column(
                      children: <Widget>[
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: 8, left: 0, right: 0, bottom: 15),
                          padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                          decoration: BoxDecoration(
                            borderRadius: (_validate == true && isProvidedType == true)? BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)) : BorderRadius.all(Radius.circular(6.0)),
                            color: Color(0XFFE1E1E1),
                          ),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<KeyValueModel>(
                              iconSize: 32,
                              iconEnabledColor: appSecondColor, //appColor,
                              iconDisabledColor: appSecondColor,
                              isExpanded: true,
                              // isDense: true,
                              underline: Container(
                                height: 0,
                                color: Colors.white,
                              ),
                              items: _times.map((KeyValueModel user) {
                                return DropdownMenuItem<KeyValueModel>(
                                  value: user,
                                  child: Text(
                                    user.key,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                );
                              }).toList(),
                              onChanged: (KeyValueModel? value) {
                                setState(() {
                                  categoryModel = value!;
                                  timeName = categoryModel.key;
                                  timeId = categoryModel.value;
                                });
                                // countryDivisionId =
                                //_onDropdownSelectedStatus(countryDivisionName);
                                _onSelectedTime(timeName);
                                // if (int.parse(countryDivisionId) == 6) {
                                //   _showDialog(context);
                                // }
                                print(timeId);
                              },
                              hint: Container(
                                child: Wrap(
                                  children: <Widget>[
                                    Text(
                                      timeName == ''
                                          ? 'Types of Sleeves *'
                                          : timeName, //widget.index.status == null ? "" : widget.index.status,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF090909).withOpacity(0.4),
                                      fontSize: 16,
                                      fontFamily: "Proxima Nova",
                                      fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        (_validate == true && isProvidedType == true)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                isProvidedType == false
                                    ? Container()
                                    : Divider(
                                        height: 1,
                                        color: isProvidedType == false
                                            ? Colors.white
                                            : Colors.red[900],
                                        thickness: 1,
                                        indent: 6.6,
                                        endIndent: 6.6),
                                isProvidedType
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 7, 5, 0),
                                        child: Text(
                                          'Sleeves Type is Required*',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.red[700],
                                              fontFamily: 'Proxima Nova',
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    // :
                                    // validateMobileNumber? Padding(
                                    //   padding: const EdgeInsets.fromLTRB(20, 7, 5, 0),
                                    //   child: Text(
                                    //     'This number is invalid. The length must be $countryCodeLength *',
                                    //     //validateMobileNumber? 'Length must be $countryCodeLength' : '',
                                    //     textAlign: TextAlign.left,
                                    //     style: TextStyle(
                                    //         color: Colors.red[600],
                                    //         fontFamily: 'Proxima Nova',
                                    //         fontSize: 12,
                                    //         fontWeight: FontWeight.normal),
                                    //   ),
                                    // )
                                    : Text('')
                              ],
                            )
                            : Container(),
                      ],
                    ),
                  ],
                  );
  }

  Column neckTypeDropdownButton(BuildContext context) {
    return Column(
                  children: <Widget>[
                    // widget.data['service_type'] == 'service' ?
                     Column(
                      children: <Widget>[
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: 0, left: 0, right: 0, bottom: 15),
                          padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                          decoration: BoxDecoration(
                            borderRadius: (_validate == true && isProvidedType == true)? BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)) : BorderRadius.all(Radius.circular(6.0)),
                            color: Color(0XFFE1E1E1),
                          ),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<KeyValueModel>(
                              iconSize: 32,
                              iconEnabledColor: appSecondColor, //appColor,
                              iconDisabledColor: appSecondColor,
                              isExpanded: true,
                              // isDense: true,
                              underline: Container(
                                height: 0,
                                color: Colors.white,
                              ),
                              items: _neckTypes.map((KeyValueModel user) {
                                return DropdownMenuItem<KeyValueModel>(
                                  value: user,
                                  child: Text(
                                    user.key,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                );
                              }).toList(),
                              onChanged: (KeyValueModel? value) {
                                setState(() {
                                  categoryModel = value!;
                                  neckName = categoryModel.key;
                                  neckId = categoryModel.value;
                                });
                                // countryDivisionId =
                                //_onDropdownSelectedStatus(countryDivisionName);
                                _onSelectedNeck(neckName);
                                // if (int.parse(countryDivisionId) == 6) {
                                //   _showDialog(context);
                                // }
                                print(neckId);
                              },
                              hint: Container(
                                child: Wrap(
                                  children: <Widget>[
                                    Text(
                                      neckName == ''
                                          ? 'Types of Neck *'
                                          : neckName, //widget.index.status == null ? "" : widget.index.status,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF090909).withOpacity(0.4),
                                      fontSize: 16,
                                      fontFamily: "Proxima Nova",
                                      fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        (_validate == true && isProvidedType == true)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                isProvidedType == false
                                    ? Container()
                                    : Divider(
                                        height: 1,
                                        color: isProvidedType == false
                                            ? Colors.white
                                            : Colors.red[900],
                                        thickness: 1,
                                        indent: 6.6,
                                        endIndent: 6.6),
                                isProvidedType
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 7, 5, 0),
                                        child: Text(
                                          'Neck Type is Required*',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.red[700],
                                              fontFamily: 'Proxima Nova',
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    // :
                                    // validateMobileNumber? Padding(
                                    //   padding: const EdgeInsets.fromLTRB(20, 7, 5, 0),
                                    //   child: Text(
                                    //     'This number is invalid. The length must be $countryCodeLength *',
                                    //     //validateMobileNumber? 'Length must be $countryCodeLength' : '',
                                    //     textAlign: TextAlign.left,
                                    //     style: TextStyle(
                                    //         color: Colors.red[600],
                                    //         fontFamily: 'Proxima Nova',
                                    //         fontSize: 12,
                                    //         fontWeight: FontWeight.normal),
                                    //   ),
                                    // )
                                    : Text('')
                              ],
                            )
                            : Container(),
                      ],
                    ),
                  ],
                  );
  }

  void _onSelectedTime(String newValue) {
    setState(() {
      currentTimeSelected = newValue;
      print(currentTimeSelected);
      if (isProvidedType == true) {
          isProvidedType = false;
        }
    });
  }

  void _onSelectedNeck(String newValue) {
    setState(() {
      currentNeckSelected = newValue;
      print(currentNeckSelected);
      if (isProvidedType == true) {
          isProvidedType = false;
        }
    });
  }

   _showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        //timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 13.0);
  }

  void _submitForm() async {
    ///Navigator.push(context, SlideLeftRoute(page: OrderPage()));
      if (currentTimeSelected.isEmpty) {
        return _showMessage("Types of Sleeves field is empty");
      } else if (sleevesController.text.isEmpty) {
        return _showMessage("Sleeves field is empty");
      } else if (currentNeckSelected.isEmpty) {
        return _showMessage("Types of Neck field is empty");
      } else if (neckController.text.isEmpty) {
        return _showMessage("Neck field is empty");
      } else if (wristController.text.isEmpty) {
        return _showMessage("Waist field is empty");
      } else if (bustController.text.isEmpty) {
        return _showMessage("Bust field is empty");
      } else if (lengthController.text.isEmpty) {
        return _showMessage("Length field is empty");
      } 
      // else if (bustController.text.length < 3 || (reservationAmountController.text.length == 3 && reservationAmountController.text[0].contains('1'))) {
      //   return _showMessage("Amount must be greater than or equal to 200");
      // }

      //var data;

    var data = {
        'typesOfSleeves': currentTimeSelected,
        'sleeves': sleevesController.text,
        'typesOfNeck': currentNeckSelected,
        'neck': neckController.text,
        'waist': wristController.text,
        'bust': bustController.text,
        'length': lengthController.text,
        'note': commentController.text,
      };
    var data2 = {
      'area': '',
      'house': '',
      'state': '',
      'city': '',
      'country': '',
      'postCode': '',
    };
      print(data);
      Navigator.push(context, SlideLeftRoute(page: OrderPage(widget.service, data, data2)));
    //   } else{
    //       data = {
    //         'service_id': widget.service.id,
    //         'seller_id': widget.service.users.id,
    //         'seller_mobile': widget.service.users.phone,
    //         'buyer_mobile': userPhone,
    //         'palace': placeController.text,
    //         'price': widget.service.price,
    //         'reservationAmount': reservationAmountController.text,
    //         'serviceType': widget.service.service_type,
    //         'duration': quantityDurationController.text,
    //       };
    //   }
    //   print(data);

    //   setState(() {
    //     _isLoading = true;
    //   });

    //   var res = await CallApi().postData1(data, '/app/storeReservation');
    //   print(res);
    //   var body = json.decode(res.body);
    //   print(body);

    //   if (res.statusCode == 200) {
    //     // SharedPreferences localStorage = await SharedPreferences.getInstance();
    //     // localStorage.setString('service', json.encode(body['user']));
    //     // localStorage.setString('deviceId', deviceId);

    //     setState(() {
    //       // amountController.text = '';
    //       // timeName = '';
    //       reservationId = body['reservation']['id'];
    //     });
    //     _showMessage("Your reservation form is submitted sucessfully!");
    //     Navigator.push(context,
    //       SlideLeftRoute(page: PaymentSystemForReservation(reservationId)));
    //   } else {
    //     _showMessage("Something went wrong !!");
    //   }
    //   setState(() {
    //     _isLoading = false;
    //   });
  }

 

   String validateFirstName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "First Name is Required*";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z*";
    } else if (value.contains(" ")) {
      return "Name should not have space in it*";
    } else if (value.length < 3 || value.length > 15) {
      return "Name must be between 3 and 15 characters long.*";
    }
    return '';
  }

  String validateLastName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Last Name is Required*";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z*";
    } else if (value.contains(" ")) {
      return "Name should not have space in it*";
    } else if (value.length < 3 || value.length > 15) {
      return "Name must be between 3 and 15 characters long.*";
    }
    return '';
  }

  // String validateNumber(String value) {
  //   if (value.length == 0) {
  //     return "Mobile number is Required*";
  //   } else if(countryCodeLength != '' && value.length != int.parse(countryCodeLength)) {
  //     return "Length must be $countryCodeLength *";
  //   }
  //   return '';
  // }

  String validatePin(String value) {
    if (value.length == 0) {
      return "Pin is Required*";
    } else if (value.length != 4) {
      return "Pin must have 4 digits*";
    }
    return '';
  }

  // String validateCountryName(String value) {
  //   if (value.length == 0) {
  //     return "Country is Required";
  //   }
  //   return null;
  // }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Email is not valid*";
    } else {
      return '';
    }
  }

  String validateEmail2(String value) {
    return '';
  }

  void _showDialog(String msg) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text(
                  msg, //'Invalid Email/Password Combination'
                ),
                content: SingleChildScrollView(
                  child: Container(
                    color: Color(0xFFF2F2F2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new RawMaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: new Text("Ok Got it!"),
                          elevation: 5.0,
                          fillColor: Color(0xFFF2F2F2),
                          padding: const EdgeInsets.all(15.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 300),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  Container buildCommentTextfield(
      TextEditingController controller, String hintText, TextInputType type) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 5),
      child: TextField(
        //expands: true,
        style: TextStyle(
          color: Color(0xFF090909).withOpacity(0.6), fontWeight: FontWeight.w500),
        cursorColor: Color(0xFF9b9b9b),
        controller: controller, //firstNameController,
        keyboardType: type, //TextInputType.text,
        maxLines: 200,
        minLines: 1,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1)),
          hintText: hintText, //"First Name*",
          hintStyle: TextStyle(
              color: Color(0xFF090909).withOpacity(0.4),
              fontSize: 16,
              height: 1.5,
              fontFamily: "Proxima Nova",
              fontWeight: FontWeight.normal),
          contentPadding: EdgeInsets.only(left: 20, bottom: 15, top: 15),
          fillColor: Color(0xFFE1E1E1),
          filled: true,
        ),
      ),
    );
  }

  Container buildTextfield(
      TextEditingController controller, String hintText, TextInputType type) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 15),
      child: TextField(
        style: TextStyle(color: Color(0xFF090909).withOpacity(0.6), fontWeight: FontWeight.w500),
        cursorColor: Color(0xFF9b9b9b),
        controller: controller, //firstNameController,
        keyboardType: type, //TextInputType.text,
        maxLines: 100,
        minLines: 1,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Color(0xFFE1E1E1), width: 1)),
          hintText: hintText, //"First Name*",
          hintStyle: TextStyle(
              color: Color(0xFF090909).withOpacity(0.4),
              fontSize: 16,
              fontFamily: "Proxima Nova",
              fontWeight: FontWeight.normal),
          contentPadding: EdgeInsets.only(left: 20, bottom: 0, top: 0),
          fillColor: Color(0xFFE1E1E1),
          filled: true,
        ),
      ),
    );
  }
}
