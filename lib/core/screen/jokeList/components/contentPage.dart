import 'package:chuck_norris/core/screen/jokeList/components/jokeCard.dart';
import 'package:chuck_norris/core/screen/jokeList/components/jokePage.dart';
import 'package:chuck_norris/core/screen/jokeList/jokeListService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentPage extends StatelessWidget {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    JokeListService service =
        Provider.of<JokeListService>(context, listen: false);
    return PageView.builder(
      controller: controller,
      scrollDirection: Axis.vertical,
      itemCount: service.jokes.length,
      itemBuilder: (context, index) =>
          JokePage(service.jokes[index], controller),
    );
  }
}
