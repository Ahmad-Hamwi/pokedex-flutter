class PageEntity<T> {
  final num pageNumber;
  final num totalPages;
  final List<T> items;

  num? get nextPageNumber => pageNumber == totalPages ? null : pageNumber + 1;

  num? get previousPageNumber => pageNumber == 1 ? null : pageNumber - 1;

  bool get isLastPage => pageNumber == totalPages;

  PageEntity(this.pageNumber, this.totalPages, this.items);
}

extension PageExtensions<T> on PageEntity<T> {
  PageEntity<R> map<R>(R Function(T t) mapper) {
    return PageEntity(
        pageNumber, totalPages, items.map((e) => mapper(e)).toList());
  }
}
