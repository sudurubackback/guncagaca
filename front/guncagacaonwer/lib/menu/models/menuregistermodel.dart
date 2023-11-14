import 'package:json_annotation/json_annotation.dart';

part 'menuregistermodel.g.dart';

@JsonSerializable()
class MenuRegisterRequest {
  final int cafeId;
  final String name;
  final String description;
  final int price;
  final String img;
  final Category category;
  final List<OptionsEntity> optionsList;
  final Status status;

  MenuRegisterRequest({
    required this.cafeId,
    required this.name,
    required this.description,
    required this.price,
    required this.img,
    required this.category,
    required this.optionsList,
    required this.status,
  });

  factory MenuRegisterRequest.fromJson(Map<String, dynamic> json) {
    return MenuRegisterRequest(
      cafeId: json['cafeId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      img: json['img'] as String,
      category: convertStringToCategory(json['category']),
      optionsList: List<OptionsEntity>.from(
        json['optionsList'].map((options) => OptionsEntity.fromJson(options))),
      status: Status.values[json['status'] as int],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cafeId': cafeId,
      'name': name,
      'price': price,
      'description': description,
      'category': category.toString().split('.').last,
      'optionsList': optionsList.map((options) => options.toJson()).toList(),
      'status' : status.index,
    };
  }
}

@JsonSerializable()
class OptionsEntity {
  String optionName;
  final List<DetailsOptionEntity> detailsOptions;

  OptionsEntity({
    required this.optionName,
    required this.detailsOptions});

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

enum Status {
  ON_SALE, SOLD_OUT
}
