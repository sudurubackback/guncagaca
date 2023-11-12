// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderlistmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String,
      memberId: json['memberId'] as int,
      storeId: json['storeId'] as int,
      orderPrice: json['orderPrice'] as int,
      orderTime: json['orderTime'] as String,
      takeoutYn: json['takeoutYn'] as bool,
      receiptId: json['receiptId'] as String,
      menus: (json['menus'] as List<dynamic>)
          .map((e) => Menu.fromJson(e as Map<String, dynamic>))
          .toList(),
      inProgress: json['inProgress'] as bool? ?? false,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'storeId': instance.storeId,
      'orderPrice': instance.orderPrice,
      'orderTime': instance.orderTime,
      'takeoutYn': instance.takeoutYn,
      'receiptId': instance.receiptId,
      'menus': instance.menus,
      'inProgress': instance.inProgress,
    };

StoreOrderResponse _$StoreOrderResponseFromJson(Map<String, dynamic> json) =>
    StoreOrderResponse(
      memberId: json['memberId'] as int,
      orderTime: json['orderTime'] as String,
      status: json['status'] as String,
      takeoutYn: json['takeoutYn'] as bool,
      menuList: (json['menuList'] as List<dynamic>)
          .map((e) => Menu.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$StoreOrderResponseToJson(StoreOrderResponse instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'orderTime': instance.orderTime,
      'status': instance.status,
      'takeoutYn': instance.takeoutYn,
      'menuList': instance.menuList,
      'price': instance.price,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      menuId: json['menuId'] as String,
      menuName: json['menuName'] as String,
      price: json['price'] as int,
      totalPrice: json['totalPrice'] as int,
      quantity: json['quantity'] as int,
      img: json['img'] as String,
      category: json['category'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'menuId': instance.menuId,
      'menuName': instance.menuName,
      'price': instance.price,
      'totalPrice': instance.totalPrice,
      'quantity': instance.quantity,
      'img': instance.img,
      'category': instance.category,
      'options': instance.options,
    };

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      optionName: json['optionName'] as String,
      selectedOption: json['selectedOption'] as String,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'optionName': instance.optionName,
      'selectedOption': instance.selectedOption,
    };
