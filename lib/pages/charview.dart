import 'package:dandy/json_models/character.dart';
import 'package:dandy/page.dart';
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

  @override
  Widget build(BuildContext context) {
    return basicScaffold(context, widget);
  }
}
