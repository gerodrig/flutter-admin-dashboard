import 'package:flutter/material.dart';

import 'package:admin_dashboard/providers/sidemenu_provider.dart';

import 'package:admin_dashboard/ui/shared/widgets/Navbar_Avatar.dart';
import 'package:admin_dashboard/ui/shared/widgets/notifications_indicator.dart';
import 'package:admin_dashboard/ui/shared/widgets/search_text.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        width: double.infinity,
        height: 50,
        decoration: buildBoxDecoration(),
        child: Row(
          children: [
            //TODO: hamburger menu show if less than 700px
            if (size.width <= 700)
              IconButton(
                  icon: const Icon(Icons.menu_outlined),
                  onPressed: () => SideMenuProvider.openMenu()),

            const SizedBox(width: 5),

            //Search Input
            if (size.width > 390)
              ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: const SearchText()),

            const Spacer(),

            const NotificationsIndicator(),

            const SizedBox(width: 10),

            const NavbarAvatar(),

            const SizedBox(width: 10),
          ],
        ));
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}
