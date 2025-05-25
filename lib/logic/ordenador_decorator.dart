import 'ordenador.dart';

abstract class OrdenadorDecorator extends Ordenador {
  final Ordenador base;

  @override
  double calcularPrecioFinal();

  @override
  double calcularPrecioSinDescuento() {
    return base.calcularPrecioSinDescuento();
  }
}

class DescuentoPorcentaje extends Ordenador {
  final Ordenador base;
  final double descuento; // entre 0.0 y 1.0 (ej: 0.15 = 15%)

  DescuentoDecorator(this.base, this.descuento)
      : super(
          cpu: base.cpu,
          ram: base.ram,
          almacenamiento: base.almacenamiento,
          gpu: base.gpu,
          precioBase: base.precioBase,
          pagado: base.pagado,
          id: base.id,
        );

  @override
  double calcularPrecioFinal() {
    return base.calcularPrecioSinDescuento() * (1 - descuento);
  }

  @override
  double calcularPrecioSinDescuento() {
    return base.calcularPrecioSinDescuento();
  }
}

class DescuentoCantidad extends Ordenador {
  final Ordenador base;
  final double descuento;

  DescuentoDecorator(this.base, this.descuento)
      : super(
          cpu: base.cpu,
          ram: base.ram,
          almacenamiento: base.almacenamiento,
          gpu: base.gpu,
          precioBase: base.precioBase,
          pagado: base.pagado,
          id: base.id,
        );

  @override
  double calcularPrecioFinal() {
    return base.calcularPrecioSinDescuento() - descuento;
  }

  @override
  double calcularPrecioSinDescuento() {
    return base.calcularPrecioSinDescuento();
  }
}
