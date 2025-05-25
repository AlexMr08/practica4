import 'ordenador.dart';
import 'piezas.dart';

class OrdenadorBuilder {
  double precioBase = 0.0;

  CPU? _cpu;
  RAM? _ram;
  Almacenamiento? _almacenamiento;
  GPU? _gpu;

  OrdenadorBuilder conCPU(String modelo, double precio) {
    _cpu = CPU(modelo: modelo, precio: precio);
    return this;
  }

  OrdenadorBuilder conRAM(String modelo, double precio) {
    _ram = RAM(modelo: modelo, precio: precio);
    return this;
  }

  OrdenadorBuilder conAlmacenamiento(String modelo, double precio) {
    _almacenamiento = Almacenamiento(modelo: modelo, precio: precio);
    return this;
  }

  OrdenadorBuilder conGPU(String modelo, double precio) {
    _gpu = GPU(modelo: modelo, precio: precio);
    return this;
  }

  Ordenador build() {
    if (_cpu == null || _ram == null || _almacenamiento == null) {
      throw Exception('CPU, RAM y Almacenamiento son obligatorios');
    }

    return Ordenador(
      cpu: _cpu!,
      ram: _ram!,
      almacenamiento: _almacenamiento!,
      gpu: _gpu,
      precioBase: precioBase,
    );
  }
}

class OrdenadorBaseBuilder extends OrdenadorBuilder {
  OrdenadorBaseBuilder() {
    super.precioBase = 150.0;
  }
}

class OrdenadorGamingBuilder extends OrdenadorBuilder {
  OrdenadorGamingBuilder() {
    super.precioBase = 500.0;
  }
}
