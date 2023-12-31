import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:guncagaca/order/models/order_option.dart';


// 장바구니 담길 메뉴
class OrderMenu {
  final int storeId;
  final String menuId;
  final String name;
  final int totalPrice;
  final int initPrice;
  final String img;
  final String storeName;
  final String category;
  final List<OrderOption>? selectedOptions; // 선택된 옵션들
  RxInt quantity = 1.obs;

  OrderMenu({
    required this.storeId,
    required this.menuId,
    required this.name,
    required this.totalPrice,
    required this.img,
    required this.initPrice,
    required this.category,
    required this.storeName,
    required this.selectedOptions,
  });

  factory OrderMenu.fromJson(Map<String, dynamic> json) {
    var orderMenu = OrderMenu(
      storeId: json['storeId'],
      menuId: json['menuId'],
      name: json['menuName'],
      totalPrice: json['totalPrice'],
      initPrice: json['price'],
      img: json['img'],
      category: json['category'],
      selectedOptions: (json['options'] as List?)?.map((item) => OrderOption.fromJson(item)).toList(),
      storeName: '',
    );

    orderMenu.quantity.value = json['quantity'];
    return orderMenu;
  }

  Map<String, dynamic> toJson() => {
    'storeId': storeId,
    'menuId': menuId,
    'menuName': name,
    'price': initPrice,
    'totalPrice': totalPrice,
    'quantity': quantity.value,
    'img': img,
    'category': category,
    'options': selectedOptions?.map((orderOption) => orderOption.toJson()).toList(),
  };

  Map<String, dynamic> toModel() => {
    'menuId': menuId,
    'menuName': name,
    'price': initPrice,
    'totalPrice': totalPrice,
    'img': img,
    'category': category,
    'storeName': storeName,
    'options': selectedOptions?.map((option) => option.toModel()).toList(),
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderMenu &&
      other.name == name &&
        _areOptionListsEqual(other.selectedOptions, selectedOptions);
  }

  bool _areOptionListsEqual(List<OrderOption>? list1, List<OrderOption>? list2) {
    if (list1 == null && list2 == null) return true;
    if (list1 == null || list2 == null) return false;

    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => name.hashCode ^ selectedOptions.hashCode;
}
