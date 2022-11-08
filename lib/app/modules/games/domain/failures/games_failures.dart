import '../../../../core/modules/shared/domain/failures/failure.dart';

abstract class GamesFailures implements Failure {
  final String failure;

  GamesFailures(this.failure);
}
