import 'package:code_game/app/core/modules/shared/domain/failures/request_failure.dart';
import 'package:code_game/app/modules/games/domain/entities/games.dart';
import 'package:code_game/app/modules/games/domain/failures/get_games_failure.dart';
import 'package:code_game/app/modules/games/infrastructure/datasources/get_games_datasource.dart';
import 'package:code_game/app/modules/games/infrastructure/errors/get_games_datasource_error.dart';
import 'package:code_game/app/modules/games/infrastructure/repositories/get_games_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _GetGamesDatasourceMock extends Mock implements GetGamesDatasource {}

class _GamesFake extends Fake implements Games {}

void main() {
  final datasource = _GetGamesDatasourceMock();
  final repository = GetGamesRepositoryImplementation(datasource);

  setUp(() {
    registerFallbackValue(_GamesFake());
  });

  group('Get Games [Infrastructure] -', () {
    test('Must return a Games list entity', () async {
      when(() => datasource()).thenAnswer((realInvocation) async => _GamesFake());

      final result = await repository();

      expect(result.fold(id, id), isA<Games>());
    });

    test('Must return a GetGamesFailure on GetGamesDatasourceError error', () async {
      when(() => datasource()).thenThrow(GetGamesDatasourceError(message: 'message'));

      final result = await repository();

      expect(result.fold(id, id), isA<GetGamesFailure>());
    });

    test('Must return a RequestFailure on Exception errors', () async {
      when(() => datasource()).thenThrow(Exception('message'));

      final result = await repository();

      expect(result.fold(id, id), isA<RequestFailure>());
    });
  });
}
