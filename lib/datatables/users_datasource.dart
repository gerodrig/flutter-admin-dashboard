import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/models/User.dart';

class UsersDataSource extends DataTableSource {
  final List<User> users;

  UsersDataSource(this.users);

  @override
  DataRow getRow(int index) {
    final User user = users[index];

    final image = (user.image == null || user.image!.contains('user-default'))
        ? const Image(image: AssetImage('no-image.png'), width: 35, height: 35)
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif',
            image: user.image!,
            width: 35,
            height: 35,
          );

    return DataRow.byIndex(index: index, cells: [
      DataCell(ClipOval(child: image)),
      DataCell(Text(user.name)),
      DataCell(Text(user.email)),
      DataCell(Text(user.uid ?? 'no-id')),
      DataCell(IconButton(
          onPressed: () {
            NavigationService.replaceTo('/dashboard/users/${user.uid}');
          },
          icon: const Icon(Icons.edit_outlined),
          color: Colors.grey)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;
  @override
  int get selectedRowCount => 0;
}
