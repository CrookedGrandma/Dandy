import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({super.key, this.title = "Dandy"});

  final String title;
}
