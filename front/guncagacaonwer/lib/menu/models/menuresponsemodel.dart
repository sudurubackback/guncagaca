import 'package:json_annotation/json_annotation.dart';

part 'menuresponsemodel.g.dart';


@JsonSerializable()
class MenuEntity {
  String id;
  int storeId;
  String name;
  int price;
  String img;
  String description;
  String category;
  List<OptionsEntity> optionsEntity;
  String status;

  MenuEntity({
    required this.id,
    required this.storeId,
    required this.name,
    required this.price,
    required this.img,
    required this.description,
    required this.category,
    required this.optionsEntity,
    required this.status,
  });

  factory MenuEntity.fromJson(Map<String, dynamic> json) {
    return MenuEntity(
      id: json['id'],
      storeId: json['storeId'],
      name: json['name'],
      price: json['price'],
      img: json['img'],
      description: json['description'],
      category: json['category'],
      optionsEntity: (json['optionsEntity'] as List)
          .map((i) => OptionsEntity.fromJson(i))
          .toList(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'name': name,
      'price': price,
      'img': img,
      'description': description,
      'category': category,
      'optionsEntity': optionsEntity.map((e) => e.toJson()).toList(),
      'status': status,
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
      detailsOptions: (json['detailsOptions'] as List)
          .map((i) => DetailsOptionEntity.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'optionName': optionName,
      'detailsOptions': detailsOptions.map((e) => e.toJson()).toList(),
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
