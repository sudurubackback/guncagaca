// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menuresponsemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuEntity _$MenuEntityFromJson(Map<String, dynamic> json) => MenuEntity(
      id: json['id'] as String,
      storeId: json['storeId'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      img: json['img'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      optionsEntity: (json['optionsEntity'] as List<dynamic>)
          .map((e) => OptionsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$MenuEntityToJson(MenuEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeId': instance.storeId,
      'name': instance.name,
      'price': instance.price,
      'img': instance.img,
      'description': instance.description,
      'category': instance.category,
      'optionsEntity': instance.optionsEntity,
      'status': instance.status,
    };

OptionsEntity _$OptionsEntityFromJson(Map<String, dynamic> json) =>
    OptionsEntity(
      optionName: json['optionName'] as String,
      detailsOptions: (json['detailsOptions'] as List<dynamic>)
          .map((e) => DetailsOptionEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OptionsEntityToJson(OptionsEntity instance) =>
    <String, dynamic>{
      'optionName': instance.optionName,
      'detailsOptions': instance.detailsOptions,
    };

DetailsOptionEntity _$DetailsOptionEntityFromJson(Map<String, dynamic> json) =>
    DetailsOptionEntity(
      detailOptionName: json['detailOptionName'] as String,
      additionalPrice: json['additionalPrice'] as int,
    );

Map<String, dynamic> _$DetailsOptionEntityToJson(
        DetailsOptionEntity instance) =>
    <String, dynamic>{
      'detailOptionName': instance.detailOptionName,
      'additionalPrice': instance.additionalPrice,
    };
