import 'dart:convert';
import 'package:http/http.dart'as http;

class ApiService {
  static const String apiKey = '80957391a53405eae08d9abe405afde3';
  static const String baseUrl = 'https://api.spoonacular.com/recipes/complexSearch';

  Future<List> searchRecipes(String query, {List<String>? ingredients, String? diet}) async {
    final response = await http.get(Uri.parse(
      '$baseUrl?query=$query&includeIngredients=${ingredients?.join(",")}&diet=$diet&apiKey=$apiKey',
    ));


    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}