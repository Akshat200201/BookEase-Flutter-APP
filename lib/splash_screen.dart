import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple, // Background color of the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 100.0, // Size of the Flutter logo on the splash screen
              textColor: Colors.white, // Color of the Flutter logo
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to PDF Reader', // Your app's name or welcome message
              style: TextStyle(
                color: Colors.white, // Text color
                fontSize: 20.0, // Text size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
