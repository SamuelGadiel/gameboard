import 'package:code_game/app/modules/games/domain/entities/games.dart';
import 'package:code_game/app/modules/games/domain/failures/get_games_failure.dart';
import 'package:code_game/app/modules/games/domain/repositories/get_games_repository.dart';
import 'package:code_game/app/modules/games/domain/usecases/get_games.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _GetGamesRepositoryMock extends Mock implements GetGamesRepository {}

class _GamesMock extends Fake implements Games {}

void main() {
  final repository = _GetGamesRepositoryMock();
  final usecase = GetGamesImplementation(repository);

  setUp(() {
    registerFallbackValue(_GamesMock());
  });

  group('Get Games -', () {
    test('Must return a Games list on success request', () async {
      when(() => repository()).thenAnswer((invocation) async => Right(_GamesMock()));

      final result = await usecase();

      expect(result.fold(id, id), isA<Games>());
    });

    test('Must return a GetGamesFailure on failure request', () async {
      when(() => repository()).thenAnswer((invocation) async => Left(GetGamesFailure(failure: 'Error')));

      final result = await usecase();

      expect(result.fold(id, id), isA<GetGamesFailure>());
    });
  });
}
