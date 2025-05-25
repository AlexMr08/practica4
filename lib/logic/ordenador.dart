import 'package:uuid/uuid.dart';

class Ordenador {
  final String cpu;
  final String ram;
  final String almacenamiento;
  final String? gpu;
  final double precioBase;
  final String id;
  bool pagado;

  Ordenador({
    required this.cpu,
    required this.ram,
    required this.almacenamiento,
    this.gpu,
    required this.precioBase,
    this.pagado = false,
    String? id,
  }) : id = id ?? const Uuid().v4();

  double calcularPrecioSinDescuento() => precioBase;

  double calcularPrecioFinal() => precioBase;
}
