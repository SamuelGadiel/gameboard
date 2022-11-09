import 'package:dio/dio.dart';

import '../../domain/entities/games.dart';
import '../../infrastructure/datasources/get_games_datasource.dart';
import '../../infrastructure/errors/get_games_datasource_error.dart';
import '../../infrastructure/mappers/games_mapper.dart';
import '../settings/get_games_settings.dart';

class GetGamesDatasourceImplementation implements GetGamesDatasource {
  final Dio dio;

  GetGamesDatasourceImplementation(this.dio);

  @override
  Future<Games> call() async {
    final response = await dio.get(
      GetGamesSettings.url,
      queryParameters: GetGamesSettings.query,
      options: Options(headers: GetGamesSettings.headers),
    );

    switch (response.statusCode) {
      case 200:
        return GamesMapper.fromJson(response.data);
      default:
        throw GetGamesDatasourceError(message: 'Houve um erro interno');
    }
  }
}
