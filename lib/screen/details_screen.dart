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
            margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Image.network(
              widget.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
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
                            borderRadius: BorderRadius.circular(7)),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  a.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(
                  width: 15,
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
                            borderRadius: BorderRadius.circular(7)),
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
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                widget.details,
                style: const TextStyle(color: Colors.black54),
                maxLines: 3,
              )),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: const Row(
              children: [
                Text(
                  "Delivery Time",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      color: Colors.black),
                ),
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.alarm,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "30 min",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
                padding: EdgeInsets.only(left: 20, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Price",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          color: Colors.black),
                    ),
                    Text(
                      "\$" + total.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
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
                  margin: const EdgeInsets.only(right: 20, bottom: 50),
                  height: 45,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 18, top: 10, bottom: 10),
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Add to cart",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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