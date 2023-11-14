// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menuregistermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuRegisterRequest _$MenuRegisterRequestFromJson(Map<String, dynamic> json) =>
    MenuRegisterRequest(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      img: json['img'] as String,
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      optionsList: (json['optionsList'] as List<dynamic>)
          .map((e) => OptionsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecode(_$StatusEnumMap, json['status']),
    );

Map<String, dynamic> _$MenuRegisterRequestToJson(
        MenuRegisterRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'img': instance.img,
      'category': _$CategoryEnumMap[instance.category]!,
      'optionsList': instance.optionsList,
      'status': _$StatusEnumMap[instance.status]!,
    };

const _$CategoryEnumMap = {
  Category.COFFEE: 'COFFEE',
  Category.OTHERS: 'OTHERS',
  Category.SMOOTHIE: 'SMOOTHIE',
  Category.AID: 'AID',
  Category.TEA: 'TEA',
  Category.DESSERT: 'DESSERT',
  Category.DRINK: 'DRINK',
};

const _$StatusEnumMap = {
  Status.ON_SALE: 'ON_SALE',
  Status.SOLD_OUT: 'SOLD_OUT',
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
