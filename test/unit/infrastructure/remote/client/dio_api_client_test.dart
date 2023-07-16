import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/infrastructure/remote/client/dio_api_client.dart';
import 'package:pokedex/infrastructure/remote/const/api_endpoints.dart';
import 'package:pokedex/infrastructure/remote/exception/remote_exceptions.dart';

import '../../../../mocks/dart/dart_mocks_registry.mocks.dart';
import '../../../../mocks/infrastructure/remote/remote_mocks_registry.mocks.dart';

void main() {
  late MockDioError dioErrorMock;
  late MockStackTrace stackTraceMock;
  late MockDio dioMock;
  late MockIRemoteExceptionFactory remoteExceptionFactoryMock;
  late MockResponse responseMock;

  late DioApiClient sut;

  setUp(() {
    dioErrorMock = MockDioError();
    stackTraceMock = MockStackTrace();
    dioMock = MockDio();
    remoteExceptionFactoryMock = MockIRemoteExceptionFactory();
    responseMock = MockResponse();

    sut = DioApiClient(dioMock, remoteExceptionFactoryMock);
  });

  group("mapError", () {
    test("Rethrows the custom exception", () {
      expect(
        () => sut.mapError(
          Exception(),
          stackTraceMock,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test("Throws the DioError when response is actually null", () {
      when(dioErrorMock.response).thenReturn(null);

      expect(
        () => sut.mapError(dioErrorMock, stackTraceMock),
        throwsA(isA<DioError>()),
      );
    });

    test("Throws a ServerException when response is not null and its status code is 500", () {
      when(dioErrorMock.response).thenReturn(responseMock);

      when(remoteExceptionFactoryMock.create(ResponseCode.serverException))
          .thenReturn(ServerException());

      when(responseMock.statusCode).thenReturn(ResponseCode.serverException);

      expect(
        () => sut.mapError(dioErrorMock, stackTraceMock),
        throwsA(isA<ServerException>()),
      );
    });

    test(
      "Throws a RemoteException when response is not null and its status code is not handled",
      () {
        when(dioErrorMock.response).thenReturn(responseMock);

        const responseCode = 423;

        when(remoteExceptionFactoryMock.create(responseCode))
            .thenReturn(RemoteException());

        when(responseMock.statusCode).thenReturn(responseCode);

        expect(
          () => sut.mapError(dioErrorMock, stackTraceMock),
          throwsA(isA<RemoteException>()),
        );
      },
    );
  });
}
