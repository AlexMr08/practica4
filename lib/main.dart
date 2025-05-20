import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
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

  final List<Widget> _pages = [InicioPage(), PedidosPage()];

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
        builder: (context) => PersonalizacionPage(producto: producto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GestureDetector(
          onTap: () => _navigateToPersonalizacion(context, 'ordenador gaming'),
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
              () => _navigateToPersonalizacion(context, 'ordenador ofimatica'),
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

// Página de personalización del producto
class PersonalizacionPage extends StatefulWidget {
  final String producto;

  const PersonalizacionPage({Key? key, required this.producto})
    : super(key: key);

  @override
  _PersonalizacionPageState createState() => _PersonalizacionPageState();
}

class _PersonalizacionPageState extends State<PersonalizacionPage> {
  Pieza? _opcion1;
  Pieza? _opcion2;
  Pieza? _opcion3;
  Pieza? _opcion4;
  int? _radioValue = 1;

  late OpcionesProducto opciones;

  final Map<String, OpcionesProducto> opcionesPorProducto = {
    'ordenador gaming': OpcionesProducto(
      Icons.desktop_windows_outlined,
      [
        Pieza(id: 1, nombre: 'Ryzen 5 9600x', tipo: 'procesador', precio: 100),
        Pieza(id: 2, nombre: 'Ryzen 7 9800x', tipo: 'procesador', precio: 300),
        Pieza(id: 3, nombre: 'Ryzen 9 9900x', tipo: 'procesador', precio: 500),
      ],
      [
        Pieza(id: 1, nombre: '16GB', tipo: 'RAM', precio: 100),
        Pieza(id: 2, nombre: '32GB', tipo: 'RAM', precio: 150),
      ],
      [
        Pieza(id: 1, nombre: '500GB', tipo: 'almacenamientp', precio: 100),
        Pieza(id: 2, nombre: '1TB', tipo: 'almacenamiento', precio: 100),
      ],
      [
        Pieza(id: 1, nombre: 'RTX 5080', tipo: 'grafica', precio: 300),
        Pieza(id: 2, nombre: 'RX 9070XT', tipo: 'grafica', precio: 250),
      ],
    ),
    'ordenador ofimatica': OpcionesProducto(
      Icons.laptop_windows_outlined,
      [
        Pieza(id: 1, nombre: 'Ryzen 5 9600x', tipo: 'procesador', precio: 100),
        Pieza(id: 2, nombre: 'Ryzen 5 9600x', tipo: 'procesador', precio: 100),
        Pieza(id: 3, nombre: 'Ryzen 5 9600x', tipo: 'procesador', precio: 100),
      ],
      [
        Pieza(id: 1, nombre: '16GB', tipo: 'RAM', precio: 100),
        Pieza(id: 2, nombre: '32GB', tipo: 'RAM', precio: 100),
      ],
      [
        Pieza(id: 1, nombre: '500GB', tipo: 'almacenamientp', precio: 100),
        Pieza(id: 2, nombre: '1TB', tipo: 'almacenamiento', precio: 100),
      ],
        [Pieza(id: 1, nombre: 'integrada', tipo: 'grafica', precio: 0)]
    ),
  };

  @override
  void initState() {
    super.initState();
    opciones = opcionesPorProducto[widget.producto]!;
    _opcion1 = opciones.opcion1[0];
    _opcion2 = opciones.opcion2[0];
    _opcion3 = opciones.opcion3[0];
    _opcion4 = opciones.opcion4[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personalizar ${widget.producto}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(opciones.icon, size: 100),
                  SizedBox(height: 8),
                  Text(
                    widget.producto,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text('Procesador'),
            DropdownButton<Pieza>(
              value: _opcion1,
              hint: Text('Selecciona una opción'),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _opcion1 = value;
                });
              },
              items:
                  opciones.opcion1.map((opcion) {
                    return DropdownMenuItem(
                      value: opcion,
                      child: Text(opcion.nombre),
                    );
                  }).toList(),
            ),
            SizedBox(height: 16),
            Text('Memoria RAM'),
            DropdownButton<Pieza>(
              value: _opcion2,
              hint: Text('Selecciona una opción'),
              isExpanded: false,
              onChanged: (value) {
                setState(() {
                  _opcion2 = value;
                });
              },
              items:
                  opciones.opcion2.map((opcion) {
                    return DropdownMenuItem(
                      value: opcion,
                      child: Text(opcion.nombre),
                    );
                  }).toList(),
            ),
            SizedBox(height: 16),
            Text('Almacenamiento'),
            DropdownButton<Pieza>(
              value: _opcion3,
              hint: Text('Selecciona una opción'),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _opcion3 = value;
                });
              },
              items:
                  opciones.opcion3.map((opcion) {
                    return DropdownMenuItem(
                      value: opcion,
                      child: Text(opcion.nombre),
                    );
                  }).toList(),
            ),
            if (widget.producto == 'ordenador gaming') SizedBox(height: 16),
            if (widget.producto == 'ordenador gaming') Text('Tarjeta grafica'),
            if (widget.producto == 'ordenador gaming')
              DropdownButton<Pieza>(
                value: _opcion4,
                hint: Text('Selecciona una opción'),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    _opcion4 = value;
                  });
                },
                items:
                    opciones.opcion2.map((opcion) {
                      return DropdownMenuItem(
                        value: opcion,
                        child: Text(opcion.nombre),
                      );
                    }).toList(),
              ),
            SizedBox(height: 32),
            Text('Seleccionar descuento:'),
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
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  var ordenador;
                  if(widget.producto == 'ordenador gaming' && _opcion1 != null && _opcion2 != null && _opcion3 != null && _opcion4 != null){
                    ordenador = Ordenador(widget.producto, _opcion1!, _opcion2!, _opcion3!, _opcion3!);
                  }else if(widget.producto == 'ordenador ofimatica' && _opcion1 != null && _opcion2 != null && _opcion3 != null){
                    ordenador = Ordenador(widget.producto, _opcion1!, _opcion2!, _opcion3!, _opcion4!);
                  }else{
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('No has seleccionado todos los componentes')));
                  }
                  // Aquí puedes manejar el pedido
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Pedido realizado: '+ordenador.tipo)));
                  Navigator.pop(context);
                },
                child: Text('Realizar pedido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OpcionesProducto {
  final icon;
  final List<Pieza> opcion1;
  final List<Pieza> opcion2;
  final List<Pieza> opcion3;
  final List<Pieza> opcion4;

  OpcionesProducto(this.icon, this.opcion1, this.opcion2, this.opcion3, this.opcion4);
}

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Pieza && runtimeType == other.runtimeType && id == other.id;
}

class Ordenador {
  final String tipo;
  final Pieza procesador;
  final Pieza memoria;
  final Pieza almacenamiento;
  final Pieza grafica;
  double? precio;
  bool pagado = false;



  Ordenador(
    this.tipo,
    this.procesador,
    this.memoria,
    this.almacenamiento,
    this.grafica,
  );

}

/*
class Pedido{
  final int id;
  final Ordenador ordenador;
  //final int descuento;
  bool pagado = false;

  Pedido(this.id, this.ordenador, this.descuento, this.precioFinal);
}
 */