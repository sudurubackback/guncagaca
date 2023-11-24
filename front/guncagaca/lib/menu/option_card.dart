import 'package:flutter/material.dart';

import '../common/const/colors.dart';
import 'option.dart';

class OptionCard extends StatelessWidget {
  final Option option;
  final bool isSelected;
  final VoidCallback onTap;

  OptionCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: PRIMARY_COLOR,
                width: 2.0,
              ),
              color: isSelected ? PRIMARY_COLOR : Colors.white,
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      option.label,
                      style: TextStyle(
                        color: isSelected ? PRIMARY_COLOR : Colors.black,
                        fontSize: 13.0,
                      ),
                    ),
                    Text(
                      '+ ${option.price}원',
                      style: TextStyle(
                        color: isSelected ? PRIMARY_COLOR : Colors.black,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}