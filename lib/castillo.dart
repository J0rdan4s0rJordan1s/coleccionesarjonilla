import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Widget para la sección de audioguías del Castillo.  Muestra una lista de
/// audioguías relacionadas con el castillo, con funcionalidad de búsqueda y
/// navegación a una página de detalles.
class Castillo extends StatefulWidget {
  /// `ValueNotifier<bool>` que indica si el modo oscuro está activado (`true`) o no (`false`).
  final ValueNotifier<bool> isDarkMode;

  /// Función callback que se ejecuta cuando el usuario quiere cambiar el tema (claro/oscuro).
  final VoidCallback toggleTheme;

  /// Constructor de la clase `Castillo`.
  Castillo({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  _CastilloState createState() => _CastilloState();
}

class _CastilloState extends State<Castillo> {
  /// Controlador para el campo de texto de búsqueda.
  final TextEditingController _searchController = TextEditingController();

  /// Lista original de audioguías del castillo. Cada elemento es un `Map` con
  /// claves como "title", "image", "audio", "descripcion".  Esta lista *no* se
  /// modifica directamente después de la inicialización.
  final List<Map<String, String>> castillo = [
    {
      "title": "Introducción",
      "image": "assets/images/castillo/castillo-arjonilla-1.png",
      "audio": "audios/castillo/castillo-1.mp3",
      "descripcion":
          "El Castillo de Arjonilla (Jaén) supone una de las fortalezas medievales mejor conservadas de la Campiña Occidental del Alto Guadalquivir desde el punto de vista de sus estructuras defensivas.\n\nDeclarado bien de interés cultural por la Ley de Patrimonio Histórico de 1985, se localiza en una zona sucesivamente ocupada, por el que el lugar se constituye en la zona urbanística dé mayor significado Histórico para la Villa, convirtiéndose junto con el Palacio del Marqués de la Merced (sede de las Colecciones Museísticas) y la Iglesia de Nuestra Señora de la Encarnación, en uno de los principales enclaves turísticos y patrimoniales de nuestra localidad.",
    },
    {
      "title": "Época",
      "image": "assets/images/castillo/castillo-arjonilla-2.JPG",
      "audio": "audios/castillo/castillo-2.mp3",
      "descripcion":
          "Todo el recinto se adscribe a la Orden de Calatrava en el reinado de Juan II (Primera mitad del Siglo XV),cuando ésta asume el control de buena parte de La Campiña Occidental del Alto Guadalquivir y reciben el mandato del rey de morar y reconstruir el castillo de Arjonilla, tomando como base la existencia de un recinto anterior, musulmán, construido en tapial, en sus inicios primigenios y posterior reconstrucción de una torre cuadrangular y la aparición de otro espacio en su interior, la torre del homenaje.",
    },
    {
      "title": "Mención Histórica",
      "image": "assets/images/castillo/castillo-arjonilla-3.jpg",
      "audio": "audios/castillo/castillo-3.mp3",
      "descripcion":
          "El escritor e historiador Juan Eslava Galán, sobre el castillo de Arjonilla, habla de un recinto amurallado con una torre deforma cuadrada o levemente regular, torres cilíndricas en las esquinas, torre de homenaje, ubicación en el Oeste del Reino de Jaén, a lo largo de las vías de comunicación fronteriza.\n\nCaracterísticas compartidas con otros castillos de la Campiña y próximos a Arjonilla (Bretaña, Fuerte del Rey, Marmolejo...), aunque el arqueólogo Francisco Nocete Calvo señala que no queda comprobado documentalmente la existencia de dicha fortaleza anterior, dado que no hay referencia histórica alguna a la misma.\n\nLa situación del recinto no justifica la necesidad defensiva desde el punto de vista estratégico. El control de las cercanas canteras de arcilla pudo ser uno de los principales cometidos.",
    },
    {
      "title": "Castillo hoy en dia",
      "image": "assets/images/castillo/castillo-arjonilla-4.JPG",
      "audio": "audios/castillo/castillo-4.mp3",
      "descripcion":
          "Teniendo una ubicación dentro del propio casco urbano de la localidad, hoy en día conservamos del recinto todos los muros exteriores ,a excepción del muro sur (colindante con el Palacio del Marqués de la Merced, sede hoy del Museo Municipal de Arjonilla), una torre cuadrangular por donde se accede al patio de armas y en el mismo, los lienzos y vestigios de muros de las distintas estancias y espacios que hubiera habido antaño en el interior del mismo (espacio de descanso para los caballeros calatravos, torre del homenaje, ermita de santa catalina y una necrópolis). Asimismo también se mantiene en el muro norte una de las torres menores del castillo de forma redondeada.\n\nEl uso actual del castillo, tras tener otros usos públicos como colegio, campo de futbol, plaza de toros ) es un recurso turístico y cultural (abierto al público para su visita y con servicio de guía), usado también para realización de eventos culturales y el desarrollo de las Jornadas Medievales del Trovador Macías, el último fin de Septiembre, dentro del programa de dinamización de la Ruta de los Castillos y Batallas, donde se incluye el castillo.",
    },
    {
      "title": "Torre cuadrangular",
      "image": "assets/images/castillo/castillo-arjonilla-5.jpg",
      "audio": "audios/castillo/castillo-5.mp3",
      "descripcion":
          "La primera construcción del recinto fue una primitiva torre cuadrangular, que reestructurada en las siguientes fases, configurará la torre que hoy podemos ver. Modelo de torre de la que existen numerosos prototipos dispersos en las tierras de la Campiña Occidental del Alto Guadalquivir.\n\nSus características básicas y más peculiares es que se trata de una torre cuadrangular de 17 metros de altura, y de 5,30 metros por 6.20 metros de base. Una torre de tres plantas, almenado y saeteras superiores, alzados abovedados y el tramo de escalera interior del segundo piso, debiendo formar parte de la torre primigenia. \n\nEsta torre ha sido confundida durante mucho tiempo con la Torre del Homenaje, si bien se trata de una edificación que sirvió de torre de acceso o entrada una vez que el recinto fue amurallado .Es esta la torre donde, según la leyenda, Macías estuvo preso y finalmente muerto a manos del marido despechado de Doña Elvira, Hernán Pérez de Vadillo, señor de Porcuna.",
    },
    {
      "title": "Torre del Homenaje",
      "image": "assets/images/castillo/castillo-arjonilla-6.jpg",
      "audio": "audios/castillo/castillo-6.mp3",
      "descripcion":
          "La segunda estructura construida en el recinto presenta una planta cuadrangular con adosamientos y refuerzos posteriores en su lateral. Poco conocemos de su funcionalidad, ya que fue arrasada y desmantelada por las remodelaciones posteriores. Se trataría de la Torre del Homenaje del Castillo.\n\nSu nombre se debía a que en ella se practicaba la ceremonia del homenaje, en la cual el señor le entregaba al vasallo un feudo a cambio de auxilium et consilium. \n\nDe este espacio medieval hoy en día sólo se conservan los cimientos de unos 12 metros de cada lado, más adosamiento laterales de 2 metros, constituidos en una plataforma maciza y rellena de piedras.",
    },
    {
      "title": "Recino Amurallado y Ermita de Santa Catalina",
      "image": "assets/images/castillo/castillo-arjonilla-7.jpg",
      "audio": "audios/castillo/castillo-7.mp3",
      "descripcion":
          "Con posterioridad se construye el recinto amurallado que mantenemos hoy en día, que le confiere la forma de Castillo y que conocieron los historiadores de los siglos XVII y XVIII. Esta nueva estructura viene a suponer una ampliación de los sistemas defensivos, dotando a este espacio carácter defensivo que inició la torre primigenia. Con el cierre del recinto, el acceso se construyó abriendo una puerta en codo en la antigua torre con un arco apuntado de ladrillo. Dentro de esta tercera fase constructiva, podemos apreciar también la pérdida del carácter defensivo, y el lugar es usado a partir de este momento como necrópolis.\n\nAunque se mantenga inalterada la estructura constructiva del castillo de Arjonilla y la construcción de dos edificios rectangulares dentro del recinto amurallado. Posee un cementerio situado junto a la ermita de Santa Catalina, una pequeña capilla en la que se hace mención en un documento del Sínodo de 1551. Una ermita, que según su leyenda, es donde fue enterrado Macías, tras su muerte, con gran pompa fúnebre y a la que acudieron la alta nobleza de la zona.",
    },
    {
      "title": "Recinto Completo",
      "image": "assets/images/castillo/castillo-arjonilla-8.jpg",
      "audio": "audios/castillo/castillo-8.mp3",
      "descripcion":
          "Las nuevas estructuras construidas revelan el abandono del recinto como sistema defensivo. La gran magnitud de sus estructuras construidas incide en que éste se convierta en un nuevo espacio público. Se disponen una serie de habitaciones.\n\nDe acuerdo con los vestigios encontrados en el suelo del patio de armas del castillo, seguramente también de esta época sería un espacio al aire libre, a modo de patio, como perfila su total empedrado por guijarros de rio. Patio a través del cual se accedería a las distintas estancias del castillo. Posiblemente éstas fueron las modificaciones realizadas en el siglo 16, cuando el Castillo sirve de morada para los caballeros de la Orden de Calatrava, transeúntes y los visitadores generales, en sus visitas al Concejo de la Villa.",
    },
    {
      "title": "Castillo y Palacio",
      "image": "assets/images/castillo/castillo-arjonilla-9.jpg",
      "audio": "audios/castillo/castillo-9.mp3",
      "descripcion":
          "La demolición del Muro Sur permitirá el acceso directo a la casa solariega del Marqués de la Merced. A partir del Siglo XVIII, la familia Jiménez Pérez de Vargas utiliza el recinto del Castillo como jardín de su casa palaciega, por lo que las ruinas de épocas anteriores se verán surcadas por largos canales de ladrillo.\n\nEn la Edad Moderna, el castillo albergó una Cava o Bodega de Vino, y también se ha visto entre sus ruinas una instalación industrial oleícola, que hasta el momento se considera la más antigua de la Villa.",
    },
    {
      "title": "Leyenda de amor de Macías y doña Elvira",
      "image": "assets/images/castillo/castillo-arjonilla-10.png",
      "audio": "audios/castillo/castillo-10.mp3",
      "descripcion":
          "Nacido en Padrón, ya desde muy joven destacó por su talento poético, motivo por el que fue nombrado gentil hombre, al servicio de don Enrique de Aragón, marqués de Villena y maestre de Calatrava. Allí, en el palacio del maestre, Macías conoció a doña Elvira. Desde el primer momento nació entre ambos una pasión inmensa y secreta. Sin embargo, quiso la desgracia que Macías tuviese que ausentarse para formar parte de las fuerzas que iban a luchar en Granada.\n\nMientras tanto, el maestre dispuso que doña Elvira se casase con don Hernán Pérez de Vadillo, marqués de Porcuna. A su regreso, Macías se enteró desesperado de la amarga noticia y convirtió su desolación y penas en poesías que evidenciaban públicamente su atormentado amor. Al enterarse el don Hernán, de tal situación, pidió a Don Enrique que el Trovador cejase de cortejar a su esposa. Pero Macías no obedeció y siguió cortejando a su amada, por lo que el maestre ordenó encarcelarlo en la Torre del Castillo de Arjonilla.\n\nA pesar de estar prisionero, la pasión del trovador no se enfrió y en los atardeceres, desde su celda, acompañado de su laúd, se dedicaba a cantar sus amores hacia Doña Elvira. La noticia llegó al marqués de Porcuna que, lleno de celos y rabia, mató al trovador atravesándole el corazón con un venablo lanzado a través de la ventana de la celda.\n\nEl cuerpo del desdichado Macías fue sepultado con gran pompa en la ermita de Santa Catalina de Arjonilla. En su sepulcro, por orden del que había sido su señor, el Maestre de Calatrava, figuró la escueta inscripción: "
          "Aquí yace Macías el enamorado"
          ".",
    },
  ];

  /// Lista filtrada de audioguías del castillo.  Esta lista se actualiza según
  /// la consulta de búsqueda.
  List<Map<String, String>> filtrCast = [];

  @override
  void initState() {
    super.initState();
    filtrCast =
        castillo; // Inicialmente, muestra todas las audioguías (copia de la lista original).
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
        filtrCast = List.from(
          castillo,
        ); // Si la consulta está vacía, restaura la lista completa.
      });
    } else {
      setState(() {
        filtrCast =
            castillo.where((item) {
              // Filtra la lista original `castillo`.
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
    _searchController
        .dispose(); // Libera el controlador del campo de búsqueda (importante para evitar memory leaks).
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
                Container(), // Contenedor vacío para eliminar la flecha de retroceso predeterminada.
            centerTitle: true, // Centra el título en la AppBar.
            title: Text(
              'AUDIOGUÍAS CASTILLO',
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
                      : Icons.dark_mode, // Icono de sol/luna.
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
          backgroundColor:
              darkModeValue
                  ? const Color(0xff15181e)
                  : Colors.white, // Color de fondo del Scaffold según el tema.
          body: SingleChildScrollView(
            // Permite scroll si el contenido es mayor que la altura de la pantalla.
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller:
                        _searchController, // Asocia el controlador al campo de texto.
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
                                  .grey[200], // Color de fondo del campo de texto según el tema.
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Bordes redondeados.
                        borderSide: BorderSide.none, // Sin borde visible.
                      ),
                    ),
                    style: TextStyle(
                      color:
                          darkModeValue
                              ? Colors.white
                              : Colors.black, //color letras
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap:
                      true, // Ajusta la altura de la lista a su contenido.  Importante para anidar listas.
                  physics:
                      const NeverScrollableScrollPhysics(), // Deshabilita el scroll propio de la ListView.  Importante!
                  itemCount:
                      filtrCast
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
                                  // Crea la página de detalles y pasa los datos.
                                  isDarkMode:
                                      widget
                                          .isDarkMode, // Pasa el estado del modo oscuro.
                                  toggleTheme:
                                      widget
                                          .toggleTheme, // Pasa la función para cambiar el tema.
                                  title:
                                      filtrCast[index]["title"]!, // Pasa el título.
                                  imagePath:
                                      filtrCast[index]["image"]!, // Pasa la ruta de la imagen.
                                  audioPath:
                                      filtrCast[index]["audio"]!, // Pasa la ruta del audio.
                                  descripcion:
                                      filtrCast[index]["descripcion"]!, // Pasa la descripción.
                                ),
                          ),
                        );
                      },
                      child: GuideCard(
                        // Muestra la tarjeta de la audioguía.
                        title: filtrCast[index]["title"]!,
                        imagePath: filtrCast[index]["image"]!,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
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
                                37.974183550024065,
                                -4.104814737737992,
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
                                      37.974183550024065,
                                      -4.104814737737992,
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
