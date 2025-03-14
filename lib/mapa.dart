import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class Mapa extends StatefulWidget {
  final ValueNotifier<bool> isDarkMode;
  final VoidCallback toggleTheme;

  Mapa({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  final MapController _mapController = MapController();
  Map<String, dynamic>? _selectedLocation;
  double _rotation = 0.0;

  final List<Map<String, dynamic>> locations = [
    {
      "nombre": "Refugio Antiaéreo",
      "coordenadas": LatLng(37.973649366478675, -4.104493675145468),
      "imagen": "assets/images/refugio/refugio-localizaciones.png",
      "enlace": "https://teliportme.com/virtualtour/5f1f3688/2098835",
    },
    {
      "nombre": "Colecciones Museísticas",
      "coordenadas": LatLng(37.973689539326095, -4.104594258075407),
      "imagen": "assets/images/colecciones/colecciones-localizaciones.png",
      "enlace": "https://teliportme.com/virtualtour/5f1f3688/2098837",
    },
    {
      "nombre": "Castillo del trovador Macías",
      "coordenadas": LatLng(37.974078353314155, -4.104806545160636),
      "imagen": "assets/images/castillo/castillo-localizaciones.png",
      "enlace": "https://teliportme.com/virtualtour/5f1f3688/2099105",
    },
  ];

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("El servicio de ubicación está desactivado.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Permisos de ubicación denegados.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Los permisos de ubicación están denegados permanentemente.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    _mapController.move(LatLng(position.latitude, position.longitude), 17.0);
  }

  void _volverAlCentro() {
    _mapController.move(LatLng(37.97391, -4.10463), 20.0);
  }

  void _openMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => MenuPage(
              locations: locations,
              isDarkMode: widget.isDarkMode,
              toggleTheme: widget.toggleTheme,
            ), // Pasa isDarkMode
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      // Escucha el ValueNotifier
      valueListenable: widget.isDarkMode,
      builder: (context, darkModeValue, child) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "UBICACIONES",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          darkModeValue
                              ? Colors.white
                              : Colors.black, // Usa darkModeValue
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            backgroundColor:
                darkModeValue
                    ? Colors.black
                    : Colors.white, // Usa darkModeValue
            actions: [
              IconButton(
                icon: Icon(
                  darkModeValue
                      ? Icons.light_mode
                      : Icons.dark_mode, // Usa darkModeValue
                  color:
                      darkModeValue
                          ? const Color(0xffd6a469)
                          : Colors.black, // Usa darkModeValue
                ),
                onPressed: widget.toggleTheme,
              ),
            ],
          ),
          body: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateLocal) {
              return Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(37.97391, -4.10463),
                      initialZoom: 20.0,
                      onMapReady: () {
                        _rotation = _mapController.camera.rotation;
                      },
                      onMapEvent: (MapEvent event) {
                        // Usa MapEventMove
                        if (event is MapEventMove) {
                          setStateLocal(() {
                            _rotation = event.camera.rotation;
                          });
                        }
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            darkModeValue
                                ? "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png"
                                : "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
                        retinaMode: true,
                      ),
                      MarkerLayer(
                        markers:
                            locations.map((location) {
                              return Marker(
                                point: location["coordenadas"],
                                width: 30,
                                height: 30,
                                child: GestureDetector(
                                  onTap: () {
                                    setStateLocal(() {
                                      _selectedLocation = location;
                                    });
                                  },
                                  child: Transform.rotate(
                                    angle: -_rotation * (pi / 180),
                                    child: Icon(
                                      Icons.location_pin,
                                      color: const Color(0xffd6a469),
                                      size: 30,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                  if (_selectedLocation != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          final String url = _selectedLocation!["enlace"];
                          final Uri uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            throw 'No se pudo abrir $url';
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color:
                              darkModeValue
                                  ? const Color(0xff15181e)
                                  : Colors.white,
                          child: Row(
                            children: [
                              Image.asset(
                                _selectedLocation!["imagen"],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _selectedLocation!["nombre"],
                                  style: TextStyle(
                                    color:
                                        darkModeValue
                                            ? Colors.white
                                            : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 155,
                    right: 20,
                    child: FloatingActionButton(
                      heroTag: "location_button",
                      onPressed: _getCurrentLocation,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.near_me_rounded,
                        color: Color(0xffd6a469),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 85,
                    left: 20,
                    child: FloatingActionButton(
                      heroTag: "volver_centro",
                      onPressed: _volverAlCentro,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.my_location, color: Color(0xffd6a469)),
                    ),
                  ),
                  Positioned(
                    bottom: 85,
                    right: 20,
                    child: FloatingActionButton(
                      heroTag: "menu_button",
                      onPressed: () => _openMenu(context),
                      backgroundColor: Color(0xffd6a469), // Usa darkModeValue
                      child: Icon(Icons.menu, color: Colors.black),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class MenuPage extends StatelessWidget {
  final List<Map<String, dynamic>> locations;
  final ValueNotifier<bool> isDarkMode; // Recibe el ValueListenable
  final VoidCallback toggleTheme;

  const MenuPage({
    super.key,
    required this.locations,
    required this.isDarkMode,
    required this.toggleTheme,
  }); // Constructor

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      // Escucha los cambios
      valueListenable: isDarkMode,
      builder: (context, darkModeValue, child) {
        return Scaffold(
          backgroundColor:
              darkModeValue ? const Color(0xff15181e) : Colors.white,
          appBar: AppBar(
            title: Text(
              "Ubicaciones",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkModeValue ? Colors.white : Colors.black,
              ),
            ),
            backgroundColor: darkModeValue ? Colors.black : Colors.white,
            centerTitle: true,
            leading: Container(),
            iconTheme: IconThemeData(
              color: darkModeValue ? Color(0xffd6a469) : Colors.black,
            ),
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
          body: ListView.separated(
            itemCount: locations.length,
            separatorBuilder:
                (context, index) => Divider(
                  color: darkModeValue ? Colors.white54 : Colors.black54,
                ),
            itemBuilder: (context, index) {
              final location = locations[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  title: Text(
                    location["nombre"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: darkModeValue ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: Image.asset(
                    location["imagen"],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  onTap: () async {
                    final Uri uri = Uri.parse(location["enlace"]);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pop(context),
            backgroundColor: Color(0xffd6a469), // Apply dark mode
            child: const Icon(Icons.map_outlined, color: Colors.black),
          ),
        );
      },
    );
  }
}
