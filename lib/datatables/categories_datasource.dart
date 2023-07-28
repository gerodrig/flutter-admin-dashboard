import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';

import 'package:admin_dashboard/ui/modals/category_modal.dart';
import 'package:admin_dashboard/models/Category.dart';

class CategoriesDataTableSource extends DataTableSource {
  final List<Category> categories;
  final BuildContext context;

  CategoriesDataTableSource(this.categories, this.context);

  @override
  DataRow getRow(int index) {
    final category = categories[index];

    return DataRow.byIndex(cells: [
      DataCell(Text(category.id)),
      DataCell(Text(category.name)),
      DataCell(Text(category.user.name)),
      DataCell(Row(
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => CategoryModal(
                        category: category,
                      ));
            },
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () {
              final dialog = AlertDialog(
                title: const Text('Are you sure?'),
                content: Text('Category ${category.name} will be deleted'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('No')),
                  TextButton(
                      onPressed: () async {
                        await Provider.of<CategoriesProvider>(context,
                                listen: false)
                            .deleteCategory(category.id);

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Yes, delete',
                          style: TextStyle(color: Colors.red))),
                ],
              );

              showDialog(context: context, builder: (_) => dialog);
            },
            icon: Icon(Icons.delete_outline_outlined,
                color: Colors.red.withOpacity(0.8)),
          ),
        ],
      )),
    ], index: index);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categories.length;
  @override
  int get selectedRowCount => 0;
}
