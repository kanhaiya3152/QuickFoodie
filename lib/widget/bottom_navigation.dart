import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screen/home_screen.dart';
import 'package:food_delivery_app/screen/order_screen.dart';
import 'package:food_delivery_app/screen/profile_screen.dart';
import 'package:food_delivery_app/screen/wallet.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  late List<Widget> page;
  late Widget currentPage;
  late HomeScreen home;
  late ProfileScreen profile;
  late OrderScreen order;
  late Wallet wallet;

  @override
  void initState() {
    home = HomeScreen();
    order = OrderScreen();
    profile = ProfileScreen();
    wallet = Wallet();
    page = [home, order, wallet, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.black,
        height: 65,
        animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentIndex=index;
            });
          },
          items: [
            Icon(Icons.home_outlined,color: Colors.white,),
            Icon(Icons.shopping_bag_outlined,color: Colors.white,),
            Icon(Icons.wallet_outlined,color: Colors.white,),
            Icon(Icons.person_outline,color: Colors.white,),
          ]
          ),
          body: page[currentIndex],
    );
  }
}
