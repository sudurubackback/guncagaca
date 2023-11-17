// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menueditmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuEditRequest _$MenuEditRequestFromJson(Map<String, dynamic> json) =>
    MenuEditRequest(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      img: json['img'] as String,
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      optionsList: (json['optionsList'] as List<dynamic>)
          .map((e) => OptionsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuEditRequestToJson(MenuEditRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'img': instance.img,
      'category': _$CategoryEnumMap[instance.category]!,
      'optionsList': instance.optionsList,
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
