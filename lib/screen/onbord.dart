import 'package:flutter/material.dart';
import 'package:quick_foodie/model/content_model.dart';
import 'package:quick_foodie/screen/login_screen.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: content.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05,
                    top: screenHeight * 0.05,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        content[i].image,
                        height: screenHeight * 0.5,
                        width: screenWidth,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Text(
                        content[i].title,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.03,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        content[i].description,
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: screenHeight * 0.02,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(content.length, (index) => buildDot(index, context)),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          GestureDetector(
            onTap: () {
              if (currentIndex == content.length - 1) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const LoginScreen(),
                  ),
                );
              } else {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              }
            },
            child: Container(
              margin: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(screenWidth * 0.1),
              ),
              height: screenHeight * 0.08,
              width: double.infinity,
              child: Center(
                child: Text(
                  currentIndex == content.length - 1 ? 'Start' : 'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.03,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.012,
      width: currentIndex == index ? screenHeight * 0.022 : screenHeight * 0.012,
      margin: EdgeInsets.only(right: screenHeight * 0.005),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * 0.006),
        color: Colors.black38,
      ),
    );
  }
}