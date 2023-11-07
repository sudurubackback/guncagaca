import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Order {
  final String id;
  final int memberId;
  final int storeId;
  final String receiptId;
  final String orderTime;  // 또는 DateTime orderTime;
  final String status;
  final bool takeoutYn;
  final bool reviewYn;
  final List<Menu> menus;
  final int price;
  bool inProgress; // 추가된 프로퍼티

  Order({
    required this.id,
    required this.memberId,
    required this.storeId,
    required this.receiptId,
    required this.orderTime,
    required this.status,
    required this.takeoutYn,
    required this.reviewYn,
    required this.menus,
    required this.price,
    this.inProgress = false,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      memberId: json['memberId'],
      storeId: json['storeId'],
      receiptId: json['receiptId'],
      orderTime: json['orderTime'],
      status: json['status'],
      takeoutYn: json['takeoutYn'],
      reviewYn: json['reviewYn'],
      menus: (json['menus'] as List).map((item) => Menu.fromJson(item)).toList(),
      price: json['price'],
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
