import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'about_us_page.dart'; // Import the About Us page

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkModeEnabled = false;

  void toggleDarkMode() {
    setState(() {
      isDarkModeEnabled = !isDarkModeEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Reader',
      debugShowCheckedModeBanner: false,
      theme: isDarkModeEnabled
          ? ThemeData.dark().copyWith(
              primaryColor: Colors.deepPurple,
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurpleAccent),
            )
          : ThemeData(
              primarySwatch: Colors.deepPurple,
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.deepPurple,
              ),
            ),
      home: PDFReader(
        toggleDarkMode: toggleDarkMode,
        isDarkModeEnabled: isDarkModeEnabled,
      ),
    );
  }
}

class PDFReader extends StatefulWidget {
  final VoidCallback toggleDarkMode;
  final bool isDarkModeEnabled;

  PDFReader({
    required this.toggleDarkMode,
    required this.isDarkModeEnabled,
  });

  @override
  _PDFReaderState createState() => _PDFReaderState();
}

class _PDFReaderState extends State<PDFReader> {
  String? pdfFilePath;

  void _openSettingsMenu() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('About Us'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()), // Navigate to the About Us page
                  );
                },
              ),
              ListTile(
                title: const Text('Contact Us'),
                onTap: () {
                  // TODO: Handle "Contact Us" action
                  Navigator.pop(context); // Close the dialog
                },
              ),
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: widget.isDarkModeEnabled,
                onChanged: (bool value) {
                  widget.toggleDarkMode();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PDF Reader',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: _openSettingsMenu,
          ),
        ],
      ),
      body: Center(
        child: pdfFilePath != null
            ? PDFView(
                filePath: pdfFilePath!,
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: true,
                pageSnap: true,
                nightMode: widget.isDarkModeEnabled ? false : true,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.picture_as_pdf,
                    size: 100,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );

                      if (result != null) {
                        setState(() {
                          pdfFilePath = result.files.single.path!;
                        });
                      }
                    },
                    icon: const Icon(Icons.file_upload),
                    label: const Text('Select PDF', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      textStyle: const TextStyle(fontSize: 18),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
