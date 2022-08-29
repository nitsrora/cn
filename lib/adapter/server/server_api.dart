import 'package:http/http.dart' as http;

class ServerApi {
  static const String _hostUrl = "localhost";
  static const String _path = "/share";

  // Fetch Jokes from the API and Convert to List of JokeModel
  static Future<void> shareJoke(String joke, List<String> emails) async {
    Map<String, dynamic> body = {"joke": joke, "emails": emails};

    Uri url = Uri.http(_hostUrl, _path);
    // await http.post(url, body: body).then((value) {});
  }
}
