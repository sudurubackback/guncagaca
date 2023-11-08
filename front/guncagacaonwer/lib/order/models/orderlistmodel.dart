import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Order {
  final String id;
  final int memberId;
  final int storeId;
  final int orderPrice;
  final String orderTime;  // 또는 DateTime orderTime;
  final bool takeoutYn;
  final String receiptId;
  final List<Menu> menus;
  bool inProgress; // 추가된 프로퍼티

  Order({
    required this.id,
    required this.memberId,
    required this.storeId,
    required this.orderPrice,
    required this.orderTime,
    required this.takeoutYn,
    required this.receiptId,
    required this.menus,
    this.inProgress = false,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      memberId: json['memberId'],
      storeId: json['storeId'],
      orderPrice: json['orderPrice'],
      orderTime: json['orderTime'],
      takeoutYn: json['takeoutYn'],
      receiptId: json['receiptId'],
      menus: (json['menus'] as List).map((item) => Menu.fromJson(item)).toList(),
    );
  }
}

@JsonSerializable()
class Menu {
  final String menuId;
  final String menuName;
  final int price;
  final int totalPrice;
  final int quantity;
  final String img;
  final String category;
  final List<Option> options;

  Menu({
    required this.menuId,
    required this.menuName,
    required this.price,
    required this.totalPrice,
    required this.quantity,
    required this.img,
    required this.category,
    required this.options,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menuId: json['menuId'],
      menuName: json['menuName'],
      price: json['price'],
      totalPrice: json['totalPrice'],
      quantity: json['quantity'],
      img: json['img'],
      category: json['category'],
      options: (json['options'] as List).map((item) => Option.fromJson(item)).toList(),
    );
  }
}

@JsonSerializable()
class Option {
  final String optionName;
  final String selectedOption;

  Option({
    required this.optionName,
    required this.selectedOption,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      optionName: json['optionName'],
      selectedOption: json['selectedOption'],
    );
  }
}
