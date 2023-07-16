import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:pokedex/infrastructure/remote/exception/exception_factory.dart';

@GenerateNiceMocks([
  MockSpec<Dio>(),
  MockSpec<DioError>(),
  MockSpec<Response>(),
  MockSpec<IRemoteExceptionFactory>(),
])
class _RemoteMocksRegistry {}
