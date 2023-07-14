import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonDetail {
  final String name;
  final int height;
  final int weight;
  final String image;

  PokemonDetail(
      {required this.name,
      required this.height,
      required this.weight,
      required this.image});

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    var jsonName = json['name'];

    return PokemonDetail(
      name:
          "${jsonName[0].toUpperCase()}${jsonName.substring(1).toLowerCase()}",
      height: json['height'],
      weight: json['weight'],
      image: json['sprites']['front_default'],
    );
  }

  static Future<PokemonDetail> fetchPokemonDetail(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PokemonDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pokemon detail');
    }
  }
}
