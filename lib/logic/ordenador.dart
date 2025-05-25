import 'package:uuid/uuid.dart';
import 'piezas.dart';

class Ordenador {
  final CPU cpu;
  final RAM ram;
  final Almacenamiento almacenamiento;
  final GPU? gpu;
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

  double calcularPrecioSinDescuento() {
    double total = precioBase +
        cpu.precio +
        ram.precio +
        almacenamiento.precio;
    if (gpu != null) total += gpu!.precio;
    return total;
  }

  bool pagar() {
    if (pagado) return false;
    pagado = true;
    return true;
  }

  bool puedoBorrar() => !pagado;

  double calcularPrecioFinal() => calcularPrecioSinDescuento();

  Map<String, dynamic> toJson() {
    return {
      'cpu': cpu.toJson(),
      'ram': ram.toJson(),
      'almacenamiento': almacenamiento.toJson(),
      'gpu': gpu?.toJson(), // puede ser null
      'precioBase': precioBase,
      'id': id,
      'pagado': pagado,
      'precioFinal': calcularPrecioFinal(),
    };
  }

  factory Ordenador.fromJson(Map<String, dynamic> json) {
    return Ordenador(
      cpu: CPU.fromJson(json['cpu']),
      ram: RAM.fromJson(json['ram']),
      almacenamiento: Almacenamiento.fromJson(json['almacenamiento']),
      gpu: json['gpu'] != null ? GPU.fromJson(json['gpu']) : null,
      precioBase: (json['precioBase'] as num).toDouble(),
      id: json['id'],
      pagado: json['pagado'] ?? false,
    );
  }
}
