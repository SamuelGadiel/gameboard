import 'package:dartz/dartz.dart';

import '../../../../core/modules/shared/domain/failure.dart';
import '../../domain/entities/games.dart';

abstract class GetGamesRepository {
  Future<Either<Failure, Games>> call();
}
