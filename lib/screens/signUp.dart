// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miss_stitch/screens/bottomNavigation.dart';
import 'package:miss_stitch/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/registerApi.dart';
import '../routeTransition/routeTransition.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _firstNameContoller = TextEditingController();
  TextEditingController _lastNameContoller = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _phoneContoller = TextEditingController();
  TextEditingController _passwordContoller = TextEditingController();
  bool _validate = false;
  
  bool _isLoading = false;

  GlobalKey<FormState> _sigUpFormKey = new GlobalKey();

  String email = '';
  String name = '';
  String phone = '';
  String password = '';

  var regData = '';
  var _showData;


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor:  Color(0xFFc5a3f9),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFFc5a3f9),
      //   centerTitle: true,
      //   title:
      //    Row(
      //     children: [
      //       Image.asset('assets/image/Color logo - no background.png', height: 40, width: 40,),
      //       Text(
      //                   'MissStitch',
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                       color: Colors.black,//Color(0xFF090909),
      //                       fontSize: 17,
      //                       fontFamily: "bolt-regular",
      //                       fontStyle: FontStyle.italic,
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _sigUpFormKey,
            child: Column(
              children: [
                ////////////  Logo Start //////////
                Image.asset(
                  'assets/image/Black logo - no background.png',
                  height: 120,
                  width: 120,
                ),
                // Container(
                //   //height: 100,
                //   //width: MediaQuery.of(context).size.width / 4,
                //   margin: const EdgeInsets.only(
                //       top: 30, left: 10, right: 10, bottom: 20),
                //   padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(0.0)),
                //     color: Colors.white,
                //    // border: Border.all(color: Colors.black, width: 2),
                //   ),
                //   child: Text(
                //     'MissStitch',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //         color: Color(0xFF090909),
                //         fontSize: 17,
                //         fontFamily: "bolt-regular",
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                ////////////  Logo End  /////////////

                // ///////  Image Asset Container Start ////////
                // Container(
                //   height: 130,
                //   margin:
                //       EdgeInsets.only(top: 10, left: 45, right: 45, bottom: 30),
                //   padding: EdgeInsets.only(top: 50),
                //  // width: MediaQuery.of(context).size.width,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //     border: Border.all(color: Colors.black, width: 2),
                //   ),
                //   child: Text(
                //     'Asset Image',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //         color: Color(0xFF090909),
                //         fontSize: 17,
                //         fontFamily: "bolt-regular",
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                // ///////  Image Asset Container End ////////

                SizedBox(
                  height: 70,
                ),

                ///////  Name Textfiled Start ////////
                Container(
                  // width: MediaQuery.of(context).size.width,
                  //height: 100,
                  margin:  EdgeInsets.only(
                      top: 10, left: 8, right: 8, bottom: 15),
                  // padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                  // decoration: const BoxDecoration(
                  //     //borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  //     //color: Colors.red,
                  //     ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: TextFormField(
                            //autofocus: true,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Color(0xFF000000)),
                            cursorColor: Color(0xFF9b9b9b),
                            controller: _firstNameContoller,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              hintText: "First Name",
                              hintStyle: TextStyle(
                                  color: Color(0xFF090909),
                                  fontSize: 17,
                                  fontFamily: "bolt-regular",
                                  fontWeight: FontWeight.bold),
                              contentPadding:
                                  EdgeInsets.only(left: 15, bottom: 0, top: 14),
                              fillColor: Color(0xFFffffff),
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: TextFormField(
                            //autofocus: true,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Color(0xFF000000)),
                            cursorColor: Color(0xFF9b9b9b),
                            controller: _lastNameContoller,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              hintText: "Last Name",
                              hintStyle: TextStyle(
                                  color: Color(0xFF090909),
                                  fontSize: 17,
                                  fontFamily: "bolt-regular",
                                  fontWeight: FontWeight.bold),
                              contentPadding:
                                  EdgeInsets.only(left: 15, bottom: 0, top: 14),
                              fillColor: Color(0xFFffffff),
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /////////  Name Textfiled End //////////
                ///////  Email Textfiled Start ////////
                Container(
                  // width: MediaQuery.of(context).size.width,
                  //height: 100,
                  margin:  EdgeInsets.only(
                      top: 10, left: 40, right: 40, bottom: 15),
                  padding:  EdgeInsets.fromLTRB(2, 0, 0, 0),
                  decoration:  BoxDecoration(
                      //borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      //color: Colors.red,
                      ),
                  child: TextFormField(
                    //  autofocus: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter an email!';
                      }

                      // Return null if the entered email is valid
                      return null;
                    },
                    onChanged: (value) {
                      email = _emailContoller.text;
                    },
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    controller: _emailContoller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                      hintText: "Email",
                      hintStyle: TextStyle(
                          color: Color(0xFF090909),
                          fontSize: 17,
                          fontFamily: "bolt-regular",
                          fontWeight: FontWeight.bold),
                      contentPadding:
                          EdgeInsets.only(left: 15, bottom: 0, top: 14),
                      fillColor: Color(0xFFffffff),
                      filled: true,
                    ),
                  ),
                ),
                /////////  Email Textfiled End //////////

                ///////  Phone Textfiled Start ////////
                Container(
                  //width: MediaQuery.of(context).size.width,
                  //height: 100,
                  margin:  EdgeInsets.only(
                      top: 10, left: 40, right: 40, bottom: 15),
                  padding:  EdgeInsets.fromLTRB(2, 0, 0, 0),
                  decoration:  BoxDecoration(
                      //borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      //color: Colors.red,
                      ),
                  child: TextFormField(
                    // autofocus: true,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    controller: _phoneContoller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                      hintText: "Phone",
                      hintStyle: TextStyle(
                          color: Color(0xFF090909),
                          fontSize: 17,
                          fontFamily: "bolt-regular",
                          fontWeight: FontWeight.bold),
                      contentPadding:
                          EdgeInsets.only(left: 15, bottom: 0, top: 14),
                      fillColor: Color(0xFFffffff),
                      filled: true,
                    ),
                  ),
                ),
                /////////  Phone Textfiled End //////////

                ///////  Password Textfiled Start ////////
                Container(
                  //width: MediaQuery.of(context).size.width,
                  //height: 100,
                  margin:  EdgeInsets.only(
                      top: 10, left: 40, right: 40, bottom: 10),
                  padding:  EdgeInsets.fromLTRB(2, 0, 0, 0),
                  decoration:  BoxDecoration(
                      //borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      //color: Colors.yellow,
                      ),
                  child: TextFormField(
                    // autofocus: true,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    controller: _passwordContoller,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                      hintText: "Password",
                      hintStyle: TextStyle(
                          color: Color(0xFF090909),
                          fontSize: 17,
                          fontFamily: "bolt-regular",
                          fontWeight: FontWeight.bold),
                      contentPadding:
                          EdgeInsets.only(left: 10, bottom: 0, top: 14),
                      fillColor: Color(0xFFffffff),
                      filled: true,
                    ),
                  ),
                ),
                ///////  Password Textfiled End ////////

                //////// Create Account Button Start /////////
                Container(
                    margin: EdgeInsets.only(
                        top: 20, left: 25, right: 25, bottom: 20),
                    //width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(1),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      color: Color.fromARGB(255, 244, 173, 98),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      onPressed: () {
                        print('button pressed');
                        _isLoading ? null : _handleRegister();
                        //Navigator.push( context, SlideLeftRoute(page: BottomNavigationPage(0)));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      color: Color(0xFFfae6d0),
                      elevation: 5.0,
                      child: Text(
                        _isLoading ? "Creating..." : "Create Account",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          decoration: TextDecoration.none,
                          fontFamily: 'bolt-regular',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                ////////// Create Account Button End /////////

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        fontFamily: 'bolt-regular',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push( context, SlideLeftRoute(page: LoginScreen()));
                      },
                      child: Text(
                        'Sign in.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.0,
                          decoration: TextDecoration.none,
                          fontFamily: 'bolt-regular',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /////////////////////////////////  Api Calling   /////////////////////////////
  void _handleRegister() async {
    if (_firstNameContoller.text.isEmpty) {
      return _showMessage("First Name is empty");
    } else if (_lastNameContoller.text.isEmpty) {
      return _showMessage("Last Name is empty");
    } else if (_emailContoller.text.isEmpty) {
      return _showMessage("Email is empty");
    } else if (!_emailContoller.text.contains('@')) {
      return _showMessage("Email is invalid");
    } else if (_passwordContoller.text.isEmpty) {
      return _showMessage("Password is empty");
    }
    /*else if (registerConfirmPasswordController.text.isEmpty) {
      return _showMessage("Confirm Password is empty");
    }
    else if (_passwordContoller.text !=
        registerConfirmPasswordController.text) {
      return _showMessage("Password not same");
    }*/

    var data = {
      "fname": _firstNameContoller.text,
      "lname": _lastNameContoller.text,
      "email": _emailContoller.text,
      "address": 'address',
      "mobile": _phoneContoller.text,
      "password": _passwordContoller.text,
      "status": 'status',
      "type": 'Customer',
      // "house": '12',
      // "street": '12',
      // "road": '12',
      // "block": '12',
      // "area": '12',
      // "city": '12',
      // "state": '12',
      // "discount": '',
      // "discountValidity": '',
      // "country": '12',
    };
    setState(() {
      _isLoading = true;
    });

//     try {

//       Response response = await Dio().post(
//           'https://mobile.bahrainunique.com/app/addUser',
//           data: data,
//       //     cancelToken: token, onSendProgress: (int sent, int total) {
//       // }

//       );

//       setState(() {
//         _showData = response.data['user'];
//        // regData = _showData;
//         print('response data');
//         print(response.data);

//         print('_showData');
//         print(_showData);

//          print('regData');
//          print(regData);
//         _isLoading = false;

//       });

//       // if (response.statusCode == 200) {
//       // }
//       //else

//       // Show the incoming message in snakbar
//       //_showMessage(response.data['message']);
//     }
//     catch (e) {
//       //regData = e;
//        print("Exception Caught: $e");
//      // print(e);
//     }

// //      on DioError catch(e) {
// //     // The request was made and the server responded with a status code
// //     // that falls out of the range of 2xx and is also not 304.
// //     if(e.response.data) {
// //         print(e.response.data);
// //         print(e.response.headers);
// //         print(e.response.request);
// //     } else{
// //         // Something happened in setting up or sending the request that triggered an Error
// //         regData = e.message;
// //         print(e.request);
// //         print(e.message);
// //         print('regData');
// //         print(regData);
// //     }
// // }

    var res = await CallApi().postData(data, '/api/user/create/new/customer');

    var body = json.decode(res.body);
    print('data');
    print(data);
    print('res');
    print(res);
    print('body');
    print(body);
    print(res.statusCode);
    setState(() {
      regData = res.body;
    });
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      //localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));

       _showMessage("Registration successful !!!");

      // var userJson = localStorage.getString('user');
      // var user = jsonDecode(userJson);
      // print(user['id']);
      // print(body['token']);

      Navigator.push(context, SlideLeftRoute(page: LoginScreen()));
    } else {
      _showMessage("Something went wrong !");
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
        //timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 13.0);
  }
}
