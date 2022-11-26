// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SuccessCard extends StatefulWidget {
  const SuccessCard({Key? key}) : super(key: key);

  @override
  _SuccessCardState createState() => _SuccessCardState();
}

class _SuccessCardState extends State<SuccessCard> {

  var isChecked = false;

  void _onSilentRideChecked(bool newValue) {
    setState(() {
      isChecked = newValue;
      Navigator.pop(context);
      _showDriverIsHereDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
              margin: EdgeInsets.fromLTRB(15, 30, 15, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  ///////////////// Submit Button  Start///////////////
                  Container(
                      margin: EdgeInsets.only(
                          left: 2, right: 2, bottom: 20, top: 60),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {

                          _showDriverIsHereDialog();

                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 2.0, shadowColor: Color(0xFF7183F1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          primary: Color(0xFF7183F1), // Background color
                        ),
                        child: Text(
                          "Submit",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Color(0XFFFFFFFF),
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )),
                  ///////////////// Submit Button  End///////////////
                ],
              ))),
    );
  }

  ///// dialog driverIsHere Start ////
  void _showDriverIsHereDialog() {
    showDialog(
        context: context,
        builder: (_) => Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  // height: MediaQuery.of(context).size.height / 1.5,
                  //width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 40, bottom: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 10, 20),
                            child: Text(
                              "Driver is here !",
                              style: TextStyle(
                                color: Color(0XFF0A0A0A),
                                fontSize: 24.0,
                                decoration: TextDecoration.none,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 40, top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Checkbox(
                                //checkColor: Color(0XFF294F95),
                                activeColor: Color(0xFF7183F1),
                                tristate: false,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: isChecked,
                                onChanged: (bool? value) {
                                    _onSilentRideChecked(value!);
                                }),
                            ),
                            
                            Text(
                              "I prefer silent ride",
                              style: TextStyle(
                                color: Color(0XFF0A0A0A),
                                fontSize: 18.0,
                                decoration: TextDecoration.none,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //     ),
                      //   ],
                      // ),

                      ///////////////// OK Button  Start///////////////
                      Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(
                            left: 0,
                            right: 85,
                            bottom: 20,
                            top: 15,
                          ),
                          //width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => BottomNavigationPage(0)));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 2.0, shadowColor: Color(0xFF7183F1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              primary: Color(0xFF7183F1), // Background color
                            ),
                            child: Text(
                              "OK",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Color(0XFFFFFFFF),
                                fontSize: 18.0,
                                decoration: TextDecoration.none,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                      ///////////////// OK Button  End///////////////
                    ],
                  ),
                ),
              ),
              //   );
              // },
            ));
  }
  //// dialog driverIsHere End /////

}
