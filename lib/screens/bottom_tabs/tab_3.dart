import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io' show Platform;

class BottomTab3 extends StatefulWidget {
  const BottomTab3({super.key});

  @override
  State<BottomTab3> createState() => _BottomTab3State();
}

class _BottomTab3State extends State<BottomTab3> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      // Only run this on mobile or desktop
      if (Platform.isAndroid) {
        // WebView.platform = SurfaceAndroidWebView();
      }

      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse("https://www.google.com"));
    }
  }

  @override
  Widget build(BuildContext context) {
    // WebView is not supported on Web yet, show fallback
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(title: const Text("WebView (Web fallback)")),
        body: const Center(
          child: Text("WebView is not supported on Web. Use an iframe or link."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView in BottomTab3"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller?.reload();
            },
          )
        ],
      ),
      body: WebViewWidget(controller: _controller!),
    );
  }
}
