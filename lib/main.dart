import 'package:flutter/material.dart';
import 'package:practica4/logic/ordenador_builder.dart';
//import 'api.dart';
import './logic/piezas.dart';
import './logic/ordenador.dart';
import 'logic/ordenador_decorator.dart';

typedef Json = Map<String, dynamic>;

// Modelo Pieza
// class Pieza {
//   final int id;
//   final String nombre;
//   final String tipo;
//   final double precio;
//
//   Pieza({
//     required this.id,
//     required this.nombre,
//     required this.tipo,
//     required this.precio,
//   });
//
//   factory Pieza.fromJson(Json json) {
//     final rawPrecio = json['precio'];
//     double parsedPrecio;
//     if (rawPrecio is num) {
//       parsedPrecio = rawPrecio.toDouble();
//     } else if (rawPrecio is String) {
//       parsedPrecio = double.tryParse(rawPrecio) ?? 0.0;
//     } else {
//       parsedPrecio = 0.0;
//     }
//     return Pieza(
//       id: json['id'] as int,
//       nombre: json['nombre'] as String,
//       tipo: json['tipo'] as String,
//       precio: parsedPrecio,
//     );
//   }
//
//   Json toJson() => {
//     'nombre': nombre,
//     'tipo': tipo,
//     'precio': precio,
//   };
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is Pieza && runtimeType == other.runtimeType && id == other.id;
//
//   @override
//   int get hashCode => id.hashCode;
// }
//
// // Modelo Ordenador
// class Ordenador {
//   final int? id;
//   final String tipo;
//   final Pieza procesador;
//   final Pieza memoria;
//   final Pieza almacenamiento;
//   final Pieza grafica;
//   final double precio;
//   bool pagado;
//
//   Ordenador({
//     this.id,
//     required this.tipo,
//     required this.procesador,
//     required this.memoria,
//     required this.almacenamiento,
//     required this.grafica,
//     required this.precio,
//     this.pagado = false,
//   });
//
//   factory Ordenador.fromJson(Json json) {
//     // Parse precio robustamente
//     final rawPrecio = json['precio'];
//     double parsedPrecio;
//     if (rawPrecio is num) {
//       parsedPrecio = rawPrecio.toDouble();
//     } else if (rawPrecio is String) {
//       parsedPrecio = double.tryParse(rawPrecio) ?? 0.0;
//     } else {
//       parsedPrecio = 0.0;
//     }
//     // Parse pagado con fallback a false
//     final rawPagado = json['pagado'];
//     bool parsedPagado;
//     if (rawPagado is bool) {
//       parsedPagado = rawPagado;
//     } else if (rawPagado is String) {
//       parsedPagado = rawPagado.toLowerCase() == 'true';
//     } else {
//       parsedPagado = false;
//     }
//     // Parse piezas array
//     final piezasJson = json['piezas'] as List<dynamic>? ?? [];
//     Pieza? p1, p2, p3, p4;
//     if (piezasJson.length >= 4) {
//       p1 = Pieza.fromJson(piezasJson[0] as Json);
//       p2 = Pieza.fromJson(piezasJson[1] as Json);
//       p3 = Pieza.fromJson(piezasJson[2] as Json);
//       p4 = Pieza.fromJson(piezasJson[3] as Json);
//     }
//     return Ordenador(
//       id: json['id'] as int?,
//       tipo: json['tipo'] as String,
//       precio: parsedPrecio,
//       pagado: parsedPagado,
//       procesador: p1 ?? Pieza(id: 0, nombre: '', tipo: '', precio: 0),
//       memoria: p2 ?? Pieza(id: 0, nombre: '', tipo: '', precio: 0),
//       almacenamiento: p3 ?? Pieza(id: 0, nombre: '', tipo: '', precio: 0),
//       grafica: p4 ?? Pieza(id: 0, nombre: '', tipo: '', precio: 0),
//     );
//   }
//
//   Json toJson() => {
//     'tipo': tipo,
//     'precio': precio,
//     'pagado': pagado,
//     'piezas_attributes': [
//       {'nombre': procesador.nombre, 'tipo': procesador.tipo, 'precio': procesador.precio},
//       {'nombre': memoria.nombre, 'tipo': memoria.tipo, 'precio': memoria.precio},
//       {'nombre': almacenamiento.nombre, 'tipo': almacenamiento.tipo, 'precio': almacenamiento.precio},
//       {'nombre': grafica.nombre, 'tipo': grafica.tipo, 'precio': grafica.precio},
//     ],
//   };
// }

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

