import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            children: [
              _buildPage(
                title: "Remote Monitoring",
                description:
                    "Remote monitoring can enable users to monitor their home anytime and anywhere via a mobile application.",
                imagePath: 'assets/recolor1.png',
              ),
              _buildPage(
                title: "Real-Time Notification System",
                description:
                    "The real-time notification system allows users to receive immediate warnings when there is suspicious activity at home",
                imagePath: 'assets/recolor2.png',
              ),
              _buildPage(
                title: "Maximum Security System",
                description:
                    "Combine the Remote Monitoring and Real-Time Notification to achieve Maximum Security System in your house.",
                imagePath: 'assets/recolor3.png',
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Color(0XFF4D6D7A),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF4D6D7A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () {
                      if (currentPage < 2) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        Navigator.pushReplacementNamed(context, 'login');
                      }
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
      {required String title,
      required String description,
      required String imagePath}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 100),
          Image.asset(imagePath, height: 300),
          SizedBox(height: 30),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0XFF4D6D7A)
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16,color: Color(0XFF4D6D7A)),
          ),
        ],
      ),
    );
  }
}