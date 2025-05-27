

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practica4/logic/ordenador_builder.dart';
import 'api.dart';
import './logic/piezas.dart';
import './logic/ordenador.dart';
import 'logic/ordenador_decorator.dart';

typedef Json = Map<String, dynamic>;

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
  final GlobalKey<_ListPageState> _listKey = GlobalKey<_ListPageState>();
  late final List<Widget> _pages = [
      InicioPage(),
      ListPage(key: _listKey),
    ];
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
          setState(() => _paginaActual = index);

                    if (index == 1) {
                      _listKey.currentState?._load();
                    }
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
              subtitle: Text('Desde: 1050€'),
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
              subtitle: Text('Desde 150€'),
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
          CPU(modelo: 'Ryzen 5 9600x', precio: 100),
          CPU(modelo: 'Ryzen 7 9800x', precio: 300),
          CPU(modelo: 'Ryzen 9 9900x', precio: 500),
        ],
        [
          RAM(modelo: '16GB', precio: 100),
          RAM(modelo: '32GB', precio: 150),
        ],
        [
          Almacenamiento(modelo: '500GB', precio: 100),
          Almacenamiento(modelo: '1TB', precio: 200),
        ],
        [

          GPU(modelo: 'RX 9070XT', precio: 750),
          GPU(modelo: 'RTX 5080', precio: 1000),
        ],
      ),
      'Ofimática': OpcionesProducto(
        Icons.laptop_windows_outlined,
        [
          CPU(modelo: 'intel core i3 14100F', precio: 60),
          CPU(modelo: 'Ryzen 5 3400G', precio: 65),
          CPU(modelo: 'Ryzen 5 5600G', precio: 130)
        ],
        [
          RAM(modelo: '8GB', precio: 50),
          RAM(modelo: '16GB', precio: 80),
        ],
        [
          Almacenamiento(modelo: '256GB', precio: 60),
          Almacenamiento(modelo: '512GB', precio: 90),
        ],
        [
          GPU(modelo: 'Integrada', precio: 0),
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
                      Text(pz.modelo, style: TextStyle(fontWeight: FontWeight.w500)),
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
                      Text(pz.modelo, style: TextStyle(fontWeight: FontWeight.w500)),
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
                      Text(pz.modelo, style: TextStyle(fontWeight: FontWeight.w500)),
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
                      Text(pz.modelo, style: TextStyle(fontWeight: FontWeight.w500)),
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
                    .conCPU(_opcion1.modelo, _opcion1.precio)
                    .conRAM(_opcion2.modelo, _opcion2.precio)
                    .conAlmacenamiento(_opcion3.modelo, _opcion3.precio)
                    .conGPU(_opcion4.modelo, _opcion4.precio)
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
                final ok = await Api.createOrdenador(ordenador);
                if (ok) {
                  ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Pedido enviado correctamente')),
                                        );
                                   Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Error al enviar pedido')));
                }
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
  const ListPage({Key? key}) : super(key: key);
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
    late Future<List<Ordenador>> _future;

    @override
    void initState() {
      super.initState();
      _load();
    }

    /// Carga (o recarga) la lista desde la API.
    void _load() {
      setState(() {
        _future = Api.fetchOrdenadores();
      });
    }
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
          final list = snap.data!;
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
                      Text('CPU: ${o.cpu.modelo}'),
                      Text('RAM: ${o.ram.modelo}'),
                      Text('Almacenamiento: ${o.almacenamiento.modelo}'),
                      Text('GPU: ${o.gpu?.modelo ?? "N/A"}'),
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
