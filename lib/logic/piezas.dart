abstract class Pieza {
  final String nombre;
  final double precio;

  Pieza(this.nombre, this.precio);
}

class CPU extends Pieza {
  CPU(String nombre, double precio) : super(nombre, precio);
}

class RAM extends Pieza {
  RAM(String nombre, double precio) : super(nombre, precio);
}

class Almacenamiento extends Pieza {
  Almacenamiento(String nombre, double precio) : super(nombre, precio);
}

class GPU extends Pieza {
  GPU(String nombre, double precio) : super(nombre, precio);
}
