import 'package:flutter/material.dart';
import 'package:guncagaca/common/const/colors.dart';

import 'menu_option.dart';
import 'option.dart';
import 'option_card.dart';

class OptionList extends StatefulWidget {
  final MenuOption menuOption;
  final Function(int, int) onOptionSelected;

  OptionList({
    required this.menuOption,
    required this.onOptionSelected,
  });

  @override
  _OptionListState createState() => _OptionListState();

}

class _OptionListState extends State<OptionList> {
  int selectedIndex = -1;

  int getSelectedOptionPrice() {
    if (selectedIndex == -1) return -1;
    return widget.menuOption.subOptions[selectedIndex].price;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.menuOption.optionName),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          ...widget.menuOption.subOptions.asMap().entries.map((entry) {
            int optionIndex = entry.key;
            Option option = entry.value;

            return Column(
              children: [
                OptionCard(
                  option: option,
                  isSelected: selectedIndex == optionIndex,
                  onTap: () {
                    setState(() {
                      // 이미 선택된 옵션을 다시 선택한 경우, 미선택 상태로 변경
                      if (selectedIndex == optionIndex) {
                        selectedIndex = -1;
                        widget.onOptionSelected(-1, -1);  // 미선택 상태로 설정
                      } else {
                        selectedIndex = optionIndex;
                        widget.onOptionSelected(optionIndex, getSelectedOptionPrice());
                      }
                    });
                  },
                ),
                if (optionIndex != widget.menuOption.subOptions.length - 1)
                  SizedBox(height: 10.0),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}

