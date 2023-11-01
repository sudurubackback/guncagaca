import 'option.dart';

class MenuOption {
  final String optionName;
  final List<Option> subOptions;

  MenuOption({required this.optionName, required this.subOptions});

  factory MenuOption.fromMap(Map<String, dynamic> map) {
    return MenuOption(
      optionName: map['optionName'],
      subOptions: (map['subOptions'] as List).map((e) => Option.fromMap(e)).toList(),
    );
  }
}