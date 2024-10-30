import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScreenShotPage extends StatefulWidget {
  const ScreenShotPage({super.key});

  @override
  State<ScreenShotPage> createState() => _ScreenShotPageState();
}

class _ScreenShotPageState extends State<ScreenShotPage> {
  late final WebViewController _webViewController;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://mern-demo-kkmv.onrender.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenshot(
        controller: screenshotController,
        child: WebViewWidget(controller: _webViewController),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.screenshot),
        onPressed: () async {
          // Capture the screenshot
          final capturedImage = await screenshotController
              .captureFromLongWidget(InheritedTheme.captureAll(
                  context,
                  Material(
                    child: WebViewWidget(controller: _webViewController),
                  )));

          if (capturedImage != null) {
            _showCapturedImage(capturedImage);
          }
        },
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
