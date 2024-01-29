import 'package:dandy/page.dart';
import 'package:dandy/widgets.dart';
import 'package:flutter/material.dart';

class CharacterSelectionPage extends BasePage {
  const CharacterSelectionPage({super.key});

  @override
  State<CharacterSelectionPage> createState() => _CharacterSelectionPageState();
}

class _CharacterSelectionPageState extends State<CharacterSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return basicScaffold(context, widget, body: const Placeholder());
  }
}
