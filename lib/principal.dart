import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  final ValueNotifier<bool> isDarkMode;
  final VoidCallback toggleTheme;

  const Principal({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, darkModeValue, child) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(), // IMPORTANTE: Container vacío
            centerTitle: true,     // IMPORTANTE: Centrar el título
            title: Text(
                    'Principal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: darkModeValue ? Colors.white : Colors.black,
                    ),

                  ),
            backgroundColor: darkModeValue ? Colors.black : Colors.white,
            actions: [
              IconButton(
                icon: Icon(
                  darkModeValue ? Icons.light_mode : Icons.dark_mode,
                  color: darkModeValue
                      ? const Color(0xffd6a469)
                      : Colors.black,
                ),
                onPressed: toggleTheme,
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                color: darkModeValue ? const Color(0xff15181e) : Colors.white,
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Image.asset('assets/images/diputacion.png',
                        fit: BoxFit.cover),
                    const SizedBox(height: 5),
                    Text(
                      'Actividad subvencionada por la Diputación de Jaén',
                      style: TextStyle(
                        fontSize: 14,
                        color: darkModeValue ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: darkModeValue
                      ? const Color(0xff15181e)
                      : Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}