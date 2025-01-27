import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/content_model.dart';
import 'package:food_delivery_app/screen/signup_screen.dart';

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
                    padding: EdgeInsets.only(left: 20,right: 20,top: 40),
                    child: Column(
                      children: [
                        Image.asset(content[i].image,height: 450,width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
                        SizedBox(height: 40,),
                        Text(content[i].title,style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontWeight: FontWeight.bold,fontSize: 22),),
                        SizedBox(height: 20,),
                        Text(content[i].description,style: TextStyle(color: Colors.black54,fontFamily: 'Poppins',fontWeight: FontWeight.w500,fontSize: 16),),
                      ],
                    ),
                  );
                }),
          ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  List.generate(content.length, (index) =>
                   buildDot(index,context)),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  if(currentIndex == content.length-1){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>SignupScreen() ,),);
                  }
                  _controller.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(40)),
                  height: 60,
                  width: double.infinity,
                  child: Center(child: Text(currentIndex == content.length-1 ? 'Start' :'Next',style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.bold,fontSize: 25),)),
                ),
              )
        ],
      ),
    );
  }
  Container buildDot(int index,BuildContext context){
    return Container(
      height: 10,
      width: currentIndex==index ? 18 :7,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.black38),
    );
  }
}
