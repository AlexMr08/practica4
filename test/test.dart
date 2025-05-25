import 'package:test/test.dart';
import '../lib/piezas.dart';
import '../lib/ordenador.dart';
import '../lib/ordenador_builder.dart';
import '../lib/descuento_decorator.dart';
import '../api.dart';

void main() {
  late Api _api;

  setUp(() {
    _api = Api();
  });

  test('RF1: Se crean ordenadores de ofimática correctamente', () {
    final ordenador = OrdenadorBaseBuilder()
      ..conCPU('Intel i3', 100)
      ..conRAM('8GB', 50)
      ..conAlmacenamiento('256GB SSD', 80);

    final result = ordenador.build();

    expect(result.cpu.nombre, 'Intel i3');
    expect(result.gpu, isNull);
    expect(result.calcularPrecioSinDescuento(), 150 + 100 + 50 + 80);
  });

  test('RF2: Se crean ordenadores gaming correctamente', () {
    final ordenador = OrdenadorGamingBuilder()
      ..conCPU('Intel i9', 300)
      ..conRAM('32GB', 180)
      ..conAlmacenamiento('1TB NVMe', 200)
      ..conGPU('RTX 4080', 700);

    final result = ordenador.build();

    expect(result.gpu!.nombre, 'RTX 4080');
    expect(result.calcularPrecioSinDescuento(), 500 + 300 + 180 + 200 + 700);
  });

  test('RF3: El pedido no pagado se borra correctamente', () {
    final ordenador = OrdenadorBaseBuilder()
      ..conCPU('i5', 100)
      ..conRAM('16GB', 90)
      ..conAlmacenamiento('512GB SSD', 120);

    final o = ordenador.build();
    _api.createOrdenador(o);
    final deleted = _api.deleteOrdenador(o.id);

    expect(deleted, true);
    expect(_api.fetchOrdenadores(), isEmpty);
  });

  test('RF4: Se pueden pagar pedidos correctamente', () {
    final ordenador = OrdenadorBaseBuilder()
      ..conCPU('i5', 100)
      ..conRAM('16GB', 90)
      ..conAlmacenamiento('512GB SSD', 120);

    final o = ordenador.build();
    _api.createOrdenador(o);

    o.pagado = true;
    _api.updateOrdenador(o);

    final result = _api.fetchOrdenadores().first;
    expect(result.pagado, isTrue);
  });

  test('RF5: Un pedido pagado no puede borrarse del sistema', () {
    final ordenador = OrdenadorBaseBuilder()
      ..conCPU('i5', 100)
      ..conRAM('16GB', 90)
      ..conAlmacenamiento('512GB SSD', 120);

    final o = ordenador.build();
    o.pagado = true;
    _api.createOrdenador(o);

    final deleted = _api.deleteOrdenador(o.id);
    expect(deleted, false);
    expect(_api.fetchOrdenadores().length, 1);
  });

  test('RF6: El descuento se elige correctamente (porcentual)', () {
    final ordenador = OrdenadorBaseBuilder()
      ..conCPU('i5', 100)
      ..conRAM('16GB', 90)
      ..conAlmacenamiento('512GB SSD', 110);

    final o = ordenador.build();
    final decorado = DescuentoPorcentualDecorator(o, 0.10);

    expect(decorado.calcularPrecioFinal(),
        closeTo(o.calcularPrecioSinDescuento() * 0.9, 0.01));
  });

  test('RF6: El descuento se elige correctamente (fijo)', () {
    final ordenador = OrdenadorBaseBuilder()
      ..conCPU('i5', 100)
      ..conRAM('16GB', 90)
      ..conAlmacenamiento('512GB SSD', 110);

    final o = ordenador.build();
    final decorado = DescuentoFijoDecorator(o, 50);

    expect(decorado.calcularPrecioFinal(),
        o.calcularPrecioSinDescuento() - 50);
  });

  test('RF7: El precio final se calcula aplicando el descuento correctamente', () {
    final ordenador = OrdenadorBaseBuilder()
      ..conCPU('i3', 80)
      ..conRAM('8GB', 40)
      ..conAlmacenamiento('256GB', 60);

    final o = ordenador.build();
    final decorado = DescuentoPorcentualDecorator(o, 0.2); // 20%

    final esperado = o.calcularPrecioSinDescuento() * 0.8;
    expect(decorado.calcularPrecioFinal(), closeTo(esperado, 0.01));
  });

  test('RF8: El precio sin descuento se calcula correctamente', () {
    final ordenador = OrdenadorBaseBuilder()
      ..conCPU('i3', 80)
      ..conRAM('8GB', 40)
      ..conAlmacenamiento('256GB', 60);

    final o = ordenador.build();
    final esperado = 150 + 80 + 40 + 60;
    expect(o.calcularPrecioSinDescuento(), esperado);
  });

  // Operaciones con base de datos
  test('DB: Insertar pedido', () {
    final o = OrdenadorBaseBuilder()
      ..conCPU('i5', 100)
      ..conRAM('16GB', 90)
      ..conAlmacenamiento('512GB SSD', 110)
      ..build();

    _api.createOrdenador(o);
    expect(_api.fetchOrdenadores().length, 1);
  });

  test('DB: Borrar pedido no pagado', () {
    final o = OrdenadorBaseBuilder()
      ..conCPU('i5', 100)
      ..conRAM('16GB', 90)
      ..conAlmacenamiento('512GB SSD', 110)
      ..build();

    _api.createOrdenador(o);
    _api.deleteOrdenador(o.id);
    expect(_api.fetchOrdenadores().length, 0);
  });

  test('DB: Seleccionar pedidos', () {
    final o1 = OrdenadorBaseBuilder()
      ..conCPU('i3', 80)
      ..conRAM('8GB', 40)
      ..conAlmacenamiento('256GB', 60)
      ..build();

    final o2 = OrdenadorGamingBuilder()
      ..conCPU('i9', 300)
      ..conRAM('32GB', 150)
      ..conAlmacenamiento('1TB', 200)
      ..conGPU('RTX 4070', 600)
      ..build();

    _api.createOrdenador(o1);
    _api.createOrdenador(o2);

    final all = _api.fetchOrdenadores();
    expect(all.length, 2);
  });

  test('DB: Editar pedido', () {
    final o = OrdenadorBaseBuilder()
      ..conCPU('i3', 80)
      ..conRAM('8GB', 40)
      ..conAlmacenamiento('256GB', 60)
      ..build();

    _api.createOrdenador(o);

    o.pagado = true;
    _api.updateOrdenador(o);

    final updated = _api.fetchOrdenadores().first;
    expect(updated.pagado, true);
  });
}
