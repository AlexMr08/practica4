import 'ordenador.dart';
import 'piezas.dart';

class OrdenadorBuilder {
  double precioBase = 0.0;

  CPU? _cpu;
  RAM? _ram;
  Almacenamiento? _almacenamiento;
  GPU? _gpu;

  OrdenadorBuilder conCPU(String nombre, double precio) {
    _cpu = CPU(nombre, precio);
    return this;
  }

  OrdenadorBuilder conRAM(String nombre, double precio) {
    _ram = RAM(nombre, precio);
    return this;
  }

  OrdenadorBuilder conAlmacenamiento(String nombre, double precio) {
    _almacenamiento = Almacenamiento(nombre, precio);
    return this;
  }

  OrdenadorBuilder conGPU(String nombre, double precio) {
    _gpu = GPU(nombre, precio);
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
