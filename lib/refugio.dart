import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Widget para la sección de Refugio.  Presenta una lista de audioguías
/// relacionadas con refugios, con funcionalidad de búsqueda y navegación a una
/// página de detalles.
class Refugio extends StatefulWidget {
  /// `ValueNotifier<bool>` que indica si el modo oscuro está activo (`true`) o no (`false`).
  final ValueNotifier<bool> isDarkMode;

  /// Función callback que se ejecuta cuando el usuario quiere cambiar el tema (claro/oscuro).
  final VoidCallback toggleTheme;

  /// Constructor de la clase `Refugio`.
  Refugio({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  _RefugioState createState() => _RefugioState();
}

class _RefugioState extends State<Refugio> {
  /// Controlador para el campo de texto de búsqueda.
  final TextEditingController _searchController = TextEditingController();

  /// Lista original de audioguías de refugios.  Cada elemento es un `Map`
  /// con claves como "title", "image", "audio", "descripcion".  Esta lista
  /// *no* se modifica directamente después de la inicialización.
  final List<Map<String, String>> refug = [
    {
      "title": "Introducción",
      "image": "assets/images/refugio/refugio-arjonilla-1.jpg",
      "audio": "audios/refugio/refugio-1.mp3",
      "descripcion":
          "Arjonilla cuenta con varios refugios antiaéreos construidos para el uso de la población de Arjonilla durante la Guerra Civil Española (1936-1939). Esta localidad cuenta con un total de 6 refugios (aunque uno de ellos se trataría de un polvorín, situado en la zona de la Viña Garabata) localizados en diferentes lugares de Arjonilla: Plaza de la Encarnación, Glorieta Ángel Hernández, Refugio “la Plaza” Calle Arjona, El Botillo y el citado de la Viña Garabata.\n\nHoy en día, y debido a su puesta en valor, dos de ellos son visitables, concretamente los situados en la Plaza de la Encarnación (abierto desde el año 2008) y el de la Glorieta Ángel Hernández (abierto desde Julio de 2022).Construidos entre los años 1937 y 1938, su funcionalidad no era otra que la de resguardar la población de la localidad de los bombardeos que Arjonilla recibe a lo largo de esta contienda bélica, aunque pocos, sí que es cierto que tuvieron lugar en la misma.\n\nEste refugio, situado en la Glorieta Ángel Hernández, con dos entradas y salidas, una situada junto al Palacio del Marqués de la Merced (hoy en día sede de las Refugio Museísticas) y la otra, al final de la Glorieta.\n\nTiene cerca de 70 metros, con varias curvaturas y su peculiaridad es que toda su bóveda está hecha de ladrillo (a diferencia del de la Plaza de la Encarnación) y un pozo de las casas colindantes el refugio.",
    },
    {
      "title": "Jaén durante la Guerra Civil",
      "image": "assets/images/refugio/refugio-arjonilla-2.jpg",
      "audio": "audios/refugio/refugio-2.mp3",
      "descripcion":
          "El estallido de la guerra civil española se inició tras el fracaso del golpe de estado de una parte del ejército —apoyado por grupos políticos y civiles conservadores— que estaba en contra del gobierno de la república por la situación de crisis económica y la tensión política y social.\n\nTras los primeros momentos de la rebelión, la provincia de Jaén, junto con Almería y otras partes de Málaga y Granada, no apoyo la causa, sobre todo gracias a la importante afiliación campesina con que contaban las sociedades de agricultores de la FTT-UGT.\n\nJaén se mantuvo fiel a la República hasta finales de la contienda, concretamente a partir del 29 de marzo de 1939, las localidades jiennenses comenzaron a caer.\n\nEL GUERNICA ANDALUZ\nEl día 1 de abril de 1937, el general Gonzalo Queipo de Llano, militar al servicio de los sublevados, da la orden de bombardear la ciudad de Jaén con seis aviones trimotores acompañados por un grupo de escolta de nueve cazas. Murieron 159 personas. Este bombardeo se realiza como represalia del ataque aéreo de la aviación republicana de ese mismo día, a un barrio obrero y un hospital militar, en la ciudad de Córdoba que se saldó con unos 40 muertos.",
    },
    {
      "title": "Arjonilla. Línea del Frente",
      "image": "assets/images/refugio/refugio-arjonilla-3.jpg",
      "audio": "audios/refugio/refugio-3.mp3",
      "descripcion":
          "Aquí no vivimos el ambiente bélico hasta diciembre de 1936, cuando los pueblos de Lopera y Porcuna caen en manos sublevadas y localidades como Arjonilla, Marmolejo o Arjona se sitúan en primera línea del frente.  A partir de entonces, esta zona sufre numerosos bombardeos por parte de la aviación insurrecta y por ello los dirigentes republicanos de la provincia ordenan construir refugios antiaéreos para salvaguardar a la población.\n\nEn los primeros meses de la guerra en Arjonilla, fue el Comité Local del Frente Popular quien se hizo con el control de la localidad. Entre sus funciones estaba seguir con la “normalidad”, se encarga de celebrar sesiones ordinarias sobre asuntos burocráticos, como la aprobación de presupuestos municipales o la recaudación de impuestos.\n\nEn 1937, Arjonilla empezó a asumir funciones militares estableciendo un Tribunal Militar y varios cuarteles. Uno de ellos, de gran tamaño, se instaló en la actual Glorieta de Ángel Hernández; otro, en el interior de la Iglesia de la Encarnación y otro a las afueras de la localidad, donde se localiza la Casería de la “Viña Garabata”. Junto a los mismos, se construyeron también refugios antiaéreos.",
    },
    {
      "title": "Bombardeos sobre Arjonilla",
      "image": "assets/images/refugio/refugio-arjonilla-4.jpg",
      "audio": "audios/refugio/refugio-4.mp3",
      "descripcion":
          "Nuestro municipio sufrió, al menos, seis bombardeos durante la guerra civil por parte del bando nacionalista.\n\nLas tropas de porcuna, con su cañon al que llamaban “el abuelo"
          ", tenían como referencia el chapitel de la iglesía de la encarnación, por lo que se decide desmontarlo. Tras la guerra, el chapitel volvería a ser colocado.\n\nA causa de los bombardeos la población civil fue evacuada casi en su mayoría, refugiándose en Espelúy o Torredonjimeno, entre otros pueblos.\n\nEl primero de ellos se produjo el 5 de febrero de 1937, por baterías instaladas en el pueblo de Porcuna situado a 15 kilómetros de aquí. Por suerte no hubo ninguna baja. Los siguientes tuvieron lugar una vez terminado el asedio de la Virgen de la Cabeza, el 27 de mayo, 5 de junio, 17 de junio y 23 de junio de 1937.\n\nEl último, a las 12:50 del 31 de octubre de 1938, fue el más grave de todos. El ataque se produjo por partida doble, tanto por las baterías de Porcuna, como por la aviación nazi enviadas por Hitler. Se trataban de aviones modelo Junkers, uno de los aviones más utilizados por la Legión Condor. La bomba caída en la calle Hornos causó la muerte a 8 personas (siete de ellas mujeres) y numerosos daños materiales.",
    },
    {
      "title": "Construcción de los Refugios",
      "image": "assets/images/refugio/refugio-arjonilla-5.jpg",
      "audio": "audios/refugio/refugio-5.mp3",
      "descripcion":
          "En el caso de Arjonilla, la construcción de los refugios fue complicada por los insuficientes medios económicos del ayuntamiento. Este, junto al comité local del frente popular, tomaron una serie de medidas para sufragar los gastos como crear bonos pro-refugios, obligar a los que tenían ladrillos a entregarlos, la recaudación de un porcentaje de las ventas de productos (a excepción del pan) o pedir a la cía. Eléctrica mengemor que contribuyera con alguna cantidad.\n\nCuando se vela la aproximación de la aviación se avisaba a la población con el toque del esquilón, la campana de menor tamaño, desde el campanario de la Iglesia de la Encarnación.\n\nLA DEFENSA PASIVA\nEl gobierno republicano de Madrid, ordena la organización de la defensa pasiva. En el mes de septiembre de 1937 quede constituida la Junta Provincial de Defensa Especial Contra Aeronaves (D.E.C.A), dependiente del Ministerio de Marina y Aire, que tuvo comités provinciales y locales en toda la España republicana. En la provincia de Jaén se constituyeron comités locales de la DECA en 67 localidades.",
    },
    {
      "title": "Para nunca más",
      "image": "assets/images/refugio/refugio-arjonilla-6.jpg",
      "audio": "audios/refugio/refugio-6.mp3",
      "descripcion":
          "Las nuevas autoridades del franquismo prestarán gran atención a los refugios construidos durante la guerra civil. En un primer momento, en el que todavía estaba abierta la posibilidad de la participación de España en la II guerra mundial. Después cayeron en el olvido de la memoria pensando que nunca más volverían a utilizarse.\nHoy en día, no.\n\nRECUPERACIÓN DE LOS VESTIGIOS BÉLICOS DE LA GUERRA CIVIL\nEl refugio de la Encarnación, una de los refugios públicos que se construyó junto la Iglesia, fue descubierto en 1988 durante las obras de remodelación de la plaza. En 2009 fue el primer refugio de la provincia en ponerse en valor y musealizarse y el segundo de Andalucía, después de el de Almería.\n\nHOSPITALES EN LOS REFUGIOS ANTIAÉREOS\n14.13.2022, Kateryna Safrpnova, una estudiante de medicina, prepara camas en un hospital improvisado dentro de un refugio antiaéreo en la región de Kiev, mientras continúa el ataque de Rusia contra Ucrania. ",
    },
  ];

  /// Lista filtrada de audioguías de refugios.  Esta lista se actualiza
  /// según la consulta de búsqueda.
  List<Map<String, String>> filtrrefug = [];

  @override
  void initState() {
    super.initState();
    filtrrefug = refug; // Inicialmente, muestra todas las audioguías.
    _searchController.addListener(
      _filterList,
    ); // Escucha los cambios en el campo de búsqueda.
  }

  /// Filtra la lista de audioguías basándose en el texto ingresado en el
  /// campo de búsqueda.
  void _filterList() {
    final query =
        _searchController.text
            .toLowerCase(); // Obtiene la consulta y la convierte a minúsculas.
    if (query.isEmpty) {
      setState(() {
        filtrrefug = List.from(
          refug,
        ); // Si la consulta está vacía, restaura la lista completa.
      });
    } else {
      setState(() {
        filtrrefug =
            refug.where((item) {
              // Filtra la lista original `refug`.
              final title =
                  item["title"]?.toLowerCase() ??
                  ""; // Obtiene el título, lo convierte a minúsculas o usa "" si es null.
              return title.contains(
                query,
              ); // Comprueba si el título contiene la consulta.
            }).toList(); // Convierte el resultado del filtro a una lista.
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose(); // Libera el controlador del campo de búsqueda.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      // Escucha cambios en el `ValueNotifier` isDarkMode.
      valueListenable: widget.isDarkMode,
      builder: (context, darkModeValue, child) {
        return Scaffold(
          appBar: AppBar(
            leading:
                Container(), // Contenedor vacío para eliminar la flecha de retroceso por defecto.
            centerTitle: true, // Centra el título en la AppBar.
            title: Text(
              'AUDIOGUÍAS REFUGIO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    darkModeValue
                        ? Colors.white
                        : Colors.black, // Color del título según el tema.
              ),
            ),
            backgroundColor:
                darkModeValue
                    ? Colors.black
                    : Colors
                        .white, // Color de fondo de la AppBar según el tema.
            actions: [
              IconButton(
                icon: Icon(
                  darkModeValue
                      ? Icons.light_mode
                      : Icons.dark_mode, // Icono de sol/luna según el tema.
                  color:
                      darkModeValue
                          ? const Color(0xffd6a469)
                          : Colors.black, // Color del icono según el tema.
                ),
                onPressed:
                    widget
                        .toggleTheme, // Llama a la función para cambiar el tema.
              ),
            ],
          ),
          body: SingleChildScrollView(
            // Permite scroll si el contenido es mayor que la altura de la pantalla.
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller:
                        _searchController, // Controlador del campo de búsqueda.
                    decoration: InputDecoration(
                      hintText: "Buscar", // Texto de sugerencia.
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ), // Icono de búsqueda.
                      filled: true, // Rellena el fondo del campo de texto.
                      fillColor:
                          darkModeValue
                              ? Colors.grey[800]
                              : Colors
                                  .grey[200], // Color de fondo según el tema.
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Bordes redondeados.
                        borderSide: BorderSide.none, // Sin borde visible.
                      ),
                    ),
                    style: TextStyle(
                      color: darkModeValue ? Colors.white : Colors.black,
                    ), // Color del texto de entrada según el tema.
                  ),
                ),
                // Lista de audioguías.
                ListView.builder(
                  shrinkWrap:
                      true, // Ajusta la altura de la lista a su contenido.
                  physics:
                      const NeverScrollableScrollPhysics(), // Deshabilita el scroll de la lista (el scroll se maneja con el SingleChildScrollView).
                  itemCount:
                      filtrrefug
                          .length, // Número de elementos en la lista filtrada.
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      // Detecta toques en cada elemento de la lista.
                      onTap: () {
                        // Navega a la página de detalles al tocar un elemento.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DetailPage(
                                  // Crea la página de detalles.
                                  isDarkMode:
                                      widget
                                          .isDarkMode, // Pasa el estado del modo oscuro.
                                  toggleTheme:
                                      widget
                                          .toggleTheme, // Pasa la función para cambiar el tema.
                                  title:
                                      filtrrefug[index]["title"]!, // Pasa el título.  El '!' asegura que no es null.
                                  imagePath:
                                      filtrrefug[index]["image"]!, // Pasa la ruta de la imagen.
                                  audioPath:
                                      filtrrefug[index]["audio"]!, // Pasa la ruta del audio.
                                  descripcion:
                                      filtrrefug[index]["descripcion"]!, // Pasa la descripción.
                                ),
                          ),
                        );
                      },
                      child: GuideCard(
                        // Muestra la tarjeta de la audioguía.
                        title: filtrrefug[index]["title"]!,
                        imagePath: filtrrefug[index]["image"]!,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          backgroundColor:
              darkModeValue
                  ? const Color(0xff15181e)
                  : Colors.white, // Color de fondo del Scaffold según el tema.
        );
      },
    );
  }
}

