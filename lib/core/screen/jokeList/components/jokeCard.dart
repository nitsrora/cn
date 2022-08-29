import 'package:chuck_norris/common/theme/colorTheme.dart';
import 'package:chuck_norris/core/model/joke_model.dart';
import 'package:chuck_norris/core/screen/jokeList/components/emailCard.dart';
import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final JokeModel jokeModel;
  const JokeCard(this.jokeModel);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: ColorTheme.WHITE_COLOR,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorTheme.GREY_COLOR)),
        child: Wrap(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(jokeModel.jokeContent),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: ColorTheme.GREY_COLOR))),
                  child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          constraints: const BoxConstraints(maxWidth: 420),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          context: context,
                          builder: (context) {
                            return EmailCard(jokeModel);
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Share"),
                        ],
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
