import 'package:dartz/dartz.dart';

import '../../../../core/modules/shared/domain/failures/failure.dart';
import '../../../../core/modules/shared/domain/failures/request_failure.dart';
import '../../domain/entities/games.dart';
import '../../domain/failures/get_games_failure.dart';
import '../../domain/repositories/get_games_repository.dart';
import '../datasources/get_games_datasource.dart';
import '../errors/get_games_datasource_error.dart';

class GetGamesRepositoryImplementation implements GetGamesRepository {
  final GetGamesDatasource datasource;

  GetGamesRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, Games>> call() async {
    try {
      return Right(await datasource());
    } on GetGamesDatasourceError catch (e) {
      return Left(GetGamesFailure(failure: e.message));
    } on Exception catch (e) {
      return Left(RequestFailure(message: e.toString()));
    }
  }
}
