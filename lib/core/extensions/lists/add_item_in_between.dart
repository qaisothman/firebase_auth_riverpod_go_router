extension ListUtils<T> on List<T> {
  List<T> addItemInBetween(T item) => isEmpty
      ? this
      : (fold([], (r, element) => [...r, element, item])..removeLast());
  List<T> update(int elementIndex, T t) {
    final list = <T>[t];

    replaceRange(elementIndex, elementIndex + 1, list);
    return this;
  }
}
