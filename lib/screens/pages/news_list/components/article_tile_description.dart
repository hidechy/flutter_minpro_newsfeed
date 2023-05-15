import 'package:flutter/material.dart';

import '../../../../models/news.dart';

class ArticleTileDescription extends StatelessWidget {
  const ArticleTileDescription({super.key, required this.article});

  final Article article;

  ///
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(article.title ?? ''),
        Text(
          article.publishDate ?? '',
          style: const TextStyle(fontSize: 10),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.6),
          thickness: 2,
        ),
        Text(article.description ?? ''),
      ],
    );
  }
}
