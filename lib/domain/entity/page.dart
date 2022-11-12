class Page<T> {
  final num pageNumber;
  final num totalPages;
  final List<T> items;

  num? get nextPageNumber => pageNumber == totalPages ? null : pageNumber + 1;

  num? get previousPageNumber => pageNumber == 1 ? null : pageNumber - 1;

  Page(this.pageNumber, this.totalPages, this.items);
}

extension PageExtensions<T> on Page<T> {
  Page<R> map<R>(R Function(T t) mapper) {
    return Page(pageNumber, totalPages, items.map((e) => mapper(e)).toList());
  }
}
