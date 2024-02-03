import 'package:flutter/material.dart';

class LoadingScreenInCenter extends StatelessWidget {
  const LoadingScreenInCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}