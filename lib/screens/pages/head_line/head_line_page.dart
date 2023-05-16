import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/load_status.dart';
import '../../../data/search_type.dart';
import '../../../viewmodels/head_line_viewmodel.dart';
import 'components/head_line_item.dart';
import 'components/page_transformer.dart';

class HeadLinePage extends StatelessWidget {
  const HeadLinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HeadLineViewModel>();

    /// TODO repositoryのChangeNotifier化
    if (viewModel.loadStatus != LoadStatus.LOADING &&
        viewModel.articles.isEmpty) {
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
            /// TODO repositoryのChangeNotifier化
            if (model.loadStatus == LoadStatus.LOADING) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return PageTransformer(
              pageViewBuilder: (context, resolver) {
                return PageView.builder(
                  controller: PageController(viewportFraction: 0.95),
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
