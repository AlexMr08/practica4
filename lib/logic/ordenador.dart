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
    if(pagado)
      return false; // Ya pagado, no se puede pagar de nuevo
    pagado = true;
    return true;
  }

  bool puedoBorrar(){
    return !pagado;
  }

  double calcularPrecioFinal() => calcularPrecioSinDescuento();
}
