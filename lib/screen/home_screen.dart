import 'package:flutter/material.dart';
import 'package:food_delivery_app/screen/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool iceCream = false, burger = false, pizza = false, salad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20, top: 42, right: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hello Kanhaiya,",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                  Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4)),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      )),
                ],
              ),
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
              showItems(), // call the all items
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => DetailsScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/salad2.png',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Vegie Taco Hash ",
                                  style: TextStyle(
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
                                const Text(
                                  "\$25",
                                  style: TextStyle(
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
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/salad2.png',
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Vegie Taco Hash ",
                              style: TextStyle(
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
                            const Text(
                              "\$25",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/salad2.png',
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Vegie Taco Hash ",
                              style: TextStyle(
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
                            const Text(
                              "\$25",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/salad2.png',
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: const Text(
                                "Medditerranean Chickpea Salad ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: const Text(
                                "Honey goot cheese",
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: const Text(
                                "\$25",
                                style: TextStyle(
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
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/salad2.png',
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: const Text(
                                "Medditerranean Chickpea Salad ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: const Text(
                                "Honey goot cheese",
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: const Text(
                                "\$25",
                                style: TextStyle(
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
              )
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
          onTap: () {
            iceCream = true;
            burger = false;
            pizza = false;
            salad = false;
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: iceCream ? Colors.black12 : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
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
          onTap: () {
            iceCream = false;
            burger = true;
            pizza = false;
            salad = false;
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burger ? Colors.black12 : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
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
          onTap: () {
            iceCream = false;
            burger = false;
            pizza = true;
            salad = false;
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.black12 : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
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
          onTap: () {
            iceCream = false;
            burger = false;
            pizza = false;
            salad = true;
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad ? Colors.black12 : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
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
