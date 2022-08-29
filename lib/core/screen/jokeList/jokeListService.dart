import 'package:chuck_norris/adapter/api/joke/joke_api.dart';
import 'package:chuck_norris/adapter/server/server_api.dart';
import 'package:chuck_norris/core/model/joke_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum JokeListState { loading, content, error }

class JokeListService with ChangeNotifier {
  JokeListState _state = JokeListState.loading;
  JokeListState get state => _state;

  List<JokeModel> jokes = [];

  List<String> emailList = [];
  TextEditingController emailController = TextEditingController();

  void _setStatus(JokeListState js) {
    _state = js;
    notifyListeners();
  }

  void _handleError(onError) {
    debugPrint(onError);
    _setStatus(JokeListState.error);
  }

  JokeListService() {
    getJokes();
  }

  void getJokes() {
    _setStatus(JokeListState.loading);
    jokes.clear();
    JokeApi ja = JokeApi();
    ja.getJokes().then((value) {
      jokes.addAll(value);
      _setStatus(JokeListState.content);
    }).catchError((onError) {
      _handleError(onError);
    });
  }

  String? validateEmail(String email) {
    var r = RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
    if (emailList.contains(email)) {
      return "Email already in List";
    } else if (email.length < 1) {
      return 'Enter a Valid Email Address';
    } else if (!r.hasMatch(email)) {
      return 'Enter a Valid Email Address';
    } else {
      return null;
    }
  }

  void addEmail() {
    String e = emailController.text;
    emailList.add(e.toLowerCase().trim());
    emailController.clear();

    emailList.sort((a, b) {
      List al = a.split("@");
      String newA = al[1] + al[0];
      List bl = b.split("@");
      String newB = bl[1] + bl[0];
      return newA.compareTo(newB);
    });
  }

  void sendEmail(JokeModel jm) {
    ServerApi.shareJoke(jm.jokeContent, emailList);
  }
}
