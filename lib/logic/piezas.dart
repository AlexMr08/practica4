abstract class Pieza {
  final String nombre;
  final double precio;

  Pieza(this.nombre, this.precio);

  // factory Pieza.fromJson(Json json) {
  //   final rawPrecio = json['precio'];
  //   double parsedPrecio;
  //   if (rawPrecio is num) {
  //     parsedPrecio = rawPrecio.toDouble();
  //   } else if (rawPrecio is String) {
  //     parsedPrecio = double.tryParse(rawPrecio) ?? 0.0;
  //   } else {
  //     parsedPrecio = 0.0;
  //   }
  //   return Pieza(
  //     nombre: json['nombre'] as String,
  //     tipo: json['tipo'] as String,
  //     precio: parsedPrecio,
  //   );
  // }

}

class CPU extends Pieza {
  CPU(String nombre, double precio) : super(nombre, precio);
}

class RAM extends Pieza {
  RAM(String nombre, double precio) : super(nombre, precio);
}

class Almacenamiento extends Pieza {
  Almacenamiento(String nombre, double precio) : super(nombre, precio);
}

class GPU extends Pieza {
  GPU(String nombre, double precio) : super(nombre, precio);
}
