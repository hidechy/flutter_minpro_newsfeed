// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:test_minpro_newsfeed/models/news.dart';
import 'package:test_minpro_newsfeed/screens/news_webpage_screen.dart';

import '../../news_list/components/image_from_url.dart';
import 'lazy_load_text.dart';
import 'page_transformer.dart';

class HeadLineItem extends StatelessWidget {
  const HeadLineItem({
    super.key,
    required this.article,
    required this.pageVisibility,
  });

  final Article article;
  final PageVisibility pageVisibility;

  ///
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
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
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white54,
                      Colors.transparent,
                    ]),
              ),
              child: ImageFromUrl(
                imageUrl: article.urlToImage,
              ),
            ),
            Positioned(
              bottom: 50,
              left: 32,
              right: 32,
              child: LazyLoadText(
                text: article.title ?? '',
                pageVisibility: pageVisibility,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
