import 'package:flutter/material.dart';
import 'package:cluck_connect/agent/home_agent.dart';
import 'package:cluck_connect/farmer/home_farmer.dart';
import 'package:cluck_connect/services/api/authentication_api.dart';
import 'package:cluck_connect/authentication/welcoming_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(_controller);

    // Trigger the animation after a delay (e.g., 1 second)
    Future.delayed(const Duration(seconds: 1), () {
      _controller.forward();
    });

    // Check if the user is authenticated
    AuthenticationApi().isAuthenticated().then((isAuthenticated) {
      if (isAuthenticated) {
        // If authenticated, get user details to determine user type
        AuthenticationApi.getUserDetails().then((userDetails) {
          String? userType = userDetails['role']; // Nullable string
          if (userType == 'farmer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePageFarmer()),
            );
          } else if (userType == 'agent') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePageAgent()),
            );
          } else {
            // Handle other user types or scenarios
          }
        });
      } else {
        // If not authenticated, navigate to the welcome screen after 3 seconds
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the touch anywhere on the screen
        _controller.stop(); // Stop the animation
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xff201f1f), // Dark Grey-Black Background Color
        body: Center(
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Replace 'assets/logo.png' with the actual path to your logo asset
                Image.asset(
                  'assets/logo.png',
                  width: 200.0, // Adjust the width as needed
                  height: 200.0, // Adjust the height as needed
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