/// Un widget reutilizable para mostrar una tarjeta de audioguía.  La tarjeta
/// muestra una imagen de fondo y un título superpuesto con un efecto de
/// semitransparencia.
class GuideCard extends StatelessWidget {
  /// El título que se mostrará en la tarjeta.
  final String title;

  /// La ruta del archivo de imagen que se usará como fondo de la tarjeta.
  final String imagePath;

  /// Constructor de la clase `GuideCard`.
  ///
  /// `key`:  La clave del widget (opcional).
  /// `title`: El título de la audioguía (obligatorio).
  /// `imagePath`: La ruta de la imagen de la audioguía (obligatorio).
  const GuideCard({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ), // Espaciado alrededor de la tarjeta.
      child: ClipRRect(
        // Aplica bordes redondeados a la tarjeta.
        borderRadius: BorderRadius.circular(
          10,
        ), // Radio de los bordes redondeados.
        child: Stack(
          // Apila los widgets (imagen y texto) uno encima del otro.
          alignment: Alignment.center, // Alinea los hijos al centro del Stack.
          children: [
            Image.asset(
              // Muestra la imagen de fondo.
              imagePath,
              width: double.infinity, // Ocupa todo el ancho disponible.
              height: 300, // Altura fija de la tarjeta.
              fit:
                  BoxFit
                      .cover, // La imagen cubre todo el espacio, manteniendo su relación de aspecto.
            ),
            Container(
              // Contenedor para el efecto de superposición oscura.
              width: double.infinity, // Ocupa todo el ancho disponible.
              height: 300, // Altura fija (igual que la imagen).
              color: const Color.fromRGBO(
                0,
                0,
                0,
                0.5,
              ), // Color negro semitransparente.
              alignment: Alignment.center, // Alinea el texto al centro.
              child: Text(
                // Muestra el título de la audioguía.
                title,
                style: const TextStyle(
                  // Estilo del texto.
                  color: Colors.white, // Texto blanco.
                  fontSize: 18, // Tamaño de fuente.
                  fontWeight: FontWeight.bold, // Negrita.
                ),
                textAlign: TextAlign.center, // Centra el texto horizontalmente.
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget para la página de detalles de una audioguía.  Muestra información
/// como el título, imagen, un reproductor de audio, una descripción y,
/// condicionalmente, un mapa.
class DetailPage extends StatefulWidget {
  /// `ValueNotifier<bool>` que indica si el modo oscuro está activado (`true`) o no (`false`).
  final ValueNotifier<bool> isDarkMode;

  /// Función callback que se ejecuta cuando el usuario quiere cambiar el tema (claro/oscuro).
  final VoidCallback toggleTheme;

  /// El título de la audioguía.
  final String title;

  /// La ruta de la imagen asociada a la audioguía.
  final String imagePath;

  /// La ruta del archivo de audio de la audioguía.
  final String audioPath;

  /// La descripción textual de la audioguía.
  final String descripcion;

  /// Constructor de la clase `DetailPage`.
  const DetailPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
    required this.title,
    required this.imagePath,
    required this.audioPath,
    required this.descripcion,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  /// Instancia del reproductor de audio.  `late` indica que se inicializará más tarde.
  late AudioPlayer _audioPlayer;

  /// Duración total del audio.  Inicializado en cero.
  Duration _duration = Duration.zero;

  /// Posición actual de reproducción dentro del audio. Inicializado en cero.
  Duration _position = Duration.zero;

  /// Indica si el audio está actualmente reproduciéndose (`true`) o no (`false`).
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Listener para la duración del audio.  Se actualiza cuando la duración cambia (p. ej., al cargar el audio).
    _audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    // Listener para la posición actual del audio. Se actualiza frecuentemente mientras el audio se reproduce.
    _audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    // Listener para el evento de finalización de la reproducción.
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false; // Pausa la reproducción.
        _position = Duration.zero; // Reinicia la posición.
      });
    });
  }

  /// Método para controlar la reproducción del audio (play/pausa).
  void _playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause(); // Pausa si está reproduciendo.
    } else {
      await _audioPlayer.play(
        AssetSource(widget.audioPath),
      ); // Reproduce si está pausado.  Usa `AssetSource` para archivos locales.
    }
    setState(() {
      isPlaying = !isPlaying; // Invierte el estado de reproducción.
    });
  }

