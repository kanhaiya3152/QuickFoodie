import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.details});
  String image, name, details, price;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int a = 1, total = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    total = int.parse(widget.price);
  }

  // Store cart details data to firestore
  final String id = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addOrUpdateFoodToCart(Map<String, dynamic> userInfoMap, String id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection('cart')
          .where("Name", isEqualTo: widget.name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Item already in cart, update the quantity and total
        DocumentSnapshot doc = querySnapshot.docs.first;
        int existingQuantity = int.parse(doc["Quantity"]);
        int newQuantity = existingQuantity + a;
        int existingTotal = int.parse(doc["Total"]);
        int newTotal = existingTotal + total;

        await doc.reference.update({
          "Quantity": newQuantity.toString(),
          "Total": newTotal.toString(),
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Item quantity updated in cart")));
      } else {
        // Item not in cart, add new item
        await FirebaseFirestore.instance
            .collection("users")
            .doc(id)
            .collection('cart')
            .add(userInfoMap);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Food added to cart")));
      }
    } catch (e) {
      debugPrint("Not added : $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.01),
            child: Image.network(
              widget.image,
              width: screenWidth,
              height: screenHeight / 2.5,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: screenHeight * 0.025,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
                const Spacer(), // provides the space between the two widget(just like spaceBetween)
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (a > 1) {
                          --a;
                          total = total - int.parse(widget.price);
                        }

                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(screenHeight * 0.01)),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.04,
                ),
                Text(
                  a.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.022,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(
                  width: screenWidth * 0.04,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ++a;
                        total = total + int.parse(widget.price);
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(screenHeight * 0.01)),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
              padding: EdgeInsets.only(left: screenWidth * 0.05,right:screenWidth * 0.05, ),
              child: Text(
                widget.details,
                style: const TextStyle(color: Colors.black54),
                maxLines: 3,
              )),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Container(
            padding: EdgeInsets.only(left: screenWidth * 0.05),
            child: Row(
              children: [
                Text(
                  "Delivery Time",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.022,
                      fontFamily: 'Poppins',
                      color: Colors.black),
                ),
                SizedBox(
                  width: screenWidth * 0.08,
                ),
                const Icon(
                  Icons.alarm,
                ),
                SizedBox(
                  width: screenWidth * 0.015,
                ),
                Text(
                  "30 min",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.022,
                      fontFamily: 'Poppins',
                      color: Colors.black),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05, bottom: screenHeight * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.022,
                          fontFamily: 'Poppins',
                          color: Colors.black),
                    ),
                    Text(
                      "\$" + total.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.026,
                          fontFamily: 'Poppins',
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Map<String, dynamic> addFoodtoCart = {
                    "Name": widget.name,
                    "Quantity": a.toString(),
                    "Total": total.toString(),
                    "Image": widget.image,
                  };
                  await addOrUpdateFoodToCart(addFoodtoCart, id);
                },
                child: Container(
                  margin: EdgeInsets.only(right: screenWidth * 0.05, bottom: screenHeight * 0.06),
                  height: screenHeight * 0.05,
                  width: screenWidth / 2.8,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(screenHeight * 0.015)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
                    child: _isLoading
                        ? Center(
                            child: SizedBox(
                              height: screenHeight * 0.03,
                              width: screenHeight * 0.03,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            "Add to cart",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.02,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}