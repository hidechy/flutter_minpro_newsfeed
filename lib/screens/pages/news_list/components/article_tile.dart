// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:test_minpro_newsfeed/screens/news_webpage_screen.dart';
import 'package:test_minpro_newsfeed/screens/pages/news_list/components/article_tile_description.dart';

import '../../../../models/news.dart';
import 'image_from_url.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({super.key, required this.article});

  final Article article;

  ///
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsWebpageScreen(
                  article: article,
                ),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: ImageFromUrl(imageUrl: article.urlToImage),
                ),
              ),
              Expanded(
                flex: 3,
                child: ArticleTileDescription(article: article),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
