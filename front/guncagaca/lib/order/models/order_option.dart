
class OrderOption {
  final String optionName;
  final String selectedOption;

  OrderOption({required this.optionName, required this.selectedOption});

  Map<String, dynamic> toJson() => {
    'optionName': optionName,
    'selectedOption': selectedOption,
  };

  factory OrderOption.fromJson(Map<String, dynamic> json) {
    return OrderOption(
      optionName: json['optionName'],
      selectedOption: json['selectedOption'],
    );
  }

  Map<String, dynamic> toModel() => {
    'optionName': optionName,
    'selectedOption': selectedOption,
  };
}