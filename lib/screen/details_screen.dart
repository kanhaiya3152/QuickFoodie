import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int a = 1;
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
            child: Image.asset(
              'assets/salad2.png',
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Medditerranean ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                    Text(
                      "Chickpea Salad  ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
                const Spacer(), // provides the space between the two widget(just like spacebetween)
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(a>1){
                          --a;
                        }
                        
                        setState(() {
                          
                        });
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
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontFamily: 'Poppins'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ++a;
                        setState(() {
                          
                        });
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
          const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: const Text('Stunning Animating Curved Shape Navigation Bar. Adjustable color, background color, animation curve, animation duration Adjustable color, background color, animation curve, animation duration.',style: TextStyle(color: Colors.black54),maxLines: 3,)),

          const SizedBox(height: 30,),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child:const Row(
              children: [
                Text("Delivery Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'Poppins',color: Colors.black),),
                SizedBox(width: 30,),
                Icon(Icons.alarm,),
                SizedBox(width: 6,),
                Text("30 min",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'Poppins',color: Colors.black),),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20,bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'Poppins',color: Colors.black),),
                    Text("\$25",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,fontFamily: 'Poppins',color: Colors.black),),
                  ],
                ),
              ),
              const SizedBox(width: 70,),
              Container(
                margin: const EdgeInsets.only(right: 10,bottom: 50),
                height: 50,
                width: 210,
                decoration: BoxDecoration(color:Colors.black,borderRadius:  BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 18,top: 10,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add to cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(color:  Colors.grey,borderRadius: BorderRadius.circular(8)),
                        child:  const Icon(Icons.shopping_cart_outlined,color: Colors.white,),
                      )
                    ],
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
