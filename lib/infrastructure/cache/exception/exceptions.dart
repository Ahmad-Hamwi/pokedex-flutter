class NotCachedException implements Exception {
  final String? message;

  NotCachedException([this.message]);

  @override
  String toString() {
    return "NotCachedException: $message";
  }
}
