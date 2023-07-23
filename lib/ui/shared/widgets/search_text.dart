import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';

class SearchText extends StatelessWidget {
  const SearchText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: buildBoxDecoration(),
      child: TextField(
          decoration: CustomInputs.searchInputDecoration(
              hint: 'Search', icon: Icons.search_outlined)),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        // boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)]
      );
}
