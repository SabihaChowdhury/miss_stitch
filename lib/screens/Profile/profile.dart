import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:miss_stitch/routeTransition/routeTransition.dart';
import 'package:miss_stitch/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../bottomNavigation.dart';

//import 'package:path/path.dart';

class Profile extends StatefulWidget {
  // final loggedData;
  // ProfileEditForm(this.loggedData);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController addressController = new TextEditingController();
//    LocationData _currentLocation;
//   Location location = Location();
// var userLocation;
  DateTime selectedDate = DateTime.now();
  var format;
  var address = "";
  // String _value;
  String userType = '';

  bool _isLoading = false;

  String deviceId = '';

  var userData;
  var userToken = '';

  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  // TextEditingController password = new TextEditingController();
  TextEditingController number = new TextEditingController();
  // String base64Image;
  var lat;
  var lan;
  var strImage;
  // File _image;
  bool _isImage = false;
  int imgPercent = 1;
  List imgList = [];
  var _showImage;
  bool isLoading = false;
  bool _isCancelImg = false;
  // CancelToken token = CancelToken();
  // var dio = new Dio();
  bool _isGetImage = false;

  // String fullUrl, mainUrl;
  // String tryUrl;

  Future getImage() async {
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // if (image == null) {
    // } else {
    //   _uploadImg(image);

    //   setState(() {
    //     _image = image;
    //     _isGetImage = true;
    //   });
    // }
  }

  void _uploadImg(filePath) async {
    // setState(() {
    //   _isImage = true;
    // });

    // String fileName = Path.basename(filePath.path);
    // print("File base name: $fileName");

    // try {
    //   FormData formData =
    //       new FormData.from({"imgUrl": new UploadFileInfo(filePath, fileName),
    //       "url": '$mainUrl',
    //       });

    //   Response response = await Dio().post(
    //       '$tryUrl',//'http://test.appifylab.com/app/userUpload',
    //       data: formData,
    //       cancelToken: token, onSendProgress: (int sent, int total) {
    //     //imgPercent=0;
    //     setState(() {
    //       imgPercent = ((sent / total) * 100).toInt();

    //       print("percent");
    //       print(imgPercent);
    //     });
    //   });
    //   print('response');
    //   print(response);
    //   print('_isCancelImg');
    //   print(_isCancelImg);

    //   if (_isCancelImg == true) {
    //     _isCancelImg = false;
    //   } else {
    //     setState(() {
    //       _showImage = response.data['imgUrl'];
    //       _isImage = false;
    //       imgPercent = 0;
    //     });
    //     print('_showImage');
    //     print(_showImage);

    //     //imgList.add({'imgUrl': response.data['imgUrl']});
    //   }
    //   //     setState(() {
    //   //   _isImage = false;
    //   // });
    //   print('imgList');
    //   print(imgList);

    //   // Show the incoming message in snakbar
    //   //_showMsg(response.data['message']);
    // } catch (e) {
    //   // print("Exception Caught: $e");
    // }
    // print(_isImage);
  }

  void cancelImg() async {
    print("object");
    setState(() {
      _isImage = false;
      _isCancelImg = true;
      // print(_isCancelImg);
    });
  }

  @override
  void initState() {
    _getUserInfo();
    postPicData();
    super.initState();
  }

