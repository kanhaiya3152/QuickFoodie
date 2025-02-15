import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Stream? foodStream;
  int total = 0;
  int walletBalance = 0;
  bool _isloading = false;

  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  Future<Stream<QuerySnapshot>> getFoodItems(String userId) async {
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("cart")
          .snapshots();
    } catch (error) {
      debugPrint("❌ Failed to retrieve data : $error");
      rethrow;
    }
  }

  updateUserWallet(String id, int amount) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"walletBalance": amount});
  }

  Future<void> clearCart(String userId) async {
    final cartCollection = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart");

    final cartSnapshot = await cartCollection.get();
    for (var doc in cartSnapshot.docs) {
      await doc.reference.delete();
    }
  }

  void startTimer() {
    Timer(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  ontheLoad() async {
    if (userId == null) {
      debugPrint("User is not logged in.");
      return;
    }
    foodStream = await getFoodItems(userId!);
    setState(() {});
  }

  @override
  void initState() {
    startTimer();
    ontheLoad();
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

  int calculateTotal(AsyncSnapshot snapshot) {
    int sum = 0;
    for (var doc in snapshot.data.docs) {
      sum += int.parse(doc["Total"]);
    }
    return sum;
  }

  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    total = calculateTotal(snapshot);
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.network(
                                  ds["Image"],
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ds["Name"],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins",
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "\$" + ds["Total"],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins",
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(ds["Quantity"]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Scaffold(
        body: Center(
          child: Text("Please log in to view your orders."),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // toolbarHeight: 60,
        centerTitle: false,
        title: Text(
          "Cart",
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              foodCart(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      color: Colors.black),
                ),
                Text(
                  "\$" + total.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      color: Colors.black),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (total > 0) {
                setState(() {
                  _isloading = true;
                });
                int amount = walletBalance - total;
                await updateUserWallet(userId!, amount);
                await clearCart(userId!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Ordered successfully !"),
                  ),
                );
                setState(() {
                  total = 0;
                  _isloading = false;
                });
              }
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              padding: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: _isloading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "Place Order",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
