import 'package:flutter/material.dart';

class PaymentPopup extends StatelessWidget {
  final Function onConfirm;

  PaymentPopup({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('결제하기'),
      content: Text('결제를 진행하시겠습니까?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('취소'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text('확인'),
        ),
      ],
    );
  }
}
