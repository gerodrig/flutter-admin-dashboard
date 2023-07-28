import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/models/Category.dart';

import 'package:admin_dashboard/ui/buttons/index.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';

class CategoryModal extends StatefulWidget {
  final Category? category;

  const CategoryModal({super.key, this.category});

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  String name = '';
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.category?.id;
    name = widget.category?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<CategoriesProvider>(context, listen: false);

    return Container(
        padding: const EdgeInsets.all(20),
        height: 500,
        width: 300,
        decoration: buildBoxDecoration(),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.category?.name ?? 'New Category',
                  style: CustomLabels.h1.copyWith(color: Colors.white)),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.white))
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.3)),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: widget.category?.name ?? '',
            onChanged: (value) => name = value,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Category Name',
                label: 'Category',
                icon: Icons.new_releases_outlined),
            style: const TextStyle(color: Colors.white),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                try {
                  if (id == null) {
                    // Create
                    await categoryProvider.newCategory(name);
                    NotificationService.showSnackbarSuccess(
                        'Category created successfully');
                  } else {
                    await categoryProvider.updateCategory(id!, name);
                    NotificationService.showSnackbarSuccess(
                        'Category updated successfully');
                    // Update
                  }
                } catch (e) {
                  return NotificationService.showSnackbarError(e.toString());
                }

                //close modal
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              text: 'Save',
              color: Colors.white,
              isTextWhite: true,
            ),
          )
        ]));
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xff0F2041),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
            )
          ]);
}
