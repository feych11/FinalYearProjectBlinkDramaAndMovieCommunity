import 'dart:async';

import 'package:finalsemproject/Screens/LoginChioceScreen.dart';
import 'package:flutter/material.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 5), () {

      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Dashboard()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const Color mateBlack = Color(0xFF242424);
    return Scaffold(
      //backgroundColor: Color(0xFF242424),
      backgroundColor: Colors.white,
      body: SafeArea(child: Center(child: Image.asset('Images/SplashScreen48.jpg',height: 550,width: 1000,))),
    );
  }
}
