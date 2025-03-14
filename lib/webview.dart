import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Un widget que muestra una página web dentro de la aplicación usando un WebView.
class WebViewPage extends StatelessWidget {
  /// La URL de la página web que se va a mostrar.
  final String url;

  /// Un `ValueNotifier<bool>` que indica si el modo oscuro está habilitado (`true`) o no (`false`).
  final ValueNotifier<bool> isDarkMode;

  /// Una función callback que se llama cuando el usuario quiere cambiar entre los modos de tema claro y oscuro.
  final VoidCallback toggleTheme;

  /// Constructor para la clase `WebViewPage`.
  ///
  ///   - `key`: Una clave opcional para el widget.
  ///   - `url`: La URL de la página web a cargar (requerido).
  ///   - `isDarkMode`: El `ValueNotifier` que controla el estado del modo oscuro (requerido).
  ///   - `toggleTheme`: La función callback para cambiar el tema (requerido).
  const WebViewPage({super.key, required this.url, required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode, // Escucha los cambios en el modo oscuro.
      builder: (context, darkModeValue, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "360", // Título de la AppBar.
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkModeValue ? Colors.white : Colors.black, // Color del texto según el tema.
              ),
            ),
            backgroundColor: darkModeValue ? Colors.black : Colors.white, // Color de fondo de la AppBar según el tema.
            centerTitle: true, // Centra el título en la AppBar.
            actions: [
              IconButton(
                icon: Icon(
                  darkModeValue ? Icons.light_mode : Icons.dark_mode, // Icono para cambiar entre modo claro/oscuro.
                  color: darkModeValue ? const Color(0xffd6a469) : Colors.black, // Color del icono según el tema.
                ),
                onPressed: toggleTheme, // Llama a la función para cambiar el tema.
              ),
            ],
          ),
          // Muestra el WebView.  Usa `WebViewWidget` y `WebViewController` de la librería `webview_flutter`.
          body: WebViewWidget(
            controller: WebViewController() // Crea y configura el controlador del WebView.
              ..loadRequest(Uri.parse(url)) // Carga la URL proporcionada.
              ..setJavaScriptMode(JavaScriptMode.unrestricted), // Habilita JavaScript sin restricciones.
          ),
          backgroundColor: darkModeValue? Color(0xFF15181E): Colors.white, // Color de fondo del Scaffold.
        );
      },
    );
  }
}