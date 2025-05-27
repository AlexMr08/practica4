import 'dart:convert';

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
      'precio_base': precioBase,
      'uuid': id,
      'pagado': pagado,

    };
  }

  factory Ordenador.fromJson(Map<String, dynamic> json) {
    // Si Rails devolvió la columna cpu como String JSON, parsearlo
    dynamic rawCpu = json['cpu'];
    final cpuMap = rawCpu is String
        ? jsonDecode(rawCpu) as Map<String, dynamic>
        : rawCpu as Map<String, dynamic>;

    dynamic rawRam = json['ram'];
    final ramMap = rawRam is String
        ? jsonDecode(rawRam) as Map<String, dynamic>
        : rawRam as Map<String, dynamic>;

    dynamic rawAlm = json['almacenamiento'];
    final almMap = rawAlm is String
        ? jsonDecode(rawAlm) as Map<String, dynamic>
        : rawAlm as Map<String, dynamic>;

    GPU? gpuObj;
    if (json['gpu'] != null) {
      dynamic rawGpu = json['gpu'];
      final gpuMap = rawGpu is String
          ? jsonDecode(rawGpu) as Map<String, dynamic>
          : rawGpu as Map<String, dynamic>;
      gpuObj = GPU.fromJson(gpuMap);
    }

    // precio_base puede venir como String o num
    final rawBase = json['precio_base'];
    final precioBase = rawBase is String
        ? double.parse(rawBase)
        : (rawBase as num).toDouble();

    return Ordenador(
      cpu: CPU.fromJson(cpuMap),
      ram: RAM.fromJson(ramMap),
      almacenamiento: Almacenamiento.fromJson(almMap),
      gpu: gpuObj,
      precioBase: precioBase,
      pagado: json['pagado'] as bool,
      id: json['uuid'] as String,
    );
  }
}
