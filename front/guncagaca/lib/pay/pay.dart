import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guncagaca/cart/view/cart_screen.dart';
import 'package:guncagaca/common/layout/default_layout.dart';
import 'package:uuid/uuid.dart';

import '../cart/controller/cart_controller.dart';
import '../common/view/root_tab.dart';
import '../order/models/order.dart';
import '../order/view/order_view.dart';

class PaymentService {

  String androidApplicationId = dotenv.env['ANDROID_APPLICATION_ID']!;
  String iosApplicationId = dotenv.env['IOS_APPLICATION_ID']!;

  void bootpayTest(BuildContext context) {

    Payload payload = getPayload();
    if(kIsWeb) {
      payload.extra?.openType = "iframe";
    }
    bool isPaymentDone = false;

    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: false,
      // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
      onCancel: (String data) {
        print('------- onCancel: $data');
        Get.to(() => DefaultLayout(title: '장바구니', child: CartScreen()));
      },
      onError: (String data) {
        print('------- onError: $data');
        Get.to(() => DefaultLayout(title: '장바구니', child: CartScreen()));
      },
      onClose: () {
        print('------- onClose');
        if (!isPaymentDone) {
          Bootpay().dismiss(context);
          Get.back();
          Get.back();
        } //명시적으로 부트페이 뷰 종료 호출
      },
      onIssued: (String data) {
        print('------- onIssued: $data');
      },
      onConfirm: (String data) {
        print('------- onConfirm: $data');
        /**
            1. 바로 승인하고자 할 때
            return true;
         **/
        /***
            2. 비동기 승인 하고자 할 때
            checkQtyFromServer(data);
            return false;
         ***/
        /***
            3. 서버승인을 하고자 하실 때 (클라이언트 승인 X)
            return false; 후에 서버에서 결제승인 수행
         */
        // checkQtyFromServer(data);
        return true;
      },
      onDone: (String data) {
        print('------- onDone: $data');
        isPaymentDone = true;
        // 주문 완료되면 카트를 비우기
        CartController cartController = Get.find<CartController>();
        cartController.cartItems.clear();

        // OrderView()로 이동
        Get.offAll(() => DefaultLayout(child: RootTab(initialIndex: 0)));
      },
    );
  }

  Payload getPayload() {
    Payload payload = Payload();

    CartController cartController = Get.find<CartController>();
    List<Order> orders = cartController.cartItems;

    List<Item> itemList = orders.map((order) {
      Item item = Item();
      item.name = order.menu.name;
      item.qty = order.quantity.value;
      var uuid = Uuid();
      item.id = uuid.v4();
      item.price = order.menu.initPrice.toDouble(); // initPrice를 double로 변환
      return item;
    }).toList();

    payload.androidApplicationId = androidApplicationId; // android application id
    payload.iosApplicationId = iosApplicationId; // ios application id


    // payload.pg = '';
    // payload.method = '카드';
    // payload.methods = ['card', 'phone', 'vbank', 'bank', 'kakao'];
    payload.orderName = getOrderName(itemList);
    payload.price = cartController.totalPrice.toDouble(); //정기결제시 0 혹은 주석

    payload.orderId = DateTime.now().millisecondsSinceEpoch.toString(); //주문번호, 개발사에서 고유값으로 지정해야함

    // payload.metadata = {
    //   "callbackParam1" : "value12",
    //   "callbackParam2" : "value34",
    //   "callbackParam3" : "value56",
    //   "callbackParam4" : "value78",
    // }; // 전달할 파라미터, 결제 후 되돌려 주는 값
    payload.items = itemList; // 상품정보 배열

    User user = User(); // 구매자 정보
    user.username = "사용자 이름";
    user.email = "dudxo7721@naver.com";
    user.area = "서울";
    user.phone = "010-5911-1911";
    user.addr = '서울시 동작구 상도로 222';

    Extra extra = Extra(); // 결제 옵션
    extra.appScheme = "guncagacaBootpay";
    extra.cardQuota = '1';
    extra.displaySuccessResult = true;
    // extra.openType = 'popup';

    payload.user = user;
    payload.extra = extra;
    return payload;
  }

  String getOrderName(List<Item> itemList) {
    if (itemList.length > 1) {
      return "${itemList[0].name}외 ${itemList.length-1}건";
    }
    return "${itemList[0].name}";
  }
}