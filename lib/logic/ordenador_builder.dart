import 'ordenador.dart';

class OrdenadorBuilder {
  String cpu = '';
  String ram = '';
  String almacenamiento = '';
  String? gpu;
  double precioBase = 0.0;

  OrdenadorBuilder conCPU(String cpu) {
    this.cpu = cpu;
    return this;
  }

  OrdenadorBuilder conRAM(String ram) {
    this.ram = ram;
    return this;
  }

  OrdenadorBuilder conAlmacenamiento(String almacenamiento) {
    this.almacenamiento = almacenamiento;
    return this;
  }

  OrdenadorBuilder conGPU(String gpu) {
    this.gpu = gpu;
    return this;
  }

  OrdenadorBuilder conPrecioBase(double precio) {
    this.precioBase = precio;
    return this;
  }

  Ordenador build() {
    return Ordenador(
      cpu: cpu,
      ram: ram,
      almacenamiento: almacenamiento,
      gpu: gpu,
      precioBase: precioBase,
    );
  }
}
