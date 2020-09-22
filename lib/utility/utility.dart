import 'dart:math';

extension DefaultMap<K,V> on Map<K,V> {
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
}

extension NextIntWithMin on Random {
  // dart doesn't support function overloading and use of optional
  // unnamed/named is not possible so create different named method
  int intMaxMin(int max, {int min = 1}) => nextInt(max) + min;
}


