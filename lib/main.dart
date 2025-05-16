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

  final List<Widget> _pages = [
    InicioPage(),
    Center(child: Text('Pedidos', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _pages[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(currentIndex: _paginaActual,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Pedidos"),
      ],
        onTap: (int index){
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
          onTap: () => _navigateToPersonalizacion(context, 'Producto 1'),
          child: Card(
            child: ListTile(
              leading: Icon(Icons.local_cafe),
              title: Text('Producto 1'),
              subtitle: Text('Descripción del producto 1'),
            ),
          ),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () => _navigateToPersonalizacion(context, 'Producto 2'),
          child: Card(
            child: ListTile(
              leading: Icon(Icons.fastfood),
              title: Text('Producto 2'),
              subtitle: Text('Descripción del producto 2'),
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

  const PersonalizacionPage({Key? key, required this.producto}) : super(key: key);

  @override
  _PersonalizacionPageState createState() => _PersonalizacionPageState();
}

class _PersonalizacionPageState extends State<PersonalizacionPage> {
  String? _opcion1;
  String? _opcion2;
  String? _opcion3;
  int? _radioValue = 1;

  late OpcionesProducto opciones;

  final Map<String, OpcionesProducto> opcionesPorProducto = {
    'Producto 1': OpcionesProducto(
      icon: Icons.local_cafe,
      opcion1: ['A', 'B', 'C'],
      opcion2: ['A', 'B'],
      opcion3: ['A','B']
    ),
    'Producto 2': OpcionesProducto(
      icon: Icons.fastfood,
      opcion1: ['A', 'B'],
      opcion2: ['A', 'B'],
      opcion3: ['A', 'B', 'C'],
    )
  };

  @override
  void initState() {
    super.initState();
    opciones = opcionesPorProducto[widget.producto]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personalizar ${widget.producto}'),
      ),
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
            Text('Opción 1'),
            DropdownButton<String>(
              value: _opcion1,
              hint: Text('Selecciona una opción'),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _opcion1 = value;
                });
              },
              items: opciones.opcion1.map((opcion) {
                return DropdownMenuItem(
                  value: opcion,
                  child: Text(opcion),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text('Opción 2'),
            DropdownButton<String>(
              value: _opcion2,
              hint: Text('Selecciona una opción'),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _opcion2 = value;
                });
              },
              items: opciones.opcion2.map((opcion) {
                return DropdownMenuItem(
                  value: opcion,
                  child: Text(opcion),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text('Opción 3'),
            DropdownButton<String>(
              value: _opcion3,
              hint: Text('Selecciona una opción'),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _opcion3 = value;
                });
              },
              items: opciones.opcion3.map((opcion) {
                return DropdownMenuItem(
                  value: opcion,
                  child: Text(opcion),
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
                  // Aquí puedes manejar el pedido
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Pedido realizado'),
                    ),
                  );
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
  final List<String> opcion1;
  final List<String> opcion2;
  final List<String> opcion3;

  OpcionesProducto({
    required this.icon,
    required this.opcion1,
    required this.opcion2,
    required this.opcion3,
  });
}
