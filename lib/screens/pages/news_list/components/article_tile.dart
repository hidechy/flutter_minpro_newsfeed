// ignore_for_file: strict_raw_type

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_minpro_newsfeed/screens/pages/news_list/components/image_from_url.dart';

import '../../../../models/news.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile(
      {Key? key, required this.article, required this.onArticleClicked})
      : super(key: key);

  final Article article;

  final ValueChanged onArticleClicked;

  ///
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: ImageFromUrl(imageUrl: article.urlToImage),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(article.title ?? ''),
                    Text(article.publishDate ?? ''),
                    Text(article.description ?? ''),
                    Text(article.urlToImage ?? ''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
