import 'dart:convert';

class Pokemon {
  Pokemon(this.name, this.url);

  final String name;
  final String url;
  String? image;

  void findImage() {
    image = 'https://api.pexels.com/v1/search?query=$name';
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    var jsonName = json['pokemon']['name'];
    return Pokemon(
      "${jsonName[0].toUpperCase()}${jsonName.substring(1).toLowerCase()}",
      json['pokemon']['url'],
    );
  }

  static List<Pokemon> fromJsonList(String jsonList) {
    Map<String, dynamic> data = json.decode(jsonList);
    List results = data['pokemon'];
    return results.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
  }
}
