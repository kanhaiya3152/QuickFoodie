import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/screen/details_screen.dart';
import 'package:quick_foodie/screen/order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool iceCream = false, burger = false, pizza = false, salad = false;

  Stream? foodItemStream;

  // retrieve data from firestore
  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  String username = "";
  Future<void> getDetails() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();
      if (snapshot.exists) {
        setState(() {
          username = snapshot.data()?["username"] ?? " ";
        });
      }
    }
  }

  ontheLoad() async {
    foodItemStream = await getFoodItem("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    ontheLoad();
    getDetails();
    super.initState();
  }

  Widget allItemshorizontally() {
    return StreamBuilder(
        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => DetailsScreen(
                                image: ds["image"],
                                name: ds["name"],
                                price: ds["price"],
                                details: ds["details"])));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    ds["image"],
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  ds['name'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Fresh and Healthy",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Poppins'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "\$" + ds['price'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
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

  Widget allItemsverically() {
    return StreamBuilder(
        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => DetailsScreen(
                                image: ds["image"],
                                name: ds["name"],
                                price: ds["price"],
                                details: ds["details"])));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    ds["image"],
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        ds["name"],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        "Fresh and Healthy",
                                        style: const TextStyle(
                                            color: Colors.black38,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        "\$" + ds['price'],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Hello ${username},",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => OrderScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
                size: 25,
              ))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text(
              //       "Hello Kanhaiya,",
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: 'Poppins'),
              //     ),
              //     Container(
              //         padding: const EdgeInsets.all(3),
              //         decoration: BoxDecoration(
              //             color: Colors.black,
              //             borderRadius: BorderRadius.circular(4)),
              //         child: const Icon(
              //           Icons.shopping_cart_outlined,
              //           color: Colors.white,
              //         )),
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Delicious Food",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              const Text(
                "Discover and get great food",
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(
                height: 20,
              ),
              showItems(), // calling the all items
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 270,
                child: allItemshorizontally(),
              ),
              // const SizedBox(
              //   height: 30,
              // ),
              // calling the vertically items
              allItemsverically(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            iceCream = true;
            burger = false;
            pizza = false;
            salad = false;
            foodItemStream = await getFoodItem("Ice-cream");
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: iceCream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/ice-cream.png',
                height: 45,
                width: 45,
                color: iceCream ? Colors.white : Colors.black,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            iceCream = false;
            burger = true;
            pizza = false;
            salad = false;
            foodItemStream = await getFoodItem("Burger");
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burger ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/burger.png',
                height: 45,
                width: 45,
                color: burger ? Colors.white : Colors.black,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            iceCream = false;
            burger = false;
            pizza = true;
            salad = false;
            foodItemStream = await getFoodItem("Pizza");
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/pizza.png',
                height: 45,
                width: 45,
                color: pizza ? Colors.white : Colors.black,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            iceCream = false;
            burger = false;
            pizza = false;
            salad = true;
            foodItemStream = await getFoodItem("Salad");
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/salad.png',
                height: 45,
                width: 45,
                color: salad ? Colors.white : Colors.black,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
