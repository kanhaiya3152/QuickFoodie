import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/admin/admin_screen.dart';
import 'package:quick_foodie/screen/forgot_password_screen.dart';
import 'package:quick_foodie/screen/signup_screen.dart';
import 'package:quick_foodie/widget/bottom_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password = "", email = "";
  bool _isLoading = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  userLogin() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
          backgroundColor: Colors.green, content: Text('Login Successfully'))));

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const BottomNavigation()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text('No user found!')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text('Password incorrect')));
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
                        height: screenHeight / 2.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              const Text(
                                'Login',
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
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter your email';
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
                                    return 'Enter your password';
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
                                height: screenHeight * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ForgotPasswordScreen()));
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
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
                                      password = _passwordController.text;
                                      _isLoading = true;
                                    });
                                  }
                                  userLogin();
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
                                              'LOGIN',
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
                            "Don't have an account ? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => const SignupScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                " Sign up ",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 94, 172, 1),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    const Divider(),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => const AdminScreen()));
                      },
                      child: Container(
                        width: screenWidth * 0.55,
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Login as Admin",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
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
