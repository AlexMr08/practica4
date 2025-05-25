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

class CPU {
  final String modelo;
  final double precio;

  CPU({required this.modelo, required this.precio});

  factory CPU.fromJson(Map<String, dynamic> json) {
    return CPU(
      modelo: json['modelo'],
      precio: (json['precio'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modelo': modelo,
      'precio': precio,
    };
  }
}


class RAM {
  final String capacidad;
  final double precio;

  RAM({required this.capacidad, required this.precio});

  factory RAM.fromJson(Map<String, dynamic> json) {
    return RAM(
      capacidad: json['capacidad'],
      precio: (json['precio'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'capacidad': capacidad,
      'precio': precio,
    };
  }
}


class Almacenamiento {
  final String tipo;
  final String capacidad;
  final double precio;

  Almacenamiento({
    required this.tipo,
    required this.capacidad,
    required this.precio,
  });

  factory Almacenamiento.fromJson(Map<String, dynamic> json) {
    return Almacenamiento(
      tipo: json['tipo'],
      capacidad: json['capacidad'],
      precio: (json['precio'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'capacidad': capacidad,
      'precio': precio,
    };
  }
}


class GPU {
  final String modelo;
  final double precio;

  GPU({required this.modelo, required this.precio});

  factory GPU.fromJson(Map<String, dynamic> json) {
    return GPU(
      modelo: json['modelo'],
      precio: (json['precio'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modelo': modelo,
      'precio': precio,
    };
  }
}

