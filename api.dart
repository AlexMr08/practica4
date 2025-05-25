

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';


class Api {
  /// Base URL de tu API Rails.
  /// Si corres Flutter en emulador Android, usa 10.0.2.2 en lugar de localhost.
  static const String baseUrl = 'http://localhost:3000';

  ///
  /// PIEZAS
  ///

  /// Obtener todas las piezas
  Future<List<Pieza>> fetchPiezas() async {
    final resp = await http.get(Uri.parse('$baseUrl/piezas'));
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((j) => Pieza.fromJson(j)).toList();
    } else {
      throw Exception('Error al cargar piezas (${resp.statusCode})');
    }
  }

  ///
  /// ORDENADORES
  ///

  /// Obtener todos los ordenadores (con sus piezas embebidas)
  Future<List<Ordenador>> fetchOrdenadores() async {
    final resp = await http.get(Uri.parse('$baseUrl/ordenadores'));
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body);
      return data.map((j) => Ordenador.fromJson(j)).toList();
    } else {
      throw Exception('Error al cargar ordenadores (${resp.statusCode})');
    }
  }

  /// Crear un nuevo ordenador (con lista de piezas)
  Future<Ordenador> createOrdenador(Ordenador o) async {
    final body = jsonEncode({
      'ordenador': {
        'tipo': o.tipo,
        'precio': o.precio,
        'pagado': o.pagado,
        'piezas_attributes': [
          {
            'nombre': o.procesador.nombre,
            'tipo': o.procesador.tipo,
            'precio': o.procesador.precio,
          },
          {
            'nombre': o.memoria.nombre,
            'tipo': o.memoria.tipo,
            'precio': o.memoria.precio,
          },
          {
            'nombre': o.almacenamiento.nombre,
            'tipo': o.almacenamiento.tipo,
            'precio': o.almacenamiento.precio,
          },
          {
            'nombre': o.grafica.nombre,
            'tipo': o.grafica.tipo,
            'precio': o.grafica.precio,
          },
        ],
      },
    });

    final resp = await http.post(
      Uri.parse('$baseUrl/ordenadores'),
      headers: { 'Content-Type': 'application/json' },
      body: body,
    );
    if (resp.statusCode == 201) {
      return Ordenador.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Error al crear ordenador: ${resp.body}');
    }
  }
  /// Actualizar un ordenador existente
  Future<Ordenador> updateOrdenador(Ordenador ordenador) async {
    if (ordenador.id == null) {
      throw Exception('Ordenador sin id no puede actualizarse');
    }
    final body = jsonEncode({
      'ordenador': ordenador.toJson()
    });
    final resp = await http.patch(
      Uri.parse('$baseUrl/ordenadores/${ordenador.id}'),
      headers: { 'Content-Type': 'application/json' },
      body: body,
    );
    if (resp.statusCode == 200) {
      return Ordenador.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Error al actualizar ordenador (${resp.statusCode}): ${resp.body}');
    }
  }

  /// Eliminar un ordenador por id
  Future<void> deleteOrdenador(int id) async {
    final resp = await http.delete(Uri.parse('$baseUrl/ordenadores/$id'));
    if (resp.statusCode != 204 && resp.statusCode != 200) {
      throw Exception('Error al eliminar ordenador (${resp.statusCode})');
    }
  }
}
