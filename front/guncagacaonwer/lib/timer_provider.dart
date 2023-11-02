import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerModel extends ChangeNotifier {
  int initialTime = 20;
  int currentTime = 20;
  double progressValue = 1.0;
  bool inProgress = false;

  void startTimer() {
    if (!inProgress) {
      inProgress = true;
      Timer.periodic(Duration(minutes: 1), (Timer timer) {
        if (currentTime > 0) {
          currentTime--;
          progressValue = currentTime / initialTime;
        } else {
          timer.cancel();
          inProgress = false;
          // Handle your logic here when the timer ends
        }
        notifyListeners(); // Notify listeners when the timer state changes
      });
    }
  }
}
