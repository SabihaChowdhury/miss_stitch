// import 'package:flutter/material.dart';
// import 'package:miss_stitch_tailor/main.dart';

// import '../../NavigationAnimation/RouteTransition/routeAnimation.dart';
// import '../Registration/registration.dart';

// class IntroPage extends StatefulWidget {
//   @override
//   _IntroPageState createState() => _IntroPageState();
// }

// class _IntroPageState extends State<IntroPage> {
//   PageController controller = PageController(initialPage: 0);

//   Container introContainer(String picture, String title) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           ////////////////Picture Portion Start //////////////
//           Container(
//             width: MediaQuery.of(context).size.width / 1.7,
//             height: (MediaQuery.of(context).size.height / 2) - 45,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage(picture), fit: BoxFit.fill)),
//           ),
//           ////////////////Picture Portion end /////////////

//           /////////////// Bottom Portion Start /////////////
//           Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               margin: EdgeInsets.only(
//                 top: 50,
//                 bottom: 40,
//               ),
//               //color: Colors.amber,
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: Text(
//                       title,
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.center,
//                       maxLines: 1,
//                       style: TextStyle(
//                         color: Color(0xFF09324B),
//                         fontSize: 18.0,
//                         decoration: TextDecoration.none,
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           ///////////// Bottom Portion end ////////////
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//           padding: EdgeInsets.only(
//             left: 30,
//             right: 30,
//           ),
//           decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.9),
//               image: DecorationImage(
//                   image: AssetImage('assets/image/missStitch.png'),
//                   colorFilter: new ColorFilter.mode(
//                       Colors.white.withOpacity(0.9), BlendMode.overlay),
//                   fit: BoxFit.fill)),
//           child: Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//              ///////////// Logo Start ///////////////
//                 Container(
//                   margin: EdgeInsets.only(top: 45),
//                   width: 147,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/image/logo.png'),
//                           fit: BoxFit.fill)),
//                 ),
//              ///////////// Logo End //////////////////

//                 Expanded(
//                   child: Container(
//                     //height: 200,
//                     // alignment: Alignment.center,
//                     padding: EdgeInsets.only(
//                         bottom: 15, top: 10, left: 10, right: 10),
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                         //color: Colors.red,
//                         image: DecorationImage(
//                             image: AssetImage('assets/image/missStitch.png'),
//                             fit: BoxFit.contain)),
//                   ),
//                 ),

//                 ///////////////// Log In Button  Start///////////////
//                 Container(
//                   margin: EdgeInsets.only(bottom: 80),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Expanded(
//                         child: Container(
//                             padding: EdgeInsets.only(left: 30, right: 30),
//                             height: 40,
//                             child: RaisedButton(
//                               onPressed: () {
//                                 Navigator.push(context,
//                                     SlideLeftRoute(page: Registration()));
//                               },
//                               child: Text(
//                                 'Get Start With Us',
//                                 textDirection: TextDirection.ltr,
//                                 style: TextStyle(
//                                   color: Color(0XFFFFFFFF),
//                                   fontSize: 16.0,
//                                   decoration: TextDecoration.none,
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               // color: Color(0XFF67C8FE),
//                               color: appColor,
//                               elevation: 2.0,
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ///////////////// Log In Button  End///////////////
//               ],
//             ),
//           )),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:miss_stitch/main.dart';
import 'package:miss_stitch/routeTransition/routeTransition.dart';
import 'package:miss_stitch/screens/login.dart';
import 'package:miss_stitch/screens/signUp.dart';
import 'package:page_indicator/page_indicator.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller = PageController(initialPage: 0);

  Container introContainer(String picture, String title) {
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //////////Picture Portion Start ///////
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height / 2) - 45,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(picture), fit: BoxFit.fill)),
          ),
          //////////Picture Portion end ///////

          /////// Bottom Portion Start ////////

          Container(
            //height:(MediaQuery.of(context).size.height / 2) - 45,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            //color: Colors.red,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ////// Text Start ////////
                Container(
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.green,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          title,
                          //  '${widget.orderedItem.seller.name}',
                          //overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF1A3D7A),
                            fontSize: 17.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ////// Text End ////////
              ],
            ),
          ),
          /////// Bottom Portion end ////////
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 60, bottom: 30),
        decoration: BoxDecoration(
          color: appColor,
            // image: DecorationImage(
            //     image: AssetImage('assets/image/logo.png'),
            //     colorFilter: new ColorFilter.mode(
            //         Colors.white.withOpacity(0.9), BlendMode.hardLight),
            //     fit: BoxFit.fill)
                ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ////// Logo Start ///////////
            // Center(
            //   child: Container(
            //     width: 67,
            //     height: 26,
            //     decoration: BoxDecoration(
            //       color: appColor,
            //         image: DecorationImage(
            //             image: AssetImage('assets/image/Black logo - no background.png'),
            //             fit: BoxFit.fill)),
            //   ),
            // ),
            /////// Logo End ///////////

            Expanded(
              child: Container(
                  //height: 200,
                  padding: EdgeInsets.only(
                      bottom: 30, top: 50, left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.red,
                  child: PageIndicatorContainer(
                    length: 2,
                    //shape: IndicatorShape.roundRectangleShape(size: Size.square(12),cornerSize: Size.square(3)),
                    shape: IndicatorShape.circle(
                      size: 15,
                    ),
                    align: IndicatorAlign.bottom,
                    indicatorColor: Colors.white,
                    indicatorSelectorColor: Colors.black, //Color(0xFF1A3D7A),
                    indicatorSpace: 10.0,
                    child: PageView(
                      controller: controller,
                      //scrollDirection: Axis.vertical,
                      //pageSnapping: false,
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        introContainer(
                          "assets/image/missStitch.png",
                          "Get Start With Us",
                        ),
                        introContainer(
                          "assets/image/Black logo - no background.png",
                          "Get it Stitch and Wear",
                        ),
                      ],
                    ),
                  )),
            ),

            ///////////////// Log In Button  Start///////////////
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.transparent),
                        //width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                           Navigator.push(context,
                                  SlideLeftRoute(page: LoginScreen()));
                          },
                          child: Text(
                            'Log In',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Color(0XFF1A3D7A),
                              fontSize: 16.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 2.0, shadowColor: Colors. blueGrey, 
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            primary:Colors.white, // Background color
                          ),
                          // color: Colors.white,
                          // elevation: 2.0,
                          // //splashColor: Colors.blueGrey,
                          // shape: new RoundedRectangleBorder(
                          //     borderRadius: new BorderRadius.circular(5.0)),
                        )),
                  ),
                ],
              ),
            ),
            ///////////////// Log In Button  End///////////////
          ],
        ));
  }
}

