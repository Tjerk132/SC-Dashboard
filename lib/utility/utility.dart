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

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }

  void nullCheck() {
    if (this == null || this.isEmpty)
      throw new NullThrownError();
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
}

extension ObjectExtension on Object {
  /// creates a json string with all the given items in [properties]
  String allProperties(Map<String, dynamic> properties) {
    StringBuffer buffer = new StringBuffer();

    buffer.write('{');
    properties.forEach((key, value) {
      //json only supports simple types
      if (value is Widget) {
        buffer.write('"$key": "$value"');
      }
      else {
        buffer.write('"$key": $value');
      }
      if(key != properties.keys.last)
        buffer.write(',');
    });
    buffer.write('}');

    return buffer.toString();
  }

  /// please make sure you override the toString method and
  /// call the [allProperties] method and insert all the properties
  /// the object has by their name and value.
  /// Example:
  /// ```dart
  /// return allProperties({
  /// 'foo': foo,
  /// 'bar': bar
  /// });
  /// ```
  // then it is possible to retrieve the object's properties.
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
