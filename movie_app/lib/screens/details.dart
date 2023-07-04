import 'package:flutter/material.dart';

import '../models/detail.dart';

class DetailsScreen extends StatefulWidget {
  final String pokemonName;
  final String url;

  DetailsScreen({Key? key, required this.pokemonName, required this.url})
      : super(key: key);

  @override
  _DetailsScreeneState createState() => _DetailsScreeneState();
}

class _DetailsScreeneState extends State<DetailsScreen>
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
