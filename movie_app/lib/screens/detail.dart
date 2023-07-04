import 'dart:convert';
import 'package:flutter/material.dart';
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
    return PokemonDetail(
      name: json['name'],
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

class DetailScreen extends StatefulWidget {
  final String pokemonName;
  final String url;

  DetailScreen({Key? key, required this.pokemonName, required this.url})
      : super(key: key);

  @override
  _DetailScreeneState createState() => _DetailScreeneState();
}

class _DetailScreeneState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late Future<PokemonDetail> futurePokemonDetail;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    futurePokemonDetail = PokemonDetail.fetchPokemonDetail(widget.url);
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemonName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 50.0,
                width: 50.0,
                child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/5/51/Pokebola-pokeball-png-0.png'),
              ),
              builder: (BuildContext context, Widget? _widget) {
                return Transform.translate(
                  offset: Offset(
                      -300 +
                          (_controller.value *
                              (MediaQuery.of(context).size.width + 150)),
                      4.0),
                  child: _widget,
                );
              },
            ),
            FutureBuilder<PokemonDetail>(
              future: futurePokemonDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 150.0,
                          width: 200.0,
                          child: Image.network(
                            snapshot.data!.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'Name: ${snapshot.data!.name}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 30),
                        ),
                        const SizedBox(height: 6),
                        Text('Height: ${snapshot.data!.height}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 30)),
                        const SizedBox(height: 6),
                        Text(
                          'Weight: ${snapshot.data!.weight}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 30),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
