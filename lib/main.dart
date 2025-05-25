import 'package:flutter/material.dart';
import 'api.dart';

typedef Json = Map<String, dynamic>;

// Modelo Pieza
class Pieza {
  final int id;
  final String nombre;
  final String tipo;
  final double precio;

  Pieza({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.precio,
  });

  factory Pieza.fromJson(Json json) {
    final rawPrecio = json['precio'];
    double parsedPrecio;
    if (rawPrecio is num) {
      parsedPrecio = rawPrecio.toDouble();
    } else if (rawPrecio is String) {
      parsedPrecio = double.tryParse(rawPrecio) ?? 0.0;
    } else {
      parsedPrecio = 0.0;
    }
    return Pieza(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      tipo: json['tipo'] as String,
      precio: parsedPrecio,
    );
  }

  Json toJson() => {
    'nombre': nombre,
    'tipo': tipo,
    'precio': precio,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Pieza && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// Modelo Ordenador
class Ordenador {
  final int? id;
  final String tipo;
  final Pieza procesador;
  final Pieza memoria;
  final Pieza almacenamiento;
  final Pieza grafica;
  final double precio;
  bool pagado;

  Ordenador({
    this.id,
    required this.tipo,
    required this.procesador,
    required this.memoria,
    required this.almacenamiento,
    required this.grafica,
    required this.precio,
    this.pagado = false,
  });

  factory Ordenador.fromJson(Json json) {
    // Parse precio robustamente
    final rawPrecio = json['precio'];
    double parsedPrecio;
    if (rawPrecio is num) {
      parsedPrecio = rawPrecio.toDouble();
    } else if (rawPrecio is String) {
      parsedPrecio = double.tryParse(rawPrecio) ?? 0.0;
    } else {
      parsedPrecio = 0.0;
    }
    // Parse pagado con fallback a false
    final rawPagado = json['pagado'];
    bool parsedPagado;
    if (rawPagado is bool) {
      parsedPagado = rawPagado;
    } else if (rawPagado is String) {
      parsedPagado = rawPagado.toLowerCase() == 'true';
    } else {
      parsedPagado = false;
    }
    // Parse piezas array
    final piezasJson = json['piezas'] as List<dynamic>? ?? [];
    Pieza? p1, p2, p3, p4;
    if (piezasJson.length >= 4) {
      p1 = Pieza.fromJson(piezasJson[0] as Json);
      p2 = Pieza.fromJson(piezasJson[1] as Json);
      p3 = Pieza.fromJson(piezasJson[2] as Json);
      p4 = Pieza.fromJson(piezasJson[3] as Json);
    }
    return Ordenador(
      id: json['id'] as int?,
      tipo: json['tipo'] as String,
      precio: parsedPrecio,
      pagado: parsedPagado,
      procesador: p1 ?? Pieza(id: 0, nombre: '', tipo: '', precio: 0),
      memoria: p2 ?? Pieza(id: 0, nombre: '', tipo: '', precio: 0),
      almacenamiento: p3 ?? Pieza(id: 0, nombre: '', tipo: '', precio: 0),
      grafica: p4 ?? Pieza(id: 0, nombre: '', tipo: '', precio: 0),
    );
  }

  Json toJson() => {
    'tipo': tipo,
    'precio': precio,
    'pagado': pagado,
    'piezas_attributes': [
      {'nombre': procesador.nombre, 'tipo': procesador.tipo, 'precio': procesador.precio},
      {'nombre': memoria.nombre, 'tipo': memoria.tipo, 'precio': memoria.precio},
      {'nombre': almacenamiento.nombre, 'tipo': almacenamiento.tipo, 'precio': almacenamiento.precio},
      {'nombre': grafica.nombre, 'tipo': grafica.tipo, 'precio': grafica.precio},
    ],
  };
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Ordenadores',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _paginaActual = 0;

  final List<Widget> _pages = [InicioPage(), ListPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _pages[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaActual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Pedidos",
          ),
        ],
        onTap: (int index) {
          setState(() {
            _paginaActual = index;
          });
        },
      ),
    );
  }
}


// Página de inicio con dos tarjetas
class InicioPage extends StatelessWidget {
  void _navigateToPersonalizacion(BuildContext context, String producto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfigPage(tipo: producto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GestureDetector(
          onTap: () => _navigateToPersonalizacion(context, 'Gaming'),
          child: Card(
            child: ListTile(
              leading: Icon(Icons.desktop_windows_outlined),
              title: Text('Ordenador Gaming'),
              subtitle: Text('Desde: 800€'),
            ),
          ),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap:
              () => _navigateToPersonalizacion(context, 'Ofimática'),
          child: Card(
            child: ListTile(
              leading: Icon(Icons.laptop_windows_outlined),
              title: Text('Ordenador Ofimatica'),
              subtitle: Text('Desde 250€'),
            ),
          ),
        ),
      ],
    );
  }
}

// Página de pedidos (vacía por ahora)
class PedidosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Pedidos', style: TextStyle(fontSize: 24)));
  }
}


