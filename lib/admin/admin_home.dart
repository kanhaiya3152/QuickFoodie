import 'package:flutter/material.dart';
import 'package:quick_foodie/admin/add_food.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(child: Text("Home Admin", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Poppins",fontSize: 20)),),
            SizedBox(height: 50.0,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddFood()));
              },
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                    child: Row(children: [
                      Padding(padding: EdgeInsets.all(6.0),
                      child: Image.asset("assets/food.jpg", height: 100, width: 100, fit: BoxFit.cover,),),
                  SizedBox(width: 30.0,) ,
                  Text("Add Food Items", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),) ],),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}