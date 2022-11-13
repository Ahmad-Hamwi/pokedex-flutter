class RemoteException implements Exception {
  final String? message;

  RemoteException([this.message]);

  @override
  String toString() {
    return "RemoteException: $message";
  }
}

class ServerException extends RemoteException {}