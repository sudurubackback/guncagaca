import 'package:flutter/material.dart';

import '../models/store.dart';

class IntroTabWidget extends StatelessWidget {
  final Store store;

  const IntroTabWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        store.description,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