class ConfigPage extends StatefulWidget {
  final String tipo;
  const ConfigPage({super.key, required this.tipo});
  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final Api _api = Api();
  late Map<String, OpcionesProducto> opcionesPorProducto;
  late OpcionesProducto opciones;
  late Pieza _opcion1, _opcion2, _opcion3, _opcion4;

  @override
  void initState() {
    super.initState();
    opcionesPorProducto = {
      'Gaming': OpcionesProducto(
        Icons.desktop_windows_outlined,
        [
          Pieza(id: 1, nombre: 'Ryzen 5 9600x', tipo: 'procesador', precio: 100),
          Pieza(id: 2, nombre: 'Ryzen 7 9800x', tipo: 'procesador', precio: 300),
          Pieza(id: 3, nombre: 'Ryzen 9 9900x', tipo: 'procesador', precio: 500),
        ],
        [
          Pieza(id: 4, nombre: '16GB', tipo: 'RAM', precio: 100),
          Pieza(id: 5, nombre: '32GB', tipo: 'RAM', precio: 150),
        ],
        [
          Pieza(id: 6, nombre: '500GB', tipo: 'almacenamiento', precio: 100),
          Pieza(id: 7, nombre: '1TB', tipo: 'almacenamiento', precio: 100),
        ],
        [
          Pieza(id: 8, nombre: 'RTX 5080', tipo: 'grafica', precio: 300),
          Pieza(id: 9, nombre: 'RX 9070XT', tipo: 'grafica', precio: 250),
        ],
      ),
      'Ofimática': OpcionesProducto(
        Icons.laptop_windows_outlined,
        [
          Pieza(id: 10, nombre: 'intel core i3 14100F', tipo: 'procesador', precio: 60),
          Pieza(id: 11, nombre: 'Ryzen 5 3400G', tipo: 'procesador', precio: 65),
          Pieza(id: 12, nombre: 'Ryzen 5 5600G', tipo: 'procesador', precio: 130)
        ],
        [
          Pieza(id: 13, nombre: '8GB', tipo: 'RAM', precio: 50),
          Pieza(id: 14, nombre: '16GB', tipo: 'RAM', precio: 80),
        ],
        [
          Pieza(id: 15, nombre: '256GB', tipo: 'almacenamiento', precio: 60),
          Pieza(id: 16, nombre: '512GB', tipo: 'almacenamiento', precio: 90),
        ],
        [
          Pieza(id: 17, nombre: 'Integrada', tipo: 'grafica', precio: 0),
        ],
      ),
    };
    opciones = opcionesPorProducto[widget.tipo]!;
    _opcion1 = opciones.opcion1[0];
    _opcion2 = opciones.opcion2[0];
    _opcion3 = opciones.opcion3[0];
    _opcion4 = opciones.opcion4[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurar ${widget.tipo}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<Pieza>(
              value: _opcion1,
              items: opciones.opcion1
                  .map((pz) => DropdownMenuItem(
                value: pz,
                child: Text(pz.nombre),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _opcion1 = v!),
            ),
            DropdownButton<Pieza>(
              value: _opcion2,
              items: opciones.opcion2
                  .map((pz) => DropdownMenuItem(
                value: pz,
                child: Text(pz.nombre),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _opcion2 = v!),
            ),
            DropdownButton<Pieza>(
              value: _opcion3,
              items: opciones.opcion3
                  .map((pz) => DropdownMenuItem(
                value: pz,
                child: Text(pz.nombre),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _opcion3 = v!),
            ),
            DropdownButton<Pieza>(
              value: _opcion4,
              items: opciones.opcion4
                  .map((pz) => DropdownMenuItem(
                value: pz,
                child: Text(pz.nombre),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _opcion4 = v!),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final nuevo = Ordenador(
                  tipo: widget.tipo,
                  procesador: _opcion1,
                  memoria: _opcion2,
                  almacenamiento: _opcion3,
                  grafica: _opcion4,
                  precio: _opcion1.precio + _opcion2.precio + _opcion3.precio + _opcion4.precio,
                );
                await _api.createOrdenador(nuevo);
                Navigator.pop(context);
              },
              child: const Text('Realizar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final Api _api = Api();
  late Future<List<Ordenador>> _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => _future = _api.fetchOrdenadores();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pedidos')),
      body: FutureBuilder<List<Ordenador>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final list = snap.data!;
          return ListView(
            children: list.map((o) {
              return ListTile(
                title: Text('${o.tipo} #${o.id}'),
                subtitle: Text('Pago: ${o.pagado ? 'Sí' : 'No'} - Precio: \$${o.precio}'),
                trailing: Switch(
                  value: o.pagado,
                  onChanged: (v) async {
                    o.pagado = v;
                    await _api.updateOrdenador(o);
                    _load();
                    setState(() {});
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

// Clase de opciones para dropdowns
class OpcionesProducto {
  final IconData icon;
  final List<Pieza> opcion1;
  final List<Pieza> opcion2;
  final List<Pieza> opcion3;
  final List<Pieza> opcion4;

  OpcionesProducto(
      this.icon,
      this.opcion1,
      this.opcion2,
      this.opcion3,
      this.opcion4,
      );
}
