// ignore_for_file: must_be_immutable, strict_raw_type

import 'package:flutter/material.dart';

class NewsSearchBar extends StatelessWidget {
  NewsSearchBar({super.key, required this.onSearch});

  final ValueChanged onSearch;

  TextEditingController textEditingController = TextEditingController();

  ///
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          onSubmitted: onSearch,
          controller: textEditingController,
          decoration: const InputDecoration(
            icon: Icon(Icons.search),
            hintText: '検索ワードを入れてください。',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
