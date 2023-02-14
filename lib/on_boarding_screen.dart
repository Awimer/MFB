import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'activity_screen.dart';
import 'build_page.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = 'on boarding';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  bool isFirstPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() => isLastPage = index == 2);
                setState(() => isFirstPage = index == 0);
              },
              children: [
                buildPage(
                  color: Colors.white,
                  urlImage: 'assets/images/page1.png',
                  title: 'Welcome to Marketing Football Player App',
                  subtitle:
                      'Here you can easily search for professional players. Get started now and find the perfect player for your team.',
                ),
                buildPage(
                  color: Colors.white,
                  urlImage: 'assets/images/page2.png',
                  title: 'Create your profile to start exploring players',
                  subtitle:
                      'You can build your profile with a photo, bio, and other information about yourself. This will help the coaches get to know you better.',
                ),
                buildPage(
                  color: Colors.white,
                  urlImage: 'assets/images/page3.png',
                  title: 'Show your skills to world And let everyone watch',
                  subtitle:
                      'Upload videos of yourself playing football to show off your best moves. Coaches will be able to see what you can do',
                ),
              ],
            ),
          ),
        ),
        bottomSheet: isLastPage
            ? Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => controller.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: Text(
                        'Previous',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: WormEffect(
                            spacing: 16,
                            dotColor: Colors.grey,
                            activeDotColor: Colors.red),
                        onDotClicked: (index) => controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        // navigate directly to home screen
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showHome', true);

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => AciviyScreen()));
                      },
                      child: Text(
                        'Lets go',
                        style: TextStyle(color: Colors.red, fontSize: 17),
                      ),
                    ),
                  ],
                ))
            : isFirstPage
                ? Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => controller.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: Text(''),
                        ),
                        Center(
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: WormEffect(
                                spacing: 16,
                                dotColor: Colors.grey,
                                activeDotColor: Colors.red),
                            onDotClicked: (index) => controller.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(color: Colors.red, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => controller.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: Text(
                            'Previous',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Center(
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: WormEffect(
                                spacing: 16,
                                dotColor: Colors.grey,
                                activeDotColor: Colors.red),
                            onDotClicked: (index) => controller.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(color: Colors.red, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ));
  }
}
