import 'package:flutter/material.dart';
import 'package:guncagaca/menu/menu_detail.dart';
import 'package:guncagaca/menu/menu_card.dart';
import '../../common/layout/default_layout.dart';
import '../../menu/menu.dart';

class MenuTabWidget extends StatelessWidget {
  final List<Menu> menus;
  final String storeName;

  MenuTabWidget({Key? key, required this.menus, required this.storeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: menus.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DefaultLayout(
                    title: storeName,
                    child: DetailPage(menu: menus[index])),
              ),
            );
          },
          child: MenuCard(menu: menus[index],
          ),
        );
      },
    );
  }
}
