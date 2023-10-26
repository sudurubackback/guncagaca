import 'package:flutter/material.dart';

import 'menu_option.dart';

class Menu {
  final String name;
  final int initPrice;
  final List<MenuOption> options;
  final String imagePath;
  final String description;

  Menu({
    required this.name,
    required this.initPrice,
    required this.options,
    required this.imagePath,
    required this.description,
  });
}