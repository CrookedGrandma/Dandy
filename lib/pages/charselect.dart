import 'package:dandy/components/loadingscreen.dart';
import 'package:dandy/models/character.dart';
import 'package:dandy/page.dart';
import 'package:dandy/widgets.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class CharacterSelectionPage extends BasePage {
  const CharacterSelectionPage({super.key});

  @override
  State<CharacterSelectionPage> createState() => _CharacterSelectionPageState();
}

class _CharacterSelectionPageState extends State<CharacterSelectionPage> {
  final LocalStorage storage = LocalStorage("characters");

  bool initialized = false;

  late List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data != true) {
          return basicScaffold(context, widget, body: const LoadingScreenInCenter());
        }

        if (!initialized) {
          var charList = storage.getItem("list");
          if (charList == null) {
            characters = [];
          }
          else {
            characters =
                charList.map((char) => Character.fromJson(char)).toList();
          }
          initialized = true;
        }

        return basicScaffold(context, widget, body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CharacterSelector(),
              // 'new character' button
            ],
          )
        ));
      },
    );
  }

  Widget CharacterSelector() {
    return Column(
      children: characters.map((char) => Row(
        children: [
          Text(char.name)
        ],
      )).toList(),
    );
  }
}
