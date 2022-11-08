import '../../../../core/extensions/int_extension.dart';
import '../../domain/entities/game.dart';

class GameMapper {
  static Game fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['gameId'] ?? IntExtension.nan,
      name: json['name'] ?? '',
    );
  }
}
