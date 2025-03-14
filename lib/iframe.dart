import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'dart:ui' as ui;

/// Un widget que incrusta un iframe en una aplicación Flutter para web.
///
/// Este widget utiliza `dart:ui` y `package:web` para crear y mostrar un elemento
/// iframe HTML directamente en el DOM.  Es una solución específica para Flutter Web
/// para mostrar contenido web externo.
class IframeWidget extends StatelessWidget {
  /// La URL que se cargará en el iframe.
  final String url;

  /// El ancho del iframe.
  final double width;

  /// La altura del iframe.
  final double height;

  /// Constructor de la clase `IframeWidget`.
  ///
  ///   - `url`: La URL a cargar (requerido).
  ///   - `width`: El ancho del iframe (requerido).
  ///   - `height`: La altura del iframe (requerido).
  const IframeWidget({required this.url, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    // Genera un ID único para el elemento HTML.  Esto es necesario para registrar
    // y recuperar la vista de la plataforma.  Se usa la URL para que cada iframe
    // tenga su propio ID.
    String htmlId = "flutter_webview_$url";

    // Registra una fábrica de vistas en el registro de vistas de la plataforma.
    // Esto permite a Flutter crear y administrar el elemento HTML (el iframe)
    // dentro de su árbol de widgets.
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      // Crea un elemento iframe usando la API del DOM del navegador (a través de `package:web`).
      final iframe = web.document.createElement('iframe') as web.HTMLIFrameElement;
      iframe.src = url; // Establece la URL del iframe.
      iframe.style.border = 'none'; // Elimina el borde del iframe.
      iframe.style.width = '100%';  // Ancho del 100% del contenedor.
      iframe.style.height = '100%'; // Altura del 100% del contenedor.
      return iframe; // Devuelve el elemento iframe creado.
    });

    // Muestra el elemento HTML (el iframe) dentro del árbol de widgets de Flutter.
    // `HtmlElementView` es un widget de Flutter que permite incrustar elementos HTML.
    return SizedBox(
      width: width, // Ancho del SizedBox, controlado por el parámetro `width`.
      height: height, // Altura del SizedBox, controlada por el parámetro `height`.
      child: HtmlElementView(viewType: htmlId), // Muestra el iframe registrado con el ID `htmlId`.
    );
  }
}

/// Un widget que muestra una aplicación web dentro de un iframe, utilizando `IframeWidget`.
///
/// Esta clase proporciona una estructura básica de Scaffold con una AppBar
/// y un body que contiene el `IframeWidget`.  También maneja el modo oscuro/claro.
class WebAppView extends StatelessWidget {
  /// La URL de la aplicación web a mostrar.
  final String url;

  /// Un `ValueNotifier<bool>` que indica si el modo oscuro está habilitado (`true`) o no (`false`).
  final ValueNotifier<bool> isDarkMode;

  /// Una función callback que se llama cuando el usuario quiere cambiar entre modos de tema.
  final VoidCallback toggleTheme;

  /// Constructor de la clase `WebAppView`.
  ///
  ///  -`key`: La clave del widget.
  ///  -`url`: La URL de la app web que se mostrará.
  ///  -`isDarkMode`: Notificador si el modo oscuro esta activado.
  ///  -`toggleTheme`: Función que cambia entre los modos de tema.
  const WebAppView({super.key, required this.url, required this.isDarkMode, required this.toggleTheme});

 @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode, // Escucha cambios en el modo oscuro.
      builder: (context, darkModeValue, child) {
        return Scaffold(
          appBar: AppBar( // AppBar con el título y el botón de cambio de tema.
            title: Text(
              "360", // Título de la AppBar.
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkModeValue ? Colors.white : Colors.black, // Color del texto según el tema.
              ),
            ),
            backgroundColor: darkModeValue ? Colors.black : Colors.white, // Color de fondo de la AppBar según el tema.
            centerTitle: true, // Centra el título en la AppBar.
            actions: [ // Botón para cambiar el tema en la AppBar.
              IconButton(
                icon: Icon(
                  darkModeValue ? Icons.light_mode : Icons.dark_mode,  // Icono de sol/luna.
                  color: darkModeValue ? const Color(0xffd6a469) : Colors.black, // Color del icono según el tema.
                ),
                onPressed: toggleTheme, // Llama a la función para cambiar el tema.
              ),
            ],
          ),
          body: LayoutBuilder( // Usa LayoutBuilder para obtener las dimensiones disponibles.
            builder: (BuildContext context, BoxConstraints constraints) {
              // Crea el IframeWidget con el tamaño máximo disponible.
              return IframeWidget(
                url: url, // URL de la aplicación web.
                width: constraints.maxWidth, // Ancho máximo disponible.
                height: constraints.maxHeight, // Altura máxima disponible.
              );
            },
          ),
          backgroundColor: darkModeValue ? const Color(0xff15181e) : Colors.white, // Añade un color de fondo al Scaffold
        );
      },
    );
  }
}