import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/admin/admin_home.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: EdgeInsets.only(top: 45, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 53, 51, 51),
                    Colors.black,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                        MediaQuery.of(context).size.width, 110)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 60),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Let's start with\n       Admin!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, top: 5, bottom: 5),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 160, 160, 147),
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: TextFormField(
                                    controller: _usernameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Username";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username",
                                      hintStyle: TextStyle(color:Color.fromARGB(255, 160, 160, 147) ),
                                    
                                    ),
                                    
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, top: 5, bottom: 5),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 160, 160, 147),
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: TextFormField(
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Password";
                                      }
                                      return null;
                                    },
                                    decoration:const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color:Color.fromARGB(255, 160, 160, 147) ),
                                    
                                    ),
                                    
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 60.0,
                              ),
                              GestureDetector(
                                onTap: (){
                                  LoginAdmin();
                                },
                                child: Container(
                                  padding:const EdgeInsets.symmetric(vertical: 12.0),
                                  margin:const EdgeInsets.symmetric(horizontal: 20.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 30, 29, 29),
                                      borderRadius: BorderRadius.circular(10)),
                                  child:const Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
  LoginAdmin() {
    FirebaseFirestore.instance.collection("admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != _usernameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your id is not correct",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (result.data()['password'] !=
            _passwordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your password is not correct",
                style: TextStyle(fontSize: 18.0),
              )));
        } else {
          Route route = MaterialPageRoute(builder: (context) =>AdminHome());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
