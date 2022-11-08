import 'games_datasource_errors.dart';

class GetGamesDatasourceError implements GamesDatasourceErrors {
  final String message;

  GetGamesDatasourceError({required this.message});
}
