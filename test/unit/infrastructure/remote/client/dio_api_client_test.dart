import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/infrastructure/remote/client/dio_api_client.dart';
import 'package:pokedex/infrastructure/remote/const/api_endpoints.dart';
import 'package:pokedex/infrastructure/remote/exception/remote_exceptions.dart';

import '../../../../mocks/dart/dart_mocks_registry.mocks.dart';
import '../../../../mocks/infrastructure/remote/remote_mocks_registry.mocks.dart';

void main() {
  group("DioApiClient tests", () {
    final dioErrorMock = MockDioError();
    final stackTraceMock = MockStackTrace();
    final dioMock = MockDio();
    final remoteExceptionFactoryMock = MockIRemoteExceptionFactory();
    final responseMock = MockResponse();

    final dioApiClientActual =
        DioApiClient(dioMock, remoteExceptionFactoryMock);

    test("mapError when provided error IS NOT a dio error", () {
      expect(
        () => dioApiClientActual.mapError(
          Exception("Something other than DioError"),
          stackTraceMock,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test("mapError when response is actually null", () {
      when(dioErrorMock.response).thenReturn(null);

      expect(
        () => dioApiClientActual.mapError(dioErrorMock, stackTraceMock),
        throwsA(isA<DioError>()),
      );
    });

    test("mapError when response is not null and its status code is 500", () {
      when(dioErrorMock.response).thenReturn(responseMock);

      when(remoteExceptionFactoryMock.create(ResponseCode.serverException))
          .thenReturn(ServerException());

      when(responseMock.statusCode).thenReturn(ResponseCode.serverException);

      expect(
        () => dioApiClientActual.mapError(dioErrorMock, stackTraceMock),
        throwsA(isA<ServerException>()),
      );
    });

    test(
      "mapError when response is not null and its status code is not handled",
      () {
        when(dioErrorMock.response).thenReturn(responseMock);

        const responseCode = 423;

        when(remoteExceptionFactoryMock.create(responseCode))
            .thenReturn(RemoteException());

        when(responseMock.statusCode).thenReturn(responseCode);

        expect(
          () => dioApiClientActual.mapError(dioErrorMock, stackTraceMock),
          throwsA(isA<RemoteException>()),
        );
      },
    );
  });
}
