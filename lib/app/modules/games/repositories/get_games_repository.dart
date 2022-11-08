import 'package:dartz/dartz.dart';

import '../../../core/modules/shared/domain/failure.dart';
import '../domain/games.dart';

abstract class GetGamesRepository {
  Future<Either<Failure, Games>> call();
}
