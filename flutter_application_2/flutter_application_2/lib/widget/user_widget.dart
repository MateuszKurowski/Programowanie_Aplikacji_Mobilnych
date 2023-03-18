import 'package:flutter/material.dart';

import '../model/user.dart';

class UserWidget extends StatelessWidget {
  final User user;

  UserWidget({super.key, required this.user})

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Text(user.surname,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 25,
                )),
          ),
          const Text("Ala ma kota")
        ],
      ),
    );
  }
}
