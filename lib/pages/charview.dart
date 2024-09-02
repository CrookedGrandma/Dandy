import 'dart:convert';

import 'package:dandy/json_models/character.dart';
import 'package:dandy/page.dart';
import 'package:dandy/services/property_getter.dart';
import 'package:dandy/widgets.dart';
import 'package:flutter/material.dart';

class CharacterViewPage extends BasePage {
  final Character character;

  CharacterViewPage(this.character, {super.key}) : super(title: character.name);

  @override
  State<CharacterViewPage> createState() => _CharViewPageState();
}

class _CharViewPageState extends State<CharacterViewPage> {
  late final Character _character = widget.character;
  late final PropertyGetter _prop = PropertyGetter(_character);
  late final Image? _image = _character.imageBase64 != ""
    ? Image.memory(base64Decode(_character.imageBase64))
    : null;

  @override
  Widget build(BuildContext context) {
    return basicScaffold(context, widget, body: Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Column(
            children: [
              IconButton.outlined(
                onPressed: () {},
                icon: _image ?? const Icon(Icons.person),
                iconSize: 48,
                style: const ButtonStyle(shape: WidgetStatePropertyAll(ContinuousRectangleBorder())),
                padding: _image == null ? null : const EdgeInsets.all(4),
              ),
            ],
          ),
        ]
      ),
    ));
  }
}
