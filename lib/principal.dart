import 'package:flutter/material.dart';

/// Widget principal de la aplicación. Muestra la pantalla principal con una barra de aplicación
/// y un botón para cambiar entre modo oscuro y claro.
class Principal extends StatelessWidget {
  /// `true` si el modo oscuro está activado, `false` si no.
  final ValueNotifier<bool> isDarkMode;

  /// Función llamada al presionar el botón de cambio de tema.
  final VoidCallback toggleTheme;

  /// Constructor.
  const Principal({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode, // Escucha cambios en isDarkMode.
      builder: (context, darkModeValue, child) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(), // Widget inicial (vacío).
            centerTitle: true, // Centra el título.
            title: Text(
              'Principal',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkModeValue ? Colors.white : Colors.black, // Color del texto.
              ),
            ),
            backgroundColor: darkModeValue ? Colors.black : Colors.white, // Color de fondo.
            actions: [
              IconButton(
                icon: Icon(
                  darkModeValue ? Icons.light_mode : Icons.dark_mode, // Icono.
                  color: darkModeValue
                      ? const Color(0xffd6a469)
                      : Colors.black, // Color del icono.
                ),
                onPressed: toggleTheme, // Llama a la función.
              ),
            ],
          ),
          body: Column(
            children: [
              // Sección superior con imagen y texto.
              Container(
                width: double.infinity,
                color: darkModeValue ? const Color(0xff15181e) : Colors.white, // Color.
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Image.asset('assets/images/diputacion.png',
                        fit: BoxFit.cover), // Imagen.
                    const SizedBox(height: 5),
                    Text(
                      'Actividad subvencionada por la Diputación de Jaén',
                      style: TextStyle(
                        fontSize: 14,
                        color: darkModeValue ? Colors.white : Colors.black, // Color.
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Contenedor que ocupa el espacio restante.
              Expanded(
                child: Container(
                  color: darkModeValue
                      ? const Color(0xff15181e)
                      : Colors.white, // Color
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}