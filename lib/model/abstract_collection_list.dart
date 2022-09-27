abstract class AbstractOption {
  String optionId;
  String value;

  AbstractOption({this.optionId, this.value});

  AbstractOption.name(this.optionId, this.value);

  bool isEqual(AbstractOption option) {
    return optionId == option.optionId;
  }
}

abstract class AbstractCollectionList {
  List<AbstractOption> _collection = [];

  bool isEmpty() => _collection != null ? _collection.isEmpty : true;

  bool isNotEmpty() => !isEmpty();

  bool exists(AbstractOption element) {
    if (isEmpty()) {
      return false;
    }

    for (AbstractOption option in _collection) {
      if (option is! AbstractOption) {}
      if (option.isEqual(element)) {
        return true;
      }
    }
    return false;
  }

  int length() => isEmpty() ? 0 : _collection.length;

  bool containsKey(int index) => _collection.asMap().containsKey(index);

  List<AbstractOption> toList() => _collection;

  AbstractOption elementAt(int index) => _collection.elementAt(index);

  add(AbstractOption element) {
    _collection ??= [];
    if (!exists(element)) {
      _collection.add(element);
    }
  }

  remove(AbstractOption element) {
    if (!exists(element)) {
      return;
    }
    _collection.remove(element);
  }

  removeAt(int index) {
    if (_collection == null) {
      return;
    }
    if (isEmpty()) {
      return;
    }
    if (!containsKey(index)) {
      return;
    }
    _collection.removeAt(index);
  }
}
