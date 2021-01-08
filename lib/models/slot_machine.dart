import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_test_project/utility/utility.dart';

class SlotMachine {
  SlotMachine({this.perIndexMillis = 100}) {
    r = new Random();
  }

  int perIndexMillis;

  Random r;

  /// set the minimal and maximal index the slotMachine slot can animate to, to calculate the
  /// duration of the animation in [calculateDurationMillis]
  SlotMachineSpin calculateSpin(int currentIndex, int itemLength,
      {curve = Curves.easeOutSine}) {
    // skip index 0 & 1
    int minIndex = 2;
    // e.g if 99 is the last index then the length is 100, and maxIndex is 100 - 3 = 97
    // so skip last 2 indexes
    int maxIndex = itemLength - 3;

    int toIndex = r.nextInt(itemLength - 1);

    if (toIndex < minIndex) toIndex = minIndex;

    if (toIndex > maxIndex) toIndex = maxIndex;

    int durationMillis = calculateDurationMillis(currentIndex, toIndex);

    return new SlotMachineSpin(
        toIndex: toIndex, duration: durationMillis, curve: curve);
  }

  /// calculate the duration (in milliseconds) in which the slotMachine slot has animate to [toIndex]
  int calculateDurationMillis(int currentIndex, int toIndex) {
    int durationMillis = 0;
    if (currentIndex >= toIndex) {
      durationMillis = currentIndex - toIndex;
    } else
      durationMillis = toIndex - currentIndex;

    if (durationMillis.isNegative) {
      durationMillis *= -1;
    }
    durationMillis *= perIndexMillis;

    return durationMillis;
  }

  /// generate [count] numbers for the slotMachine slot
  //
  /// foreach item [i] a number is created with a value
  /// between the values given to method [intMaxMin]
  /// to the power of the outcome of [multiplyByRandomPower]
  List<int> generateNumbers(int count) {
    return new List.generate(
        count, (i) => multiplyByRandomPower(r.nextInt(9) + 1, 5));
  }

  /// return the given [number] to the power of a random wih max [maxPower]
  multiplyByRandomPower(int number, int maxPower) {
    int tenthFactor = r.nextInt(maxPower) + 1;
    return pow(10, tenthFactor) * number;
  }
}

class SlotMachineSpin {
  int toIndex;
  Duration duration;
  Curve curve;

  SlotMachineSpin({
    @required this.toIndex,
    @required int duration,
    @required this.curve,
  }) {
    this.duration = new Duration(milliseconds: duration);
  }
}