  postPicData() async {
    // var apiUrl = '/app/userUpload';
    // mainUrl = await CallApi().getUrl();
    // fullUrl = await CallApi().getUrl() + apiUrl;
    // tryUrl = fullUrl;
    // //  print(await _setHeaders());
    // print("full url is : $fullUrl");
    // print("full url is : $tryUrl");
    // return fullUrl;
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    ///var token = localStorage.getString('token');
    var user = localStorage.getString('user');
    print('userrrrr');
    print(user);
    // deviceId = localStorage.getString('deviceId');
    ///if (token != null || user != null) {
    if (user != null) {
      var userinfoList = json.decode(user);
      setState(() {
        userData = userinfoList;

        /// userToken = token;
      });
      //deviceId = userinfoList['device_id'];
      print('userData');
      print(userData);

      /// print('userToken');
      ///print(userToken);
    }
    name.text = userData != null &&
            userData['fname'] != null &&
            userData['lname'] != null
        ? '${userData['fname']} ${userData['lname']}'
        : 'Name';
    email.text = userData != null && userData['email'] != null
        ? '${userData['email']}'
        : 'Email';
    number.text = userData != null && userData['mobile'] != null
        ? '${userData['mobile']}'
        : 'Mobile number';
    // payMayaNumber.text = userData != null && userData['paymaya'] != null
    //     ? '${userData['paymaya']}'
    //     : 'Paymaya number';
    // gCashNumber.text = userData != null && userData['gcash'] != null
    //     ? '${userData['gcash']}'
    //     : 'Gcash number';
    address = userData != null && userData['address'] != null
        ? '${userData['address']}'
        : '';

    /// _showImage = userData != null && userData['image'] != null
    ///     ? '${userData['image']}'
    ///     : '';
    // _showImage = null;
    ///print(_showImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: appColor,
      appBar: AppBar(
        backgroundColor: appColor,
        elevation: 2.9,
        // leading: Container(
        //   padding: const EdgeInsets.only(top: 5.0),
        //   child: IconButton(
        //     icon: const Icon(
        //       Icons.arrow_back,
        //       size: 23,
        //     ),
        //     color: Colors.black87,
        //     onPressed: () {
        //       // if (widget.loggedData == 'Beneficiary') {
        //       //   Navigator.push(context, SlideLeftRoute(page: Beneficiary()));
        //       // } else if (widget.loggedData == 'Donor') {
        //       //   Navigator.push(
        //       //       context, SlideLeftRoute(page: DonorIncidentPage()));
        //       // } else if (widget.loggedData == 'Rider') {
        //       //   Navigator.push(
        //       //       context, SlideLeftRoute(page: RiderPage()));
        //       // } else {
        //       //   Navigator.push(context, SlideLeftRoute(page: PublicReporter()));
        //       // }
        //     },
        //   ),
        // ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: 2,
        title: Container(
          padding: const EdgeInsets.only(top: 0.0),
          child: const Text(
            'Profile',
            style: TextStyle(
                color: Color(0XFF090909),
                fontSize: 18.0,
                fontFamily: 'Proxima Nova',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          ),
        ),
        // actions: <Widget>[
        //   IconButton(
        //   icon: Icon(Icons.vpn_key, size: 28,),
        //   color: Theme.of(context).primaryColor,
        //   onPressed: () {
        //     Navigator.push(
        //               context, SlideLeftRoute(page: ChangePassword()));
        //   },
        // ),
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
        //color: appColor,
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ////////////  upload image //////////////

              /*
              Container(
                  // margin: EdgeInsets.only(,
                  child: _showImage == '' || _showImage == null
                      ? Column(
                          //  mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              //   alignment: Alignment.center,
                              margin:
                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: DottedBorder(
                                color: Colors.black,
                                radius: Radius.circular(60),
                                strokeWidth: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: IconButton(
                                            icon: Icon(Icons.file_upload,
                                                color: Color(0xFF8A8A8A)),
                                            onPressed: getImage),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 12),
                                        child: Text(
                                          'Upload Image',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                top: 20,
                              ),
                              child: _isImage
                                  ? Column(
                                      children: <Widget>[
                                        imgPercent == 100
                                            ? Container(
                                                margin: EdgeInsets.only(top: 20,),
                                                padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(5))),
                                                child: Text(
                                                  '.... loading picture',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                margin: EdgeInsets.only(top: 20,),
                                                padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(5))),
                                                child: Text(
                                                  '$imgPercent % loading',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    )
                                  : ClipOval(
                                      child: GestureDetector(
                                          onTap: getImage,
                                          child: Image.network(
                                            _showImage,
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          )
                                          // child: Image.file(_image,
                                          //     height: 120, width: 120, fit: BoxFit.fill),
                                          ),
                                    ),
                            ),
                          ],
                        )
                  // :
                  // Column(
                  //   children: <Widget>[
                  //     Container(
                  //       margin: EdgeInsets.only(
                  //         top: 20,
                  //       ),
                  //       child: ClipOval(
                  //         child: GestureDetector(
                  //           onTap: getImage,
                  //           child: Image.file(_image,
                  //               height: 120, width: 120, fit: BoxFit.fill),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  ),
                  */

              Container(
                // width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                child: TextField(
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  controller: name,
                  minLines: 1,
                  maxLines: 20,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Container(
                // width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                child: TextField(
                  readOnly: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  minLines: 1,
                  maxLines: 20,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              // Container(
              //   // width: MediaQuery.of(context).size.width,
              //   padding: EdgeInsets.only(top: 5.0),
              //   child: TextField(
              //     controller: password,
              //     decoration: InputDecoration(
              //       enabledBorder: UnderlineInputBorder(
              //         borderSide:
              //             BorderSide(color: Theme.of(context).primaryColor),
              //       ),
              //       hintText: 'Password (min 6 digit)',
              //       hintStyle: TextStyle(color: Theme.of(context).primaryColor),
              //       prefixIcon: Icon(
              //         Icons.lock,
              //         color: Theme.of(context).primaryColor,
              //       ),
              //     ),
              //     style: TextStyle(
              //       color: Theme.of(context).primaryColor,
              //     ),
              //     obscureText: true,
              //   ),
              // ),
              Container(
                // width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
                child: TextField(
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  controller: number,
                  minLines: 1,
                  maxLines: 20,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    hintText: 'Mobile Number',
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    prefixIcon: Icon(
                      Icons.phone_iphone,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),

              //////////////////////// Address  /////////////////////

              Container(
                // width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 2.0, bottom: 15.0),
                child: TextField(
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  controller: addressController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    prefixIcon: Icon(
                      Icons.location_city_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: 'Address',
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),

              // Divider(thickness: 1, height: 0.2, color: appColor),

              // Divider(thickness: 1, height: 1, color: appColor),

              Container(
                  margin: const EdgeInsets.only(
                      top: 30, left: 25, right: 25, bottom: 20),
                  //width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    color: Color.fromARGB(255, 244, 173, 98),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    onPressed: () {
                      //_profileUpdate();
                      _showLogoutDialog(context);
                      // Navigator.push(
                      //     context, SlideLeftRoute(page: const LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      primary: Color(0xFFfae6d0),
                      elevation: 3.0,
                    ),
                    child: const Text(
                      "Log Out",
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
              // Container(
              //   padding: EdgeInsets.only(top: 19.0, bottom: 10.0),
              //   child: Text(
              //     'Forgot Password?',
              //     style: TextStyle(
              //       color: Theme.of(context).accentColor,
              //       fontSize: 12.0,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  /////////////////////////////////  Api Calling   /////////////////////////////
  void _profileUpdate() async {
    Navigator.pop(context);
    // if (!email.text.contains('@')) {
    //   return _showDialog("Email is invalid");
    // }

    // var data = {
    //   "email": email.text,
    //   //"userType": userType,
    //   "mobileNumber": number.text,
    //   "image": _showImage,
    //   "name": name.text,
    //   "birthDate": date,
    //   "gcash": gCashNumber.text,
    //   "paymaya": payMayaNumber.text,
    // };
    // print(data);
    // setState(() {
    //   _isLoading = true;
    // });

    // // print(data);

    // var res = await CallApi()
    //     .loginPostData(data, '/app/profileEdit?token=$userToken');
    // print(res);
    // var body = json.decode(res.body);
    // print(body);

    // // setState(() {
    // //   regData = res.body;
    // // });

    // if (res.statusCode == 200) {
    //   SharedPreferences localStorage = await SharedPreferences.getInstance();
    //   localStorage.setString('user', json.encode(body['user']));
    //   // localStorage.setString('deviceId', deviceId);

    //   _showMessage("Your profile is updated!");

    //   // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   //   return Login();
    //   // }));
    // } else {
    //   _showMessage("Something went wrong !!");
    // }
    // setState(() {
    //   _isLoading = false;
    // });
  }

  // _showMessage(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIos: 1,
  //       backgroundColor: appColor.withOpacity(0.9),
  //       textColor: Colors.white,
  //       fontSize: 13.0);
  // }

  void _showDialog(String msg) {
    // showGeneralDialog(
    //     barrierColor: Colors.black.withOpacity(0.5),
    //     transitionBuilder: (context, a1, a2, widget) {
    //       final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
    //       return Transform(
    //         transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
    //         child: Opacity(
    //           opacity: a1.value,
    //           child:
    AlertDialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      title: Text(
        msg, //'Invalid Email/Password Combination'
      ),
      content: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF2F2F2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new RawMaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Ok Got it!"),
                elevation: 5.0,
                fillColor: const Color(0xFFF2F2F2),
                padding: const EdgeInsets.all(15.0),
              ),
            ],
          ),
        ),
      ),
    );
    //     ),
    //   );
    // },
    // transitionDuration: Duration(milliseconds: 300),
    // barrierDismissible: true,
    // barrierLabel: '',
    // context: context,
    // pageBuilder: (context, animation1, animation2) {});
  }

  Future<Null> _selectDate(BuildContext context) async {
    // final DateTime picked = await showDatePicker(
    //     //  locale: Locale("yyyy-MM-dd"),
    //     context: context,
    //     initialDate: selectedDate,
    //     firstDate: DateTime(1900, 1),
    //     lastDate: DateTime(2101));
    // if (picked != null && picked != selectedDate)
    //   setState(() {
    //     selectedDate = picked;
    //     date = "${DateFormat("yyyy-MM-dd").format(selectedDate)}";
    //   });
  }

  ////////////////////////   Log Out Dialog Start   //////////////////
  void _showLogoutDialog(context) {
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
