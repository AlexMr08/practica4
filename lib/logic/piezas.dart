// Añade al inicio
import 'dart:convert';

abstract class Pieza {
  final String modelo;
  final double precio;
  Pieza({ required this.modelo, required this.precio });

  Map<String, dynamic> toJson() => {
    'nombre': modelo,
    'precio': precio,
  };
}

class CPU extends Pieza {
  CPU({ required super.modelo, required super.precio });

  factory CPU.fromJson(Map<String, dynamic> json) {
    // Asegurarnos de que 'precio' es num
    final raw = json['precio'];
    final precio = raw is String
        ? double.parse(raw)
        : (raw as num).toDouble();

    return CPU(
      modelo: json['nombre'] as String,
      precio: precio,
    );
  }
}

// Repite exactamente el mismo patrón para RAM, Almacenamiento y GPU:
class RAM extends Pieza {
  RAM({ required super.modelo, required super.precio });

  factory RAM.fromJson(Map<String, dynamic> json) {
    final raw = json['precio'];
    final precio = raw is String
        ? double.parse(raw)
        : (raw as num).toDouble();
    return RAM(
      modelo: json['nombre'] as String,
      precio: precio,
    );
  }
}

class Almacenamiento extends Pieza {
  Almacenamiento({ required super.modelo, required super.precio });

  factory Almacenamiento.fromJson(Map<String, dynamic> json) {
    final raw = json['precio'];
    final precio = raw is String
        ? double.parse(raw)
        : (raw as num).toDouble();
    return Almacenamiento(
      modelo: json['nombre'] as String,
      precio: precio,
    );
  }
}

class GPU extends Pieza {
  GPU({ required super.modelo, required super.precio });

  factory GPU.fromJson(Map<String, dynamic> json) {
    final raw = json['precio'];
    final precio = raw is String
        ? double.parse(raw)
        : (raw as num).toDouble();
    return GPU(
      modelo: json['nombre'] as String,
      precio: precio,
    );
  }
}
