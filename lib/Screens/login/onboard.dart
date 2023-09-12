import 'package:accident_dectection/Screens/login/welcom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../components/appcolor.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController();
  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                buildContainer(height,AppColors.red ," User safety Check" , "onbordone.png"),
                buildContainer(height,AppColors.brwon ,"Location tracking and Sharing" , "location.png"),
                buildContainer(height,AppColors.indigo ,"Real-time accident Detection" , "onbordthree.png"),
              ],
            ),
            Positioned(
              bottom: height * 0.06,
              child: GestureDetector(
                onTap: () {
                  if (pageindex == 2) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen()));
                  } else {
                    setState(() {
                      pageindex = pageController.page!.toInt() + 1;
                    });
                    pageController.animateToPage(pageController.page!.toInt() + 1,
                        duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
                  }
                },
                child: Container(
                  height: height * 0.09,
                  width: height * 0.09,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ]),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    pageindex == 2 ? Icons.check : Icons.chevron_right_rounded,
                    color: AppColors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(double height,Color color,String title, String image){

    return Container(
      color: color,
      child: Column(
        children: [
          SizedBox(
            height: height * 0.13,
          ),
          SizedBox(
            width: 250,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                color:Colors.white
              ),
            ),
          ),
          SizedBox(
            height: height * 0.08,
          ),
          SizedBox(
            height: height * 0.34,
            child: Image.asset(
              'assets/images/$image',
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}