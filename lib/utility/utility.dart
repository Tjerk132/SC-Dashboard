import 'dart:math';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

extension DefaultMap<K, V> on Map<K, V> {
  /// see https://stackoverflow.com/questions/59736337/default-value-in-dart-map
  V getOrElse(K key, V defaultValue) {
    if (this.containsKey(key)) {
      return this[key]!;
    }
    else {
      return defaultValue;
    }
  }

  /// cast the json map to a map of given [K] and [T]
  ///
  /// Note that by default the key will be casted to
  /// [int] and the value to the type of [T].
  /// You can change this behaviour by supplying the
  /// functions [getKey] and [getValue]
  //  see: https://github.com/dart-lang/sdk/issues/36836
  Map<K, T> castTo<K, T>({
    K Function(dynamic)? getKey,
    T Function(dynamic)? getValue,
  }) {
    getKey ??= (key) => int.tryParse(key as String) as K;
    getValue ??= (value) => value as T;

    return this.map(
      (key, value) => MapEntry<K, T>(getKey!(key), getValue!(value)),
    );
  }
}

extension DefaultList<E> on List<E> {
  /// variation of https://stackoverflow.com/questions/59736337/default-value-in-dart-map
  E getOrElse(int key, E defaultValue) {
    if (this.asMap().containsKey(key)) {
      return this[key];
    }
    else {
      return defaultValue;
    }
  }

  /// variation of https://github.com/dart-lang/sdk/issues/36836
  List<T> castTo<T>({
    T Function(dynamic)? getValue,
  }) {
    getValue ??= (value) => value as T;

    return List<T>.generate(length, (index) => getValue!(this[index]));
  }
}

/// see https://stackoverflow.com/questions/20490868/dart-list-min-max-value
extension DefaultNumberList<double> on List<double> {
  double get highest => this.reduce(
      (current, next) => (current as num) > (next as num) ? current : next);

  double get lowest => this.reduce(
      (current, next) => (current as num) < (next as num) ? current : next);
}

extension IndexedIterable<E> on Iterable<E> {
  /// Variation of https://stackoverflow.com/questions/54898767/enumerate-or-map-through-a-list-with-index-and-value-in-dart
  Iterable<T> mapIndexed<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }

  /// Determines if any element in the list satisfies the given [match] condition.
  bool anyMatch(bool match(E element)) {
    for (E element in this) {
      if(match(element)) {
        return true;
      }
    }
    return false;
  }

  /// Determines if every element in the list satisfies the given [match] condition.
  bool allMatch(bool match(E element)) {
    for (E element in this) {
      if(!match(element)) {
        return false;
      }
    }
    return true;
  }

  /// Determines if not a single element in the list satisfies the given [match] condition.
  bool noneMatch(bool match(E element)) {
    for (E element in this) {
      if(match(element)) {
        return false;
      }
    }
    return true;
  }
}

extension RandomExtension on Random {
  T nextObject<T>(List<T> list) => list[nextInt(list.length)];
}

/// see https://stackoverflow.com/questions/50081213/how-do-i-use-hexadecimal-color-strings-in-flutter
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');

    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension NumExtension on num {
  // see https://www.geeksforgeeks.org/round-the-given-number-to-nearest-multiple-of-10/
  int roundToFactor(int factor) {
    // Smaller multiple
    int a = (this ~/ factor) * factor;
    // Larger multiple
    int b = a + factor;
    // Return of closest of two
    return (this - a > b - this) ? b : a;
  }
}

// workaround for package intl, only usable for UTC
extension DateTimeExtension on DateTime {
  String formatToString({
    bool withDate = false,
    bool withWeekDay = false,
    bool withTime = true,
    bool withSeconds = true,
    bool withMillis = false,
    bool withMicros = false,
  }) {
    StringBuffer buffer = StringBuffer();
    if (withDate) {
      String date = writeAsUnit([this.day, this.month, this.year], endDivider: '-');
      buffer.write('$date ');
    }
    if (withWeekDay) {
      String weekday = writeAsUnit([this.weekday]);
      buffer.write('$weekday ');
    }
    if (withTime) {
      if (withSeconds) {
        buffer.write(
          writeAsUnit([this.hour, this.minute, this.second], endDivider: ':'),
        );
      }
      else
        buffer.write(
          writeAsUnit([this.hour, this.minute], endDivider: ':'),
        );
    }
    if (withMicros || (withMillis && withMicros)) {
      buffer.write(
        writeAsUnit([this.millisecond, this.microsecond], startDivider: '.'),
      );
    }
    else if (withMillis) {
      buffer.write(
        writeAsUnit([this.millisecond], startDivider: '.'),
      );
    }
    return buffer.toString();
  }

  String writeAsUnit(List<int> timeUnits, {String? startDivider, String? endDivider}) {
    StringBuffer buffer = StringBuffer();
    for (int timeUnit in timeUnits) {
      if(startDivider != null) {
        buffer.write(startDivider);
      }
      buffer.write('${timeUnit < 10 ? '0$timeUnit' : timeUnit}');
      if (timeUnit != timeUnits.last && endDivider != null) {
        buffer.write(endDivider);
      }
    }
    return buffer.toString();
  }
}
