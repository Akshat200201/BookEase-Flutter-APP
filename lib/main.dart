import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the splash screen file
import 'pdf_reader.dart'; // Import the PDF reader file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Reader',
      debugShowCheckedModeBanner: false,
      home: SplashScreenApp(),
    );
  }
}

class SplashScreenApp extends StatefulWidget {
  @override
  _SplashScreenAppState createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  @override
  void initState() {
    super.initState();
    _navigateToMainApp();
  }

  Future<void> _navigateToMainApp() async {
    await Future.delayed(Duration(milliseconds: 2000)); // Adjust the duration as needed
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PDFReaderApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(); // Display the splash screen
  }
}
