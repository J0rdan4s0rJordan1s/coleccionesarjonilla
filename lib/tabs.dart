import 'package:flutter/material.dart';
import 'package:flutter_application_2/castillo.dart';
import 'package:flutter_application_2/colecciones.dart';
import 'package:flutter_application_2/iframe.dart';
import 'package:flutter_application_2/webview.dart';
import 'package:flutter_application_2/principal.dart';
import 'package:flutter_application_2/refugio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_2/mapa.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;
  final ValueNotifier<bool> _isDarkMode = ValueNotifier(
    false,
  ); // Estado del tema de la página

  // Imágenes iniciales
  String imgBunker = 'assets/images/bunker.svg';
  String imgCastillo = 'assets/images/castillo.svg';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // Cambiar las imágenes cuando se seleccionan
      imgBunker =
          (index == 3)
              ? 'assets/images/bunker-selec.svg'
              : 'assets/images/bunker.svg';
      imgCastillo =
          (index == 4)
              ? 'assets/images/castillo-selec.svg'
              : 'assets/images/castillo.svg';
    });
  }

  void _toggleTheme() {
    // Función para cambiar el tema
    setState(() {
      _isDarkMode.value = !_isDarkMode.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      // Escucha los cambios en _isDarkMode
      valueListenable: _isDarkMode,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return IndexedStack(
                  index: _selectedIndex,
                  children: [
                    Principal(
                      isDarkMode: _isDarkMode,
                      toggleTheme: _toggleTheme,
                    ),
                    Mapa(isDarkMode: _isDarkMode, toggleTheme: _toggleTheme),
                    Colecciones(
                      isDarkMode: _isDarkMode,
                      toggleTheme: _toggleTheme,
                    ),
                    Refugio(isDarkMode: _isDarkMode, toggleTheme: _toggleTheme),
                    Castillo(
                      isDarkMode: _isDarkMode,
                      toggleTheme: _toggleTheme,
                    ),
                    WebAppView(
                      url: 'https://360.amuraone.com/virtualtour/5f1f3688',
                      isDarkMode: _isDarkMode,
                      toggleTheme: _toggleTheme,
                    ), //Cambiar por WebViewPage para su visualización en aplicación móvil o viceversa
                  ],
                );
              },
            ),

            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: "Principal",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_rounded),
                  label: "Ubicaciones",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.image_rounded),
                  label: "Colecciones",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(imgBunker, width: 30, height: 30),
                  label: "Refugio",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(imgCastillo, width: 30, height: 30),
                  label: "Castillo",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.panorama_photosphere_rounded),
                  label: "360",
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color(0xffd6a469),
              unselectedItemColor: Colors.grey,
              backgroundColor: isDarkMode ? Colors.black : Colors.white,
              type:
                  BottomNavigationBarType
                      .fixed, // Evita que los iconos se oculten en 5+ elementos
              onTap: _onItemTapped,
            ),
          ),
        );
      },
    );
  }
}
