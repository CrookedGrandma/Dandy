import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key, this.title = "Dandy"});

  final String title;
}
