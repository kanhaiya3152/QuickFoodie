import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screen/onbord.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // duration - 3sec means splashScreen bas 3 sec ke liye visible ho uske baad phir ye login page me navigate ke jaye
    // or pushReplacement direct app se bahar aa jata h wo piche wala page me nhi jata h
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) =>const Onboard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset('assets/logo.png',height: 50,width: 300,),
          ],
        ),
      ),
    );
  }
}
