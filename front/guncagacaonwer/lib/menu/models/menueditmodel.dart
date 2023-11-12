import 'dart:convert';

class MenuEditRequest {
  String id;
  String name;
  int price;
  String description;
  String img;
  Category category;
  List<OptionsEntity> optionsList;

  MenuEditRequest({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.img,
    required this.category,
    required this.optionsList,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'img': img,
      'category': category.toShortString(),
      'optionsList': optionsList.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}

enum Category { COFFEE, OTHERS, SMOOTHIE, AID, TEA, DESSERT, DRINK }

extension CategoryExtension on Category {
  String toShortString() {
    return toString().split('.').last;
  }
}

class OptionsEntity {
  String id;
  String optionName;
  List<DetailsOptionEntity> detailsOptions;

  OptionsEntity({
    required this.id,
    required this.optionName,
    required this.detailsOptions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'optionName': optionName,
      'detailsOptions': detailsOptions.map((x) => x.toMap()).toList(),
    };
  }
}

class DetailsOptionEntity {
  String id;
  String detailOptionName;
  int additionalPrice;

  DetailsOptionEntity({
    required this.id,
    required this.detailOptionName,
    required this.additionalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'detailOptionName': detailOptionName,
      'additionalPrice': additionalPrice,
    };
  }
}
