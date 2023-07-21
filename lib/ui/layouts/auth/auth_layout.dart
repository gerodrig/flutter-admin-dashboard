import 'package:admin_dashboard/ui/layouts/auth/widgets/index.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Scrollbar(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          //Desktop
          (size.width > 1000)
              ? _DesktopBody(child: child)
              : _MobileBody(child: child),
          //LinksBar
          const LinksBar()
        ],
      ),
    ));
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const CustomTitle(),
            Container(
              width: double.infinity,
              height: 420,
              // color: Colors.red,
              child: child,
            ),
            Container(
              width: double.infinity,
              height: 400,
              child: const CustomBackground(),
            )
          ],
        ));
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;
  const _DesktopBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.95,
      color: Colors.black,
      child: Row(
        children: [
          const Expanded(child: CustomBackground()),

          //View Container
          Container(
              width: 600,
              height: double.infinity,
              color: Colors.black,
              child: Column(children: [
                SizedBox(height: 20),
                const CustomTitle(),
                const SizedBox(height: 50),
                Expanded(child: child)
              ]))
        ],
      ),
    );
  }
}
