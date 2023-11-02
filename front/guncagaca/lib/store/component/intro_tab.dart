import 'package:flutter/material.dart';

import '../models/store.dart';

class IntroTabWidget extends StatelessWidget {
  final String description;

  const IntroTabWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        description,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
