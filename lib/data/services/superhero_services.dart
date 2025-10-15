import 'dart:convert';
import 'package:api_flutter/data/models/superhero_model.dart';
import 'package:http/http.dart' as http;

class SuperheroService {
  static const String baseUrl = 'https://www.superheroapi.com/api.php';
  static const String accessToken = '445d2ece3edf01c9c7ad5043f9710643'; // Necesitas registrarte

  // Buscar superhéroe por nombre
  static Future<List<Superhero>> searchSuperhero(String query) async {
    if (query.isEmpty) return [];

    final response = await http.get(
      Uri.parse('$baseUrl/$accessToken/search/$query'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      
      if (data['response'] == 'success') {
        List<dynamic> results = data['results'];
        return results.map((json) => Superhero.fromJson(json)).toList();
      } else if (data['response'] == 'error') {
        throw Exception('No se encontraron superhéroes: ${data['error']}');
      }
    }
    
    throw Exception('Error en la conexión: ${response.statusCode}');
  }

  // Obtener superhéroe por ID
  static Future<Superhero> getSuperheroById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$accessToken/$id'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      
      if (data['response'] == 'success') {
        return Superhero.fromJson(data);
      } else {
        throw Exception('Error: ${data['error']}');
      }
    }
    
    throw Exception('Error en la conexión: ${response.statusCode}');
  }
}