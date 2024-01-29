import 'package:dandy/page.dart';
import 'package:flutter/material.dart';

Scaffold basicScaffold(BuildContext context, BasePage page, { Widget? body, Widget? floatingActionButton }) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(page.title),
    ),
    body: body,
    floatingActionButton: floatingActionButton,
  );
}