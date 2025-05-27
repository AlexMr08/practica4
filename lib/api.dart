import 'dart:convert';
import 'package:http/http.dart' as http;
import 'logic/ordenador.dart';

class Api {
  // Ajusta la URL a la de tu servidor
  static const _baseUrl = 'http://localhost:3000/api/ordenadores';

  /// Crea un nuevo pedido
  static Future<bool> createOrdenador(Ordenador o) async {
    final res = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ordenador': o.toJson(),
      }),
    );
    return res.statusCode == 201;
  }

  /// Recupera todos los pedidos
  static Future<List<Ordenador>> fetchOrdenadores() async {
    final uri = Uri.parse(_baseUrl);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Error al cargar ordenadores: ${response.statusCode}');
    }
    final List data = jsonDecode(response.body);
    return data.map((e) => Ordenador.fromJson(e)).toList();
  }
}
