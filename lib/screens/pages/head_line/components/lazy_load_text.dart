import 'package:flutter/material.dart';

import 'page_transformer.dart';

class LazyLoadText extends StatelessWidget {
  const LazyLoadText(
      {super.key, required this.text, required this.pageVisibility});

  final String text;
  final PageVisibility pageVisibility;

  ///
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: Alignment.topLeft,
        transform: Matrix4.translationValues(
          pageVisibility.pagePosition * 200,
          0,
          0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
