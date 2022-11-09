import 'package:code_game/app/modules/games/domain/entities/games.dart';
import 'package:code_game/app/modules/games/external/datasources/get_games_datasource_implementation.dart';
import 'package:code_game/app/modules/games/infrastructure/errors/get_games_datasource_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/get_games_success_response.dart';

class _DioMock extends Mock implements Dio {}

class _RequestOptionsFake extends Fake implements RequestOptions {}

void main() {
  final dio = _DioMock();
  final datasource = GetGamesDatasourceImplementation(dio);

  setUp(() {
    registerFallbackValue(_RequestOptionsFake());
  });

  group('Get Games [External] -', () {
    test('Must complete the request', () {
      when(() => dio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          )).thenAnswer((invocation) async => Response(
            data: getGamesSuccessResponse,
            requestOptions: _RequestOptionsFake(),
            statusCode: 200,
          ));

      final result = datasource();

      expect(result, completes);
    });

    test('Must return a Games list on status code 200', () async {
      when(() => dio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          )).thenAnswer(
        (realInvocation) async => Response(
          requestOptions: _RequestOptionsFake(),
          data: getGamesSuccessResponse,
          statusCode: 200,
        ),
      );

      final result = await datasource();

      expect(result, isA<Games>());
    });

    test('Must throw a GetGamesDatasourceError failure on any other status code', () async {
      when(() => dio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          )).thenAnswer(
        (realInvocation) async => Response(
          requestOptions: _RequestOptionsFake(),
          data: {},
          statusCode: 400,
        ),
      );

      final result = datasource();

      expect(result, throwsA(isA<GetGamesDatasourceError>()));
    });

    test('Must throw an RequestFailure on any other exceptions', () async {
      when(() => dio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          )).thenThrow(Exception('Error'));

      final result = datasource();

      expect(result, throwsA(isA<Exception>()));
    });
  });
}
