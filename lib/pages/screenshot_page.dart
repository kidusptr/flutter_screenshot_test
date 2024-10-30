import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:screenshot_test/pages/long_widget.dart';

class ScreenShotPage extends StatefulWidget {
  const ScreenShotPage({super.key});

  @override
  State<ScreenShotPage> createState() => _ScreenShotPageState();
}

class _ScreenShotPageState extends State<ScreenShotPage> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Screenshot(
            controller: screenshotController,
            child: _buildList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.screenshot),
          onPressed: () async {
            // Capture the screenshot
            final capturedImage = await screenshotController
                .captureFromLongWidget(InheritedTheme.captureAll(
                    context,
                    Material(
                      child: _buildList(),
                    )));

            _showCapturedImage(capturedImage);
          },
        ),
      ),
    );
  }

  void _showCapturedImage(Uint8List screenshot) {
    showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Image.memory(screenshot),
          ),
        );
      },
    );
  }
}

Widget _buildList() {
  return Column(
    children: List.generate(30, (index) => CustomContainer(index: index)),
  );
}
