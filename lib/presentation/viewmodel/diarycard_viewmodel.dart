import 'package:flutter/material.dart';

class DiaryCardViewModel extends ChangeNotifier {

  void toggleFactors(List<String> factors, String item) {
    if (factors.contains(item)) {
      factors.remove(item);
    } else {
      factors.add(item);
    }
    notifyListeners();
  }

}