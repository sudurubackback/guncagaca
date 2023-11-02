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

  Future<void> _selectTime(BuildContext context, TextEditingController controller, TimeOfDay? selectedTime) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        selectedTime = newTime;
        controller.text = newTime.format(context);
      });
    }
  }
  bool isButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft, // 왼쪽 정렬
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 150.0, bottom: 10), // 왼쪽 마진 추가
                  child: Text(
                    "가게 소개",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 800,
                height: 210,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 150),
                child: Row(
                  children: [
                    Text(
                      "영업 시작 시간 : ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, openingTimeController, openingTime);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                        ),
                        width: 80,
                        child: Center(
                          child: TextFormField(
                            enabled: false,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 150),
                child: Row(
                  children: [
                    Text(
                      "영업 종료 시간 : ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, closingTimeController, closingTime);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                        ),
                        width: 80,
                        child: Center(
                          child: TextFormField(
                            enabled: false,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isButtonEnabled = !isButtonEnabled; // 현재 상태의 반대로 전환
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
                      minimumSize: Size(140, 60), // 최소 크기를 원하는 크기로 조절
                      primary: Color(0xFF038527), // 버튼의 배경색 설정
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
      )
    );
  }
}
