import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/model/users.dart';
import 'package:quick_foodie/screen/login_screen.dart';
import 'package:quick_foodie/widget/bottom_navigation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String name = '', password = '', email = '';
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> registration({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      Users user = Users(
        uid: userId,
        username: name,
        email: email,
        walletBalance: 0,
      );

      await _firestore.collection('users').doc(userId).set(user.toJson());
      setState(() {
        _isLoading = false;
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Registered Successfully'),
        ));

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => BottomNavigation()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      String errorMessage = "Registration failed";
      if (e.code == 'weak-password') {
        errorMessage = "Password is too weak";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "Email already exists";
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(errorMessage),
        ));
      }
    } catch (e) {
      debugPrint("Registration Error: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("An unexpected error occurred"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight / 2.5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFff5c30), Color(0xFFe74b1a)])),
              ),
              Container(
                margin: EdgeInsets.only(top: screenHeight / 3),
                width: screenWidth,
                height: screenHeight / 1.45,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.1,
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo.png',
                        width: screenWidth / 1.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        width: screenWidth,
                        height: screenHeight / 1.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              const Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              TextFormField(
                                controller: _nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter name';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                  prefixIcon: Icon(Icons.password_outlined),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.06,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      email = _emailController.text;
                                      name = _nameController.text;
                                      password = _passwordController.text;
                                    });
                                  }
                                  registration(
                                    email: email,
                                    password: password,
                                    name: name,
                                    context: context,
                                  );
                                },
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.01),
                                    width: screenWidth * 0.5,
                                    decoration: BoxDecoration(
                                        color: const Color(0Xffff5722),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: _isLoading
                                        ? const Center(
                                            child: SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : const Center(
                                            child: Text(
                                              'SIGN UP',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins1',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: screenWidth * 0.1),
                      child: Row(
                        children: [
                          const Text(
                            "Already have an account ?",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 94, 172, 1),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}