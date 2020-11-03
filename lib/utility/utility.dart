import 'dart:math';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

extension DefaultMap<K, V> on Map<K, V> {
  V getOrElse(K key, V defaultValue) {
    if (this.containsKey(key)) {
      return this[key];
    } else {
      return defaultValue;
    }
  }
}

extension DefaultList<E> on List<E> {
  E getOrElse(int key, E defaultValue) {
    if (this.asMap().containsKey(key)) {
      return this[key];
    } else {
      return defaultValue;
    }
  }
}

extension DefaultNumberList<double> on List<double> {
  double get highest => this.reduce(
          (current, next) => (current as num) > (next as num) ? current : next);

  double get lowest => this.reduce(
          (current, next) => (current as num) < (next as num) ? current : next);
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }

  void nullCheck() {
    if (this == null || this.isEmpty) throw new NullThrownError();
  }

  /// determines if at least one item in the list satisfies the value of
  /// the given [property].
  /// Usage:
  /// ```dart
  /// List.anyMatch(property: 'hasData');
  /// ```
  /// where 'hasData' is the name of the property
  bool anyMatch({@required String property}) {
    this.nullCheck();
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
    this.nullCheck();
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
    this.nullCheck();
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
}

extension NextIntWithMin on Random {
  // dart doesn't support function overloading and use of optional
  // unnamed/named is not possible so create different named method
  int intMaxMin(int max, {int min = 1}) => nextInt(max) + min;
}

class JsonColor extends Color {
  JsonColor._(int value) : super(value);

  factory JsonColor(String colorString) {
    final String valueString = colorString.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return JsonColor._(value);
  }
}

extension NumExtension on num {
  int roundToFactor(int factor) {
    // Smaller multiple
    int a = (this ~/ factor) * factor;
    // Larger multiple
    int b = a + factor;
    // Return of closest of two
    return (this - a > b - this) ? b : a;
  }
}
