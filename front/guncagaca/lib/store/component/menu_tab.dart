import 'package:flutter/material.dart';

import '../models/menu.dart';

class MenuTabWidget extends StatelessWidget {
  final List<Menu> menus;

  const MenuTabWidget({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: menus.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(menus[index].icon),
          title: Text(menus[index].name),
          trailing: Text('₩${menus[index].price}'),
        );
      },
    );
  }
}
