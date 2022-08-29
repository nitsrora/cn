import 'package:chuck_norris/common/keyPair/jokeKeyPair.dart';

class JokeModel {
  late int _id;
  late String _jokeContent;
  final List category = [];

  int get id => _id;
  String get jokeContent => _jokeContent;

  JokeModel.fromJson(Map data) {
    _id = data[JokeKeyPair.ID] ?? 0;
    _jokeContent = data[JokeKeyPair.JOKE_CONTENT] ?? "";
    category.addAll(data[JokeKeyPair.CATEGORIES]);
  }
}
