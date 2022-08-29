import 'package:chuck_norris/common/theme/colorTheme.dart';
import 'package:chuck_norris/core/model/joke_model.dart';
import 'package:chuck_norris/core/screen/jokeList/components/jokeCard.dart';
import 'package:chuck_norris/core/screen/jokeList/jokeListService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JokePage extends StatelessWidget {
  final JokeModel jokeModel;
  final PageController controller;
  JokePage(this.jokeModel, this.controller);
  final _animationDuration = Duration(milliseconds: 500);
  final _curve = Curves.easeIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (jokeModel.id != 1)
            ? InkWell(
                onTap: () {
                  controller.previousPage(
                      duration: _animationDuration, curve: _curve);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  constraints: const BoxConstraints(maxWidth: 420),
                  decoration: BoxDecoration(
                      color: ColorTheme.WHITE_COLOR,
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(12)),
                      border: Border.all(color: ColorTheme.GREY_COLOR)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text("Previous")],
                  ),
                ),
              )
            : const SizedBox(),
        Container(
          padding: const EdgeInsets.all(8),
          child: JokeCard(jokeModel),
        ),
        (jokeModel.id !=
                Provider.of<JokeListService>(context, listen: false)
                    .jokes
                    .length)
            ? InkWell(
                onTap: () {
                  controller.nextPage(
                      duration: _animationDuration, curve: _curve);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  constraints: const BoxConstraints(maxWidth: 420),
                  decoration: BoxDecoration(
                      color: ColorTheme.WHITE_COLOR,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      border: Border.all(color: ColorTheme.GREY_COLOR)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text("Next")],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
