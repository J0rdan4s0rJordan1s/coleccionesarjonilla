import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewPage extends StatelessWidget {
  final String url;
  final ValueNotifier<bool> isDarkMode;
  final VoidCallback toggleTheme;

  const WebViewPage({super.key, required this.url, required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, darkModeValue, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "360",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkModeValue ? Colors.white : Colors.black,
              ),
            ),
            backgroundColor: darkModeValue ? Colors.black : Colors.white,
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  darkModeValue ? Icons.light_mode : Icons.dark_mode,
                  color: darkModeValue ? const Color(0xffd6a469) : Colors.black,
                ),
                onPressed: toggleTheme,
              ),
            ],
          ),
          body: WebViewWidget(
            controller: WebViewController()
              ..loadRequest(Uri.parse(url))
              ..setJavaScriptMode(JavaScriptMode.unrestricted),
          ),
          backgroundColor: darkModeValue? Color(0xFF15181E): Colors.white,
        );
      },
    );
  }
}