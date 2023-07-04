import 'package:flutter/material.dart';
import 'package:movie_app/models/pokemon.dart';
import 'package:http/http.dart' as http;

import 'detail.dart';

// ignore: must_be_immutable
class PokemonsScreen extends StatefulWidget {
  PokemonsScreen({super.key, required this.title});

  final String title;
  late List<Pokemon> pokemons;

  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Uh oh... nothing here!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          const SizedBox(height: 16),
          Text('Try selecting a diffrent category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground))
        ],
      ),
    );

    if (pokemons.isNotEmpty) {
      content = ListView.builder(
          itemBuilder: (ctx, index) => Text(pokemons[index].name));
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: content,
    );
  }

  @override
  _PokemonsScreen createState() => _PokemonsScreen(this.title);
}

class _PokemonsScreen extends State<PokemonsScreen> {
  _PokemonsScreen(this.name);

  final String name;
  late Future<List<Pokemon>> futurePokemonList;

  @override
  void initState() {
    super.initState();
    futurePokemonList = fetchPokemons();
  }

  Future<List<Pokemon>> fetchPokemons() async {
    var url = Uri.parse('https://pokeapi.co/api/v2/type/${name.toLowerCase()}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Pokemon.fromJsonList(response.body);
    } else {
      throw Exception('Failed to load Pokemons');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FutureBuilder<List<Pokemon>>(
          future: futurePokemonList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(
                          snapshot.data![index].name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => DetailScreen(
                                      pokemonName: snapshot.data![index].name,
                                      url: snapshot.data![index].url)));
                        });
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
