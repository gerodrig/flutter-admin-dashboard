import 'package:flutter/material.dart';

class NavbarAvatar extends StatelessWidget {
  const NavbarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        child: Image.network(
            'https://th.bing.com/th/id/OIG.jz.hD7bsr8l16ZSKEYSF?pid=ImgGn'),
        width: 30,
        height: 30,
      ),
    );
  }
}
