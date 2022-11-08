import '../../domain/entities/games.dart';

abstract class GetGamesDatasource {
  Future<Games> call();
}
