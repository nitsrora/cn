import 'package:chuck_norris/common/text/textConstant.dart';
import 'package:chuck_norris/core/screen/jokeList/components/contentPage.dart';
import 'package:chuck_norris/core/screen/jokeList/jokeListService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JokeListScreen extends StatelessWidget {
  const JokeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: Consumer(
      builder: (context, JokeListService service, child) {
        switch (service.state) {
          case JokeListState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case JokeListState.content:
            return ContentPage();
          default:
            return const ErrorScreen();
        }
      },
    ));
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(TextConstants.generalErrorText),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            Provider.of<JokeListService>(context, listen: false).getJokes();
          },
          child: const Text("Retry"),
        )
      ],
    );
  }
}
