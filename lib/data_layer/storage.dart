import 'dart:async';

class Storage<T> {
  final StreamController<List<T>> _items = StreamController.broadcast();

  Stream<List<T>> get items => _items.stream;

  List<T> currentValue = [];

  void add(T item) {
    currentValue = [...currentValue, item];
    _items.add(currentValue);
  }
}
