import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';

class IconView extends StatelessWidget {
  const IconView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Text('Icon View', style: CustomLabels.h1),
            const SizedBox(height: 10),
            const Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              children: [
                WhiteCard(
                  title: 'ac_unit_outlined',
                  width: 170,
                  child: Center(
                    child: Icon(Icons.ac_unit_outlined),
                  ),
                ),
                WhiteCard(
                  title: 'access_alarm_outlined',
                  width: 170,
                  child: Center(
                    child: Icon(Icons.access_alarm_outlined),
                  ),
                ),
                WhiteCard(
                  title: 'access_time_filled_outlined',
                  width: 170,
                  child: Center(
                    child: Icon(Icons.access_time_filled_outlined),
                  ),
                ),
                WhiteCard(
                  title: 'accessibility_new_outlined',
                  width: 170,
                  child: Center(
                    child: Icon(Icons.accessibility_new_outlined),
                  ),
                ),
                WhiteCard(
                  title: 'ac_unit_outlined',
                  width: 170,
                  child: Center(
                    child: Icon(Icons.ac_unit_outlined),
                  ),
                ),
                WhiteCard(
                  title: 'access_alarm_outlined',
                  width: 170,
                  child: Center(
                    child: Icon(Icons.access_alarm_outlined),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
