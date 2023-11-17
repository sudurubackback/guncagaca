import 'menu_option.dart';

class Menu {
  final int storeId;
  final String menuId;
  final String name;
  final int initPrice;
  final List<MenuOption> options;
  final String imagePath;
  final String description;
  final String status;
  final String category;

  Menu({
    required this.storeId,
    required this.menuId,
    required this.name,
    required this.initPrice,
    required this.options,
    required this.imagePath,
    required this.description,
    required this.category,
    required this.status,
  });

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      storeId: map['storeId'],
      menuId: map['id'],
      name: map['name'],
      initPrice: map['price'],
      imagePath: map['img'],
      description: map['description'],
      category: map['category'],
      status: map['status'],
      options: (map['optionsEntity'] as List).map((e) => MenuOption.fromMap(e)).toList(),
    );
  }
}