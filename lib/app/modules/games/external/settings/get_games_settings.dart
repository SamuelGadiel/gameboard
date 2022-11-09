import 'games_settings.dart';

class GetGamesSettings {
  static const String url = GamesSettings.url;

  static const Map<String, String> headers = {
    ...GamesSettings.headers,
  };

  static const Map<String, dynamic> query = {
    'serviceName': 'CG.listGame',
  };
}
