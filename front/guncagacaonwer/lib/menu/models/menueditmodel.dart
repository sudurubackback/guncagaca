import 'package:json_annotation/json_annotation.dart';

part 'menueditmodel.g.dart';

@JsonSerializable()
class MenuEditRequest {
  String id; // 메뉴 id
  String name; // 메뉴 명
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

  factory MenuEditRequest.fromJson(Map<String, dynamic> json) {
    return MenuEditRequest(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      img: json['img'],
      category: convertStringToCategory(json['category']),
      optionsList: List<OptionsEntity>.from(
        json['optionsList'].map((options) => OptionsEntity.fromJson(options)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'img': img,
      'category': category.toString().split('.').last,
      'optionsList': optionsList.map((options) => options.toJson()).toList(),
    };
  }
}

@JsonSerializable()
class OptionsEntity {
  String optionName;
  List<DetailsOptionEntity> detailsOptions;

  OptionsEntity({
    required this.optionName,
    required this.detailsOptions,
  });

  factory OptionsEntity.fromJson(Map<String, dynamic> json) {
    return OptionsEntity(
      optionName: json['optionName'],
      detailsOptions: List<DetailsOptionEntity>.from(
        json['detailsOptions'].map(
              (detailsOptions) => DetailsOptionEntity.fromJson(detailsOptions),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'optionName': optionName,
      'detailsOptions': detailsOptions.map((options) => options.toJson()).toList(),
    };
  }
}

@JsonSerializable()
class DetailsOptionEntity {
  String detailOptionName;
  int additionalPrice;

  DetailsOptionEntity({
    required this.detailOptionName,
    required this.additionalPrice,
  });

  factory DetailsOptionEntity.fromJson(Map<String, dynamic> json) {
    return DetailsOptionEntity(
      detailOptionName: json['detailOptionName'],
      additionalPrice: json['additionalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'detailOptionName': detailOptionName,
      'additionalPrice': additionalPrice,
    };
  }
}

enum Category {
  COFFEE,
  OTHERS,
  SMOOTHIE,
  AID,
  TEA,
  DESSERT,
  DRINK
}

// 카테고리 변환 함수
Category convertStringToCategory(String categoryString) {
  switch (categoryString) {
    case 'COFFEE':
      return Category.COFFEE;
    case 'OTHERS':
      return Category.OTHERS;
    case 'SMOOTHIE':
      return Category.SMOOTHIE;
    case 'AID':
      return Category.AID;
    case 'TEA':
      return Category.TEA;
    case 'DESSERT':
      return Category.DESSERT;
    case 'DRINK':
      return Category.DRINK;
    default:
      throw ArgumentError('Invalid category string: $categoryString');
  }
}