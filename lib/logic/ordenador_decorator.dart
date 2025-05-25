import 'ordenador.dart';

abstract class DescuentoDecorator extends Ordenador {
  final Ordenador base;

  DescuentoDecorator(this.base)
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
  double calcularPrecioSinDescuento() {
    return base.calcularPrecioSinDescuento();
  }
}

class DescuentoPorcentualDecorator extends DescuentoDecorator {
  final double porcentaje; // 0.0 a 1.0

  DescuentoPorcentualDecorator(Ordenador base, this.porcentaje)
      : super(base);

  @override
  double calcularPrecioFinal() {
    final original = base.calcularPrecioSinDescuento();
    return original * (1 - porcentaje);
  }
}

class DescuentoFijoDecorator extends DescuentoDecorator {
  final double cantidadFija;

  DescuentoFijoDecorator(Ordenador base, this.cantidadFija)
      : super(base);

  @override
  double calcularPrecioFinal() {
    final original = base.calcularPrecioSinDescuento();
    final total = original - cantidadFija;
    return total < 0 ? 0 : total; // evita precio negativo
  }
}