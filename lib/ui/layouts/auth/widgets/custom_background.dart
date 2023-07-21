import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
          constraints: const BoxConstraints(maxWidth: 370),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Image(image: AssetImage('twitter-white-logo.png')),
            ),
          )),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      image: DecorationImage(
          image: AssetImage('twitter-bg.png'), fit: BoxFit.cover));
}
