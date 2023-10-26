import 'package:flutter/material.dart';
import 'package:guncagaca/menu/menu.dart';
import '../models/menu.dart';
import 'menu_card.dart';

class MenuTabWidget extends StatelessWidget {
  final List<Menu> menus;

  MenuTabWidget({Key? key, required this.menus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final CartController cartController = Get.put(CartController());

    return ListView.builder(
      itemCount: menus.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPage()),
            );
          },
          child: ListTile(
            // leading: Icon(menus[index].icon),
            title: Text(menus[index].name),
            trailing: Text('₩${menus[index].price}'),
          ),
        );
      },
    );
  }
}
