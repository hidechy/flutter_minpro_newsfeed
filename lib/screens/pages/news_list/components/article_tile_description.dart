import 'package:flutter/material.dart';

import '../../../../models/news.dart';

class ArticleTileDescription extends StatelessWidget {
  const ArticleTileDescription({Key? key, required this.article})
      : super(key: key);

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
          style: TextStyle(fontSize: 10),
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
