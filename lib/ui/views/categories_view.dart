import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/datatables/categories_datasource.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/buttons/index.dart';
import 'package:provider/provider.dart';

class Categoriesview extends StatefulWidget {
  const Categoriesview({super.key});

  @override
  State<Categoriesview> createState() => _CategoriesviewState();
}

class _CategoriesviewState extends State<Categoriesview> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();

    Provider.of<CategoriesProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categories =
        Provider.of<CategoriesProvider>(context, listen: true).categories;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Text('Categories View', style: CustomLabels.h1),
            const SizedBox(height: 10),
            PaginatedDataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Created by')),
                DataColumn(label: Text('Actions')),
              ],
              source: CategoriesDataTableSource(categories, context),
              header: const Text('Categories Table', maxLines: 2),
              onRowsPerPageChanged: (value) => setState(() {
                _rowsPerPage = value ?? 10;
              }),
              rowsPerPage: _rowsPerPage,
              actions: [
                CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) => const CategoryModal(category: null));
                  },
                  text: 'Create',
                  icon: Icons.add_outlined,
                ),
              ],
            ),
          ],
        ));
  }
}
