import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/screen/login_screen.dart';
import 'package:quick_foodie/widget/auth_methods.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        setState(() {
          username = snapshot.data()?['username'] ?? '';
          email = snapshot.data()?['email'] ?? '';
        });
      } else {
        debugPrint("User document does not exist!");
      }
    } else {
      debugPrint("User is not logged in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.05,
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05),
                  height: screenHeight / 4.3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(screenWidth, 105),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: screenHeight * 0.055,
                        width: screenWidth * 0.65,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Material(
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.015,
                    horizontal: screenWidth * 0.021,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                        size: screenHeight * 0.025,
                      ),
                      SizedBox(
                        width: screenWidth * 0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenHeight * 0.023,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Material(
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.015,
                    horizontal: screenWidth * 0.021,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.black,
                        size: screenHeight * 0.025,
                      ),
                      SizedBox(
                        width: screenWidth * 0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            email,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenHeight * 0.023,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Material(
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.015,
                    horizontal: screenWidth * 0.021,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.description,
                        color: Colors.black,
                        size: screenHeight * 0.025,
                      ),
                      SizedBox(
                        width: screenWidth * 0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Terms and Conditions",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenHeight * 0.023,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            GestureDetector(
              onTap: () {
                AuthMethods().deleteUser();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Material(
                  borderRadius: BorderRadius.circular(screenWidth * 0.025),
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                    horizontal: screenWidth * 0.021,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: screenHeight * 0.025,
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deleted Account",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenHeight * 0.023,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            GestureDetector(
              onTap: () {
                AuthMethods().signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const LoginScreen(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Material(
                  borderRadius: BorderRadius.circular(screenWidth * 0.025),
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                    horizontal: screenWidth * 0.021,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.black,
                          size: screenHeight * 0.025,
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenHeight * 0.023,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}