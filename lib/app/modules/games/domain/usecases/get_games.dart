import 'package:dartz/dartz.dart';

import '../../../../core/modules/shared/domain/failure.dart';
import '../../domain/entities/games.dart';
import '../repositories/get_games_repository.dart';

abstract class GetGames {
  Future<Either<Failure, Games>> call();
}

class GetGamesImplementation implements GetGames {
  final GetGamesRepository repository;

  GetGamesImplementation(this.repository);

  @override
  Future<Either<Failure, Games>> call() async {
    return await repository();
  }
}
