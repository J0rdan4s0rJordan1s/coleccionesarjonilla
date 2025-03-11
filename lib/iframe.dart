import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'dart:ui' as ui;

class IframeWidget extends StatelessWidget {
  final String url;
  final double width;
  final double height;

  const IframeWidget({required this.url, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    String htmlId = "flutter_webview_$url";
  
    // Registra la vista HTML
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final iframe = web.document.createElement('iframe') as web.HTMLIFrameElement;
      iframe.src = url;
      iframe.style.border = 'none';
      iframe.style.width = '100%';
      iframe.style.height = '100%';
      return iframe;
    });

    // Muestra la vista HTML
    return SizedBox(
      width: width,
      height: height,
      child: HtmlElementView(viewType: htmlId),
    );
  }
}

class WebAppView extends StatelessWidget {
  final String url;
  final ValueNotifier<bool> isDarkMode;
  final VoidCallback toggleTheme;

  const WebAppView({super.key, required this.url, required this.isDarkMode, required this.toggleTheme});

 @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, darkModeValue, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: darkModeValue ? const Color(0xffd6a469) : Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return IframeWidget(
                url: url,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              );
            },
          ),
          backgroundColor: darkModeValue ? const Color(0xff15181e) : Colors.white, // Añade un color de fondo al Scaffold
        );
      },
    );
  }
}