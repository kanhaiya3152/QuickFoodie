import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/screen/payment_screen.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int walletBalance = 0;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    fetchWalletBalance();
  }

  Future<void> fetchWalletBalance() async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    final snapshot = await userDoc.get();

    if (snapshot.exists) {
      setState(() {
        walletBalance = snapshot.data()!['walletBalance'];
      });
    } else {
      debugPrint("User document does not exist!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: screenHeight * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                child: const Center(
                  child: Text(
                    'Wallet',
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01, horizontal: screenWidth * 0.03),
              width: screenWidth,
              decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
              child: Row(
                children: [
                  Image.asset(
                    'assets/wallet.png',
                    height: screenHeight * 0.08,
                    width: screenHeight * 0.08,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: screenWidth * 0.1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your Wallet",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Text(
                        "\$" + walletBalance.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.025),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Add money",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE9E2E2)),
                    borderRadius: BorderRadius.circular(screenWidth * 0.01),
                  ),
                  child: Text(
                    "\$100",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: screenHeight * 0.02),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE9E2E2)),
                    borderRadius: BorderRadius.circular(screenWidth * 0.01),
                  ),
                  child: Text(
                    "\$500",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: screenHeight * 0.02),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE9E2E2)),
                    borderRadius: BorderRadius.circular(screenWidth * 0.01),
                  ),
                  child: Text(
                    "\$1000",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: screenHeight * 0.02),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE9E2E2)),
                    borderRadius: BorderRadius.circular(screenWidth * 0.01),
                  ),
                  child: Text(
                    "\$2000",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: screenHeight * 0.02),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(

                  MaterialPageRoute(
                    builder: (ctx) =>const PaymentScreen(),
                  ),
                ).then((_) => fetchWalletBalance()); // Refresh balance after returning
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                width: screenWidth,
                decoration: BoxDecoration(
                  color: const Color(0xFF008080),
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                child: Center(
                  child: Text(
                    'Add Money',
                    style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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