import 'package:pokedex/infrastructure/remote/exception/remote_exceptions.dart';

import '../const/api_endpoints.dart';

abstract class IRemoteExceptionFactory {
  Exception create(int code);
}

class ResponseCodeExceptionFactory implements IRemoteExceptionFactory {
  @override
  Exception create(int code) {
    switch (code) {
      case ResponseCode.serverException:
        return ServerException();
      default:
        throw UnimplementedError("Response code not implemented");
    }
  }
}
