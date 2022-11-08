import '../../domain/entities/games.dart';
import 'game_mapper.dart';

class GamesMapper {
  static Games fromJson(Map<String, dynamic> json) {
    return Games(
      games: ((json['games'] ?? []) as List).map((e) => GameMapper.fromJson(e)).toList(),
    );
  }
}
