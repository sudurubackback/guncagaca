import 'package:flutter/material.dart';

class OrderOption {
  final String optionName;
  final String selectedOption;

  OrderOption({required this.optionName, required this.selectedOption});

  Map<String, dynamic> toJson() => {
    'optionName': optionName,
    'selectedOption': selectedOption,
  };
}