  /// Método para cambiar la posición del audio cuando el usuario interactúa con el `Slider`.
  void _seekAudio(double value) async {
    await _audioPlayer.seek(
      Duration(seconds: value.toInt()),
    ); // Cambia la posición del audio.
  }

  @override
  void dispose() async {
    try {
      // Verifica si el reproductor sigue en uso antes de pararlo.
      if (isPlaying) {
        await _audioPlayer.stop(); // Detiene el audio.
      }

      // Cancela todos los listeners antes de liberar el reproductor.
      await _audioPlayer.dispose(); // Libera los recursos de audio.
    } catch (e) {
      print("Error en dispose: $e"); // Muestra cualquier error en la consola.
    }

    super.dispose(); // Llama al método base.
  }

  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder reacciona a cambios en `widget.isDarkMode`.
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isDarkMode,
      builder: (context, darkModeValue, child) {
        return Scaffold(
          backgroundColor:
              darkModeValue
                  ? Colors.black
                  : Colors.white, // Fondo del Scaffold según el tema.
          body: SafeArea(
            // SafeArea evita que el contenido se solape con la barra de estado, etc.
            child: SingleChildScrollView(
              // SingleChildScrollView permite scroll si el contenido es mayor que la pantalla.
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start, // Alinea los hijos a la izquierda.
                children: [
                  // Contenedor superior para el título, botón de retroceso y botón de tema.
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    color:
                        darkModeValue
                            ? const Color(0xff15181e)
                            : Colors
                                .white, // Color del contenedor según el tema.
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color:
                                darkModeValue
                                    ? const Color(0xffd6a469)
                                    : Colors.black,
                          ), // Color del icono según tema.
                          onPressed: () {
                            _audioPlayer
                                .stop(); // Detiene el audio al retroceder.
                            _audioPlayer
                                .dispose(); // Libera los recursos del reproductor.
                            Navigator.pop(
                              context,
                            ); // Vuelve a la pantalla anterior.
                          },
                        ),
                        Expanded(
                          // Expanded hace que el título ocupe el espacio restante.
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color:
                                  darkModeValue
                                      ? Colors.white
                                      : Colors
                                          .black, // Color del texto según el tema.
                            ),
                            textAlign: TextAlign.center, // Centra el título.
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            darkModeValue
                                ? Icons.light_mode
                                : Icons.dark_mode, // Icono de sol/luna.
                            color:
                                darkModeValue
                                    ? const Color(0xffd6a469)
                                    : Colors.black, // Color del icono.
                          ),
                          onPressed:
                              widget
                                  .toggleTheme, // Llama a la función para cambiar el tema.
                        ),
                      ],
                    ),
                  ),
                  // Imagen principal de la audioguía.
                  Image.asset(
                    widget.imagePath,
                    width: double.infinity,
                    height: 300,
                    fit:
                        BoxFit
                            .cover, // Ajusta la imagen para cubrir el espacio.
                  ),
                  // Contenedor para el reproductor de audio y la descripción.
                  Container(
                    color:
                        darkModeValue
                            ? const Color(0xff15181e)
                            : Colors
                                .white, // Color del contenedor según el tema.
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        // Personalización del Slider para el control de reproducción.
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 3, // Altura de la barra de progreso.
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 6,
                            ), // Forma circular del control.
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: 10,
                            ), // Forma del efecto al presionar.
                          ),
                          child: Slider(
                            activeColor:
                                darkModeValue
                                    ? Color(0xffd6a469)
                                    : Colors.black, // Color de la parte activa.
                            inactiveColor:
                                Colors.grey, // Color de la parte inactiva.
                            min: 0, // Valor mínimo (inicio del audio).
                            max:
                                _duration.inSeconds
                                    .toDouble(), // Valor máximo (duración del audio).
                            value:
                                _position.inSeconds
                                    .toDouble(), // Valor actual (posición de reproducción).
                            onChanged:
                                _seekAudio, // Llama a la función `_seekAudio` cuando el usuario mueve el slider.
                          ),
                        ),
                        // Fila para mostrar el tiempo transcurrido y la duración total.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_position.inMinutes.toString().padLeft(2, '0')}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}",
                              style: TextStyle(
                                color:
                                    darkModeValue ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              "${_duration.inMinutes.toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}",
                              style: TextStyle(
                                color:
                                    darkModeValue ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        // Botón de reproducción/pausa.
                        IconButton(
                          icon: Icon(
                            isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            color: darkModeValue ? Colors.white : Colors.black,
                            size: 50,
                          ),
                          onPressed:
                              _playPause, // Llama a la función `_playPause`.
                        ),
                      ],
                    ),
                  ),
                  // Contenedor para la descripción de la audioguía.
                  Container(
                    color:
                        darkModeValue
                            ? const Color(0xff15181e)
                            : Colors
                                .white, // Color del contenedor según el tema.
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.descripcion,
                      style: TextStyle(
                        fontSize: 16,
                        color: darkModeValue ? Colors.white : Colors.black,
                      ), // Color del texto según tema.
                    ),
                  ),
                  // Sección del mapa (se muestra solo si el título es "Introducción").
                  if (widget.title == "Introducción")
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        // Bordes redondeados para el mapa.
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  darkModeValue ? Colors.white30 : Colors.black,
                            ), // Borde del mapa.
                          ),
                          child: FlutterMap(
                            // Widget FlutterMap para mostrar el mapa.
                            options: MapOptions(
                              // Opciones del mapa.
                              initialCenter: const LatLng(
                                37.974380427287976,
                                -4.107927743368452,
                              ), // Coordenadas iniciales.
                              initialZoom: 17.0, // Nivel de zoom inicial.
                            ),
                            children: [
                              TileLayer(
                                // Capa de teselas (el mapa base).
                                urlTemplate:
                                    "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png", // URL de las teselas.
                              ),
                              MarkerLayer(
                                // Capa de marcadores.
                                markers: [
                                  Marker(
                                    // Marcador único.
                                    point: const LatLng(
                                      37.974380427287976,
                                      -4.107927743368452,
                                    ), // Coordenadas del marcador.
                                    width: 30,
                                    height: 30,
                                    child: const Icon(
                                      Icons.location_on, // Icono de ubicación.
                                      color: Colors.red, // Color del icono.
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
