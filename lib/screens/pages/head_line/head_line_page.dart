import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_minpro_newsfeed/screens/pages/head_line/components/head_line_item.dart';
import 'package:test_minpro_newsfeed/screens/pages/head_line/components/page_transformer.dart';

import '../../../data/search_type.dart';
import '../../../viewmodels/head_line_viewmodel.dart';

class HeadLinePage extends StatelessWidget {
  const HeadLinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HeadLineViewModel>();

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(
        () => viewModel.getHeadLines(
          searchType: SearchType.HEAD_LINE,
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<HeadLineViewModel>(
          builder: (context, model, child) {
            return PageTransformer(
              pageViewBuilder: (context, resolver) {
                return PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  itemCount: model.articles.length,
                  itemBuilder: (context, index) {
                    final article = model.articles[index];

                    final visibility = resolver.resolvePageVisibility(index);
                    final fraction = visibility.visibleFraction;

                    return Opacity(
                      opacity: fraction,
                      child: Center(
                        child: HeadLineItem(
                          article: article,
                          pageVisibility: visibility,
                          onArticleClicked: (_) {},
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onRefresh(context: context);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  ///
  Future<void> onRefresh({required BuildContext context}) async {
    final viewModel = context.read<HeadLineViewModel>();

    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }
}
