abstract class Pieza {
  final String modelo;
  final double precio;

  const Pieza({required this.modelo, required this.precio});

  Map<String, dynamic> toJson() {
    return {
      'modelo': modelo,
      'precio': precio,
    };
  }
}

class CPU extends Pieza {
  const CPU({required String modelo, required double precio})
      : super(modelo: modelo, precio: precio);

  factory CPU.fromJson(Map<String, dynamic> json) {
    return CPU(
      modelo: json['modelo'],
      precio: (json['precio'] as num).toDouble(),
    );
  }
}

class RAM extends Pieza {
  const RAM({required String modelo, required double precio})
      : super(modelo: modelo, precio: precio);

  factory RAM.fromJson(Map<String, dynamic> json) {
    return RAM(
      modelo: json['modelo'],
      precio: (json['precio'] as num).toDouble(),
    );
  }
}

class Almacenamiento extends Pieza {
  const Almacenamiento({required String modelo, required double precio})
      : super(modelo: modelo, precio: precio);

  factory Almacenamiento.fromJson(Map<String, dynamic> json) {
    return Almacenamiento(
      modelo: json['modelo'],
      precio: (json['precio'] as num).toDouble(),
    );
  }
}

class GPU extends Pieza {
  const GPU({required String modelo, required double precio})
      : super(modelo: modelo, precio: precio);

  factory GPU.fromJson(Map<String, dynamic> json) {
    return GPU(
      modelo: json['modelo'],
      precio: (json['precio'] as num).toDouble(),
    );
  }
}
