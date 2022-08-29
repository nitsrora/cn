import 'dart:convert';

import 'package:chuck_norris/common/keyPair/jokeKeyPair.dart';
import 'package:chuck_norris/core/model/joke_model.dart';
import 'package:http/http.dart' as http;

class JokeApi {
  static const String _hostUrl = "api.icndb.com";
  static const String _path = "/jokes";
  static const Map<String, dynamic> _queryParams = {"escape": "javascript"};

  // Fetch Jokes from the API and Convert to List of JokeModel
  Future<List<JokeModel>> getJokes() async {
    Uri url = Uri.http(_hostUrl, _path, _queryParams);
    return await http.get(url).then((value) {
      _handleApiError(value);
      Map jsonBody = json.decode(value.body);
      return _jokeListConversion(jsonBody);
    });
  }

  List<JokeModel> _jokeListConversion(Map jsonBody) {
    if (jsonBody[JokeKeyPair.TYPE] == JokeKeyPair.SUCCESS) {
      List jokeList = jsonBody[JokeKeyPair.VALUE];
      List<JokeModel> returnList = [];
      for (int i = 0; i < jokeList.length; i++) {
        returnList.add(JokeModel.fromJson(jokeList[i]));
      }
      return returnList;
    } else {
      throw "ERROR";
    }
  }

  _handleApiError(http.Response response) {
    if (response.statusCode != 200) throw "Error";
  }
}
