import 'package:flutter/material.dart';

class FuelLevel with ChangeNotifier {
  int fuelCount = 0;
  int get GetFuel => fuelCount;

  String FuelCount() {
    return fuelCount.toString();
  }

  void IncreaseFuel() {
    fuelCount++;
    notifyListeners();
  }

  void deleteCount() {
    fuelCount = 0;
    // notifyListeners();
  }
}