List<Ordenador> lista = [];

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
  //final Api _api = Api();
  late Map<String, OpcionesProducto> opcionesPorProducto;
  late OpcionesProducto opciones;
  late Pieza _opcion1, _opcion2, _opcion3, _opcion4;
  int? _radioValue = 1;

  @override
  void initState() {
    super.initState();
    opcionesPorProducto = {
      'Gaming': OpcionesProducto(
        Icons.desktop_windows_outlined,
        [
          CPU('Ryzen 5 9600x', 100),
          CPU('Ryzen 7 9800x', 300),
          CPU('Ryzen 9 9900x', 500),
        ],
        [
          RAM('16GB', 100),
          RAM('32GB', 150),
        ],
        [
          Almacenamiento('500GB', 100),
          Almacenamiento('1TB', 100),
        ],
        [
          GPU('RTX 5080', 300),
          GPU('RX 9070XT', 250),
        ],
      ),
      'Ofimática': OpcionesProducto(
        Icons.laptop_windows_outlined,
        [
          CPU('intel core i3 14100F', 60),
          CPU('Ryzen 5 3400G', 65),
          CPU('Ryzen 5 5600G', 130)
        ],
        [
          RAM('8GB', 50),
          RAM('16GB', 80),
        ],
        [
          Almacenamiento('256GB', 60),
          Almacenamiento('512GB', 90),
        ],
        [
          GPU('Integrada', 0),
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
            Icon(opciones.icon, size: 100),
            SizedBox(height: 8),
            Text(
              widget.tipo,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            DropdownButton<Pieza>(
              value: _opcion1,
              isExpanded: true,
              items: opciones.opcion1
                  .map((pz) => DropdownMenuItem(
                value: pz,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pz.nombre, style: TextStyle(fontWeight: FontWeight.w500)),
                    Text('Precio: \$${pz.precio.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ]
                ),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _opcion1 = v!),
            ),
            SizedBox(height: 16),
            DropdownButton<Pieza>(
              value: _opcion2,
              isExpanded: true,
              items: opciones.opcion2
                  .map((pz) => DropdownMenuItem(
                value: pz,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pz.nombre, style: TextStyle(fontWeight: FontWeight.w500)),
                      Text('Precio: \$${pz.precio.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    ]
                ),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _opcion2 = v!),
            ),
            SizedBox(height: 16),
            DropdownButton<Pieza>(
              value: _opcion3,
              isExpanded: true,
              items: opciones.opcion3
                  .map((pz) => DropdownMenuItem(
                value: pz,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pz.nombre, style: TextStyle(fontWeight: FontWeight.w500)),
                      Text('Precio: \$${pz.precio.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    ]
                ),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _opcion3 = v!),
            ),
            SizedBox(height: 16),
            if (widget.tipo == 'Ofimática')
              Text(
                'Nota: La GPU integrada no se puede cambiar en ordenadores de ofimática.',
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
            DropdownButton<Pieza>(
              value: _opcion4,
              isExpanded: true,
              items: opciones.opcion4
                  .map((pz) => DropdownMenuItem(
                value: pz,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pz.nombre, style: TextStyle(fontWeight: FontWeight.w500)),
                      Text('Precio: \$${pz.precio.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    ]
                ),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _opcion4 = v!),
            ),
            const SizedBox(height: 16),
            Text(
              'Precio Total: \$${_opcion1.precio + _opcion2.precio + _opcion3.precio + _opcion4.precio}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: (value) {
                    setState(() {
                      _radioValue = value;
                    });
                  },
                ),
                Text('Sin descuento'),
                Radio<int>(
                  value: 2,
                  groupValue: _radioValue,
                  onChanged: (value) {
                    setState(() {
                      _radioValue = value;
                    });
                  },
                ),
                Text('Descuento de estudiantes'),
                Radio<int>(
                  value: 3,
                  groupValue: _radioValue,
                  onChanged: (value) {
                    setState(() {
                      _radioValue = value;
                    });
                  },
                ),
                Text('Descuento de empleado'),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                OrdenadorBuilder ordenadorBuilder;
                if (widget.tipo == 'Gaming') {
                  ordenadorBuilder = OrdenadorGamingBuilder();
                } else {
                  ordenadorBuilder = OrdenadorBaseBuilder();
                }
                Ordenador ordenador = ordenadorBuilder
                    .conCPU(_opcion1.nombre, _opcion1.precio)
                    .conRAM(_opcion2.nombre, _opcion2.precio)
                    .conAlmacenamiento(_opcion3.nombre, _opcion3.precio)
                    .conGPU(_opcion4.nombre, _opcion4.precio)
                    .build();
                if(_radioValue != 1){
                  if (_radioValue == 2) {
                    // Descuento de estudiantes
                    ordenador = DescuentoPorcentualDecorator(ordenador, 0.1);
                  } else if (_radioValue == 3) {
                    // Descuento de empleado
                    ordenador = DescuentoFijoDecorator(ordenador, 50);
                  }
                }
                //await _api.createOrdenador(nuevo);
                lista.add(ordenador);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Ordenador creado:\nCPU: ${ordenador.cpu.nombre}\nRAM: ${ordenador.ram.nombre}\nAlmacenamiento: ${ordenador.almacenamiento.nombre}\nGPU: ${ordenador.gpu?.nombre ?? "N/A"}\nPrecio: \$${ordenador.calcularPrecioFinal().toStringAsFixed(2)}',
                    ),
                    duration: Duration(seconds: 3),
                  ),
                );
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
  //final Api _api = Api();
  Future<List<Ordenador>> _future = Future.value([]);

  @override
  void initState() {
    super.initState();
    //_load();
  }

  //void _load() => _future = _api.fetchOrdenadores();

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
          //final list = snap.data!;
          final list = lista;
          return ListView(
            children: list.map((o) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${o.id}', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('CPU: ${o.cpu.nombre}'),
                      Text('RAM: ${o.ram.nombre}'),
                      Text('Almacenamiento: ${o.almacenamiento.nombre}'),
                      Text('GPU: ${o.gpu?.nombre ?? "N/A"}'),
                      SizedBox(height: 8),
                      Text('Precio: \$${o.calcularPrecioFinal().toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Pagado:', style: TextStyle(fontWeight: FontWeight.w500)),
                              Switch(
                                value: o.pagado,
                                onChanged: o.pagado
                                    ? null
                                    : (v) {
                                  setState(() {
                                    o.pagar();
                                  });
                                },
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: o.pagado
                                ? null
                                : () {
                              setState(() {
                                lista.remove(o);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Ordenador eliminado')),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
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
