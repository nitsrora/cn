import 'package:chuck_norris/common/theme/colorTheme.dart';
import 'package:chuck_norris/core/model/joke_model.dart';
import 'package:chuck_norris/core/screen/jokeList/jokeListService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailCard extends StatefulWidget {
  final JokeModel jokeModel;
  const EmailCard(this.jokeModel);

  @override
  _EmailCardState createState() => _EmailCardState();
}

class _EmailCardState extends State<EmailCard> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    JokeListService service =
        Provider.of<JokeListService>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Share Joke via Email"),
              const SizedBox(height: 8),
              (service.emailList.length > 0)
                  ? Container(
                      padding: const EdgeInsets.all(4),
                      constraints: BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorTheme.GREY_COLOR),
                          borderRadius: BorderRadius.circular(4)),
                      child: ListView.builder(
                        itemCount: service.emailList.length,
                        itemBuilder: (context, index) {
                          return Text(service.emailList[index]);
                        },
                      ))
                  : const SizedBox(),
              Form(
                key: formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: service.emailController,
                        validator: (value) {
                          return service.validateEmail(value!);
                        },
                        decoration: const InputDecoration(
                          labelText: "Enter Email Address",
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Container(
                        height: 14,
                        width: 14,
                        child: (!isLoading)
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      service.addEmail();
                                      isLoading = false;
                                    });
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                child: const Icon(
                                  Icons.add,
                                ))
                            : const CircularProgressIndicator())
                  ],
                ),
              ),
              const SizedBox(height: 8),
              (service.emailList.length > 0)
                  ? ElevatedButton(
                      onPressed: () {
                        service.sendEmail(widget.jokeModel);
                        Navigator.pop(context);
                      },
                      child: Text("Share"))
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
