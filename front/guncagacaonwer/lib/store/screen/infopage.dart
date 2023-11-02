import 'package:flutter/material.dart';

class StoreInfoPage extends StatefulWidget {
  @override
  _StoreInfoPageState createState() => _StoreInfoPageState();
}

class _StoreInfoPageState extends State<StoreInfoPage> {
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;

  TextEditingController openingTimeController = TextEditingController();
  TextEditingController closingTimeController = TextEditingController();

  Future<void> _selectTime(BuildContext context, TextEditingController controller, TimeOfDay? selectedTime, bool isOpeningTime) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        if (isOpeningTime) {
          openingTime = newTime; // 영업 시작 시간 업데이트
          controller.text = newTime.format(context);
        } else {
          closingTime = newTime; // 영업 종료 시간 업데이트
          controller.text = newTime.format(context);
        }
      });
    }
  }

  bool isButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 50 * (deviceWidth / standardDeviceWidth),
                    bottom: 10),
                  child: Text(
                    "가게 소개",
                    style: TextStyle(
                      fontSize: 12 * (deviceWidth / standardDeviceWidth),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 350 * (deviceWidth / standardDeviceWidth),
                height: 100 * (deviceHeight / standardDeviceHeight),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 5 * (deviceHeight / standardDeviceHeight)),
              Padding(
                padding: EdgeInsets.only(left: 50 * (deviceWidth / standardDeviceWidth)),
                child: Row(
                  children: [
                    Text(
                      "영업 시작 시간 : ",
                      style: TextStyle(
                        fontSize: 9 * (deviceWidth / standardDeviceWidth),
                      ),
                    ),
                    SizedBox(width: 13 * (deviceWidth / standardDeviceWidth)),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, openingTimeController, openingTime, true);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                        ),
                        width: 40 * (deviceWidth / standardDeviceWidth),
                        child: Center(
                          child: TextFormField(
                            enabled: false,
                            controller: openingTimeController,
                            decoration: InputDecoration(
                              hintText: openingTime != null ? openingTime!.format(context) : '선택',
                            ),
                            style: TextStyle(
                              color: Colors.black, // 텍스트 색상 설정
                              fontSize: 9 * (deviceWidth / standardDeviceWidth), // 텍스트 크기 설정
                              // 다른 텍스트 스타일 속성도 지정 가능
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7 * (deviceHeight / standardDeviceHeight)),
              Padding(
                padding: EdgeInsets.only(left: 50 * (deviceWidth / standardDeviceWidth)),
                child: Row(
                  children: [
                    Text(
                      "영업 종료 시간 : ",
                      style: TextStyle(
                        fontSize: 9 * (deviceWidth / standardDeviceWidth),
                      ),
                    ),
                    SizedBox(width: 13 * (deviceWidth / standardDeviceWidth)),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, closingTimeController, closingTime, false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                        ),
                        width: 40 * (deviceWidth / standardDeviceWidth),
                        child: Center(
                          child: TextFormField(
                            enabled: false,
                            controller: closingTimeController,
                            decoration: InputDecoration(
                              hintText: closingTime != null ? closingTime!.format(context) : '선택',
                            ),
                            style: TextStyle(
                              color: Colors.black, // 텍스트 색상 설정
                              fontSize: 9 * (deviceWidth / standardDeviceWidth), // 텍스트 크기 설정
                              // 다른 텍스트 스타일 속성도 지정 가능
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7 * (deviceHeight / standardDeviceHeight)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isButtonEnabled = !isButtonEnabled;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: isButtonEnabled ? Color(0xFFFF5E5E) : Colors.grey,
                      minimumSize: Size(140, 60),
                    ),
                    child: Text(
                      "영업 중",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 버튼 클릭 시 수행할 동작 추가
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(140, 60),
                      primary: Color(0xFF038527),
                    ),
                    child: Text(
                      "수정",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
