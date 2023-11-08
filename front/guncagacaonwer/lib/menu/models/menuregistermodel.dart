import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MenuRegisterRequest {
  final Long cafeId;
  final String name;
  final int price;
  final String description;
  final Category category;
  final List<OptionsEntity> optionsList;

  MenuRegisterRequest({
    required this.cafeId,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.optionsList});

  factory MenuRegisterRequest.fromJson(Map<String, dynamic> json) {
    return MenuRegisterRequest(
      cafeId: json['cafeId'] as Long,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      category: Category.values[json['category'] as int],
      optionsList: (json['optionsList'] as List).map((i) => OptionsEntity.fromJson(i)).toList(),
    );
  }
}

@JsonSerializable()
class OptionsEntity {
  final String optionName;
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
}

@JsonSerializable()
class DetailsOptionEntity {
  final String detailOptionName;
  final int additionalPrice;

  DetailsOptionEntity({
    required this.detailOptionName,
    required this.additionalPrice});

  factory DetailsOptionEntity.fromJson(Map<String, dynamic> json) {
    return DetailsOptionEntity(
      detailOptionName: json['detailOptionName'] as String,
      additionalPrice: json['additionalPrice'] as int,
    );
  }
}

enum Category {
  COFFEE, OTHERS, SMOOTHIE, AID, TEA, DESSERT, DRINK
}
