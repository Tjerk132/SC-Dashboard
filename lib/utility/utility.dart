import 'dart:math';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

extension DefaultMap<K, V> on Map<K, V> {
  /// see https://stackoverflow.com/questions/59736337/default-value-in-dart-map
  V getOrElse(K key, V defaultValue) {
    if (this.containsKey(key)) {
      return this[key];
    } else {
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
    K Function(dynamic) getKey,
    T Function(dynamic) getValue,
  }) {
    if (this == null) return const {};

    getKey = getKey ?? (key) => int.tryParse(key as String) as K;
    getValue = getValue ?? (value) => value as T;

    return this.map(
      (key, value) => MapEntry<K, T>(getKey(key), getValue(value)),
    );
  }
}

extension DefaultList<E> on List<E> {
  /// variation of https://stackoverflow.com/questions/59736337/default-value-in-dart-map
  E getOrElse(int key, E defaultValue) {
    if (this.asMap().containsKey(key)) {
      return this[key];
    } else {
      return defaultValue;
    }
  }

  /// variation of https://github.com/dart-lang/sdk/issues/36836
  List<T> castTo<T>({
    T Function(dynamic) getValue,
  }) {
    if (this == null) return const [];

    getValue = getValue ?? (value) => value as T;

    return List<T>.generate(length, (index) => getValue(this[index]));
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
  /// variation of https://stackoverflow.com/questions/54898767/enumerate-or-map-through-a-list-with-index-and-value-in-dart
  Iterable<T> mapIndexed<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }

  /// determines if at least one item in the list satisfies the value of
  /// the given [property].
  /// Usage:
  /// ```dart
  /// List.anyMatch(property: 'hasData');
  /// ```
  /// where 'hasData' is the name of the property
  bool anyMatch({@required String property}) {
    if (this == null) throw new NullThrownError();
    for (E item in this) {
      dynamic oProperty = item.getProperty(property);
      // just one is required to be true to make the outcome true
      if (oProperty) {
        return true;
      }
    }
    return false;
  }

  /// determines if every item in the list satisfies the value of
  /// the given [property].
  /// Usage:
  /// ```dart
  /// List.allMatch(property: 'hasData');
  /// ```
  /// where 'hasData' is the name of the property
  bool allMatch({@required String property}) {
    if (this == null) throw new NullThrownError();
    for (E item in this) {
      dynamic oProperty = item.getProperty(property);
      // just one is required to be false to make the outcome false
      if (!oProperty) {
        return false;
      }
    }
    return true;
  }

  /// determines if no items in the list satisfy the value of
  /// the given [property].
  /// Usage:
  /// ```dart
  /// List.noneMatch(property: 'hasData');
  /// ```
  /// where 'hasData' is the name of the property
  bool noneMatch({@required String property}) {
    if (this == null) throw new NullThrownError();
    for (E item in this) {
      dynamic oProperty = item.getProperty(property);
      // all are required to be false to make the outcome true
      if (oProperty) {
        return false;
      }
    }
    return true;
  }
}

extension ObjectExtension on Object {
  /// creates a json string with all the given items in [properties]
  /// Use this method in the [toString] method and place the object's
  /// properties by their name and value inside.
  /// Example:
  /// ```dart
  /// return allProperties({
  /// 'foo': foo,
  /// 'bar': bar
  /// });
  /// ```
  /// then you can call [getProperty] to get the value of one property
  /// by it's name.
  String allProperties(Map<String, dynamic> properties) {
    StringBuffer buffer = new StringBuffer();

    buffer.write('{');
    properties.forEach((key, value) {
      //json only supports simple types
      if (value is Widget) {
        buffer.write('"$key": "$value"');
      } else {
        buffer.write('"$key": $value');
      }
      if (key != properties.keys.last) buffer.write(',');
    });
    buffer.write('}');

    return buffer.toString();
  }

  /// please make sure you override the toString method and
  /// call the [allProperties] method and insert all the object's
  /// properties so it is possible to retrieve the object's properties.
  //
  /// gets the value of the given [property] if present
  /// throws [TypeError] if the value isn't found
  dynamic getProperty(String property) {
    Map<String, dynamic> properties = json.decode(this.toString());
    dynamic oProperty = properties[property];
    if (oProperty == null)
      throw new TypeError();
    else
      return oProperty;
  }

  Object orElse(Object defaultValue) {
    if (this != null) {
      return this;
    } else
      return defaultValue;
  }
}

extension NextIntWithMin on Random {
  // dart doesn't support function overloading and use of optional
  // unnamed/named is not possible so create different named method
  int intMaxMin(int max, {int min = 1}) => nextInt(max) + min;

  Object nextObject(List<Object> list) => list[nextInt(list.length)];
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

extension StringFormat on DateTime {
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
      String date = toCorrectDigits([this.day, this.month, this.year], endDivider: '-');
      buffer.write('$date ');
    }
    if (withWeekDay) {
      String weekday = toCorrectDigits([this.weekday]);
      buffer.write('$weekday ');
    }
    if (withTime) {
      if (withSeconds) {
        buffer.write(
          toCorrectDigits([this.hour, this.minute, this.second], endDivider: ':'),
        );
      }
      else
        buffer.write(
          toCorrectDigits([this.hour, this.minute], endDivider: ':'),
        );
    }
    if (withMicros || (withMillis && withMicros)) {
      buffer.write(
        toCorrectDigits([this.millisecond, this.microsecond], startDivider: '.'),
      );
    }
    else if (withMillis) {
      buffer.write(
        toCorrectDigits([this.millisecond], startDivider: '.'),
      );
    }
    return buffer.toString();
  }

  String toCorrectDigits(List<int> timeUnits, {String startDivider, String endDivider}) {
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
