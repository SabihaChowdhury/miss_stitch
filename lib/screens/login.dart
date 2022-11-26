// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miss_stitch/Api/registerApi.dart';
import 'package:miss_stitch/screens/bottomNavigation.dart';
import 'package:miss_stitch/screens/login.dart';
import 'package:miss_stitch/screens/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routeTransition/routeTransition.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordContoller = TextEditingController();
  bool _validate = false;
  GlobalKey<FormState> _loginFormKey = new GlobalKey();
  String email = '';
  String password = '';

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
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

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFc5a3f9),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                ////////////  Logo Start //////////
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Image.asset(
                    'assets/image/Black logo - no background.png',
                    height: 120,
                    width: 120,
                  ),
                ),

                SizedBox(
                  height: 60,
                ),

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
                        top: 20, left: 25, right: 25, bottom: 30),
                    //width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(1),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      color: Color.fromARGB(255, 244, 173, 98),
                    ),
                    height: 50,
                    //width: 120,
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      onPressed: () {
                      //  Navigator.push( context, SlideLeftRoute(page: BottomNavigationPage(0)));
                      _isLoading ? null : _logInButton();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      color: Color(0xFFfae6d0),
                      elevation: 5.0,
                      child: Text(
                        _isLoading ? "Loading..." : "Login",
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
                      'Do not have any account?',
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
                        Navigator.push( context, SlideLeftRoute(page: SignUpScreen()));
                      },
                      child: Text(
                        'Sign Up.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 17.0,
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


   //////////////////////   Api Calling   //////////////////
  void _logInButton() async {
    if (_emailContoller.text.isEmpty) {
      return _showMessage("Email is empty");
    } else if (_passwordContoller.text.isEmpty) {
      return _showMessage("Password is empty");
    }

    setState(() {
      _isLoading = true;
    });

    var data = {
      'email': _emailContoller.text,
      'password': _passwordContoller.text,
      //'app_token': 'cQzDzMqzmKw:APA91bEZyALyzbo3DRh0tAnrH0NskEPlG7Yw0xsQn6dMsPLldijIwJzHatlBG0qNhPhG0ThR04fSVR4VUznfO3C9jafjXUBlZw0IJ-LupBwwWR3nXgOhsCwMR4ql-X8m63lG_upciJ95',
    };

    var res = await CallApi().postData(data, '/api/user/login');
    var body = json.decode(res.body);
    print('res');
    print(res);
    print('body');
    print(body);
    print('statsuCode');
    print(res.statusCode);

    if (body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      //localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));

      var userJson = localStorage.getString('user');

      ///var user = jsonDecode(userJson);
      // print(user['id']);
      //  print(body['token']);

      Navigator.push(context, SlideLeftRoute(page: BottomNavigationPage(0)));
    } else {
      _showMessage("Invalid Email or Password");
    }

    setState(() {
      _isLoading = false;
    });
  }

}
