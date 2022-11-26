import 'package:flutter/material.dart';
import 'package:miss_stitch/screens/IntroPage/introPage.dart';
import 'package:miss_stitch/screens/signUp.dart';

void main() {
  runApp(const MyApp());
}

int bottomNavIndex = 0;
Color appColor = Color(0xFFc5a3f9);
Color appSecondColor = Color.fromARGB(255, 169, 120, 244);

int notificCount = 0;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: IntroPage(), //const SignUpScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SafeArea(child: SignUpScreen()),
//     );
//   }
// }
