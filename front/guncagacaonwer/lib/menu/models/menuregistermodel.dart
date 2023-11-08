import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MenuRegisterRequest {
  final int cafeId;
  final String name;
  final int price;
  final String description;
  final Category category;
  final List<OptionsEntity> optionsList;
  final Status status;

  MenuRegisterRequest({
    required this.cafeId,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.optionsList,
    required this.status,
  });

  factory MenuRegisterRequest.fromJson(Map<String, dynamic> json) {
    return MenuRegisterRequest(
      cafeId: json['cafeId'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      category: Category.values[json['category'] as int],
      optionsList: (json['optionsList'] as List).map((i) => OptionsEntity.fromJson(i)).toList(),
      status: Status.values[json['status'] as int],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cafeId': cafeId,
      'name': name,
      'price': price,
      'description': description,
      'category': category.index,
      'optionsList': optionsList.map((option) => option.toJson()).toList(),
      'status' : status.index,
    };
  }
}

@JsonSerializable()
class OptionsEntity {
  late final String optionName;
  final List<DetailsOptionEntity> detailsOptions;

  OptionsEntity({
    required this.optionName,
    required this.detailsOptions});

  factory OptionsEntity.fromJson(Map<String, dynamic> json) {
    return OptionsEntity(
      optionName: json['optionName'] as String,
      detailsOptions: (json['detailsOptions'] as List).map((i) => DetailsOptionEntity.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'optionName': optionName,
      'detailsOptions': detailsOptions.map((option) => option.toJson()).toList(),
    };
  }
}

@JsonSerializable()
class DetailsOptionEntity {
  final String detailOptionName;
  late final int additionalPrice;

  DetailsOptionEntity({
    required this.detailOptionName,
    required this.additionalPrice});

  factory DetailsOptionEntity.fromJson(Map<String, dynamic> json) {
    return DetailsOptionEntity(
      detailOptionName: json['detailOptionName'] as String,
      additionalPrice: json['additionalPrice'] as int,
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
  COFFEE, OTHERS, SMOOTHIE, AID, TEA, DESSERT, DRINK
}

enum Status {
  ON_SALE, SOLD_OUT
}
