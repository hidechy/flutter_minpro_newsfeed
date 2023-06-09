// ignore_for_file: type_annotate_public_apis

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/category_info.dart';
import '../../../data/load_status.dart';
import '../../../data/search_type.dart';
import '../../../viewmodels/news_list_viewmodel.dart';
import 'components/article_tile.dart';
import 'components/category_chips.dart';
import 'components/news_search_bar.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<NewsListViewModel>();

    /// TODO repositoryのChangeNotifier化
    if (viewModel.loadStatus != LoadStatus.LOADING &&
        viewModel.articles.isEmpty) {
      // TODO setState() or markNeedBuild() called during build
      // とかいうエラーが出る場合は、「非同期に逃げてやる」とうまくいく
      // 次のベルトコンベア(16ms後に実行)に乗せてやる、という意味

      // Future(
      //   () => viewModel.getNews(
      //     searchType: SearchType.CATEGORY,
      //     category: categories[0],
      //   ),
      // );

      // TODO あるいは下記の方法を使う
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        viewModel.getNews(
          searchType: SearchType.CATEGORY,
          category: categories[0],
        );
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              NewsSearchBar(
                onSearch: (keyword) => getKeywordNews(
                  context: context,
                  keyword: keyword.toString(),
                ),
              ),
              CategoryChips(
                onCategorySelected: (category) => getCategoryNews(
                  context: context,
                  category: category as Category,
                ),
              ),
              Expanded(
                child: Consumer<NewsListViewModel>(
                  builder: (context, model, child) {
                    /// TODO repositoryのChangeNotifier化
                    return model.loadStatus == LoadStatus.LOADING
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: model.articles.length,
                            itemBuilder: (context, index) {
                              return ArticleTile(
                                article: model.articles[index],
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
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
    final viewModel = context.read<NewsListViewModel>();

    await viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
  }

  ///
  Future<void> getKeywordNews({
    required BuildContext context,
    required String keyword,
  }) async {
    final viewModel = context.read<NewsListViewModel>();

    await viewModel.getNews(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: categories[0],
    );
  }

  ///
  Future<void> getCategoryNews({
    required BuildContext context,
    required Category category,
  }) async {
    final viewModel = context.read<NewsListViewModel>();

    await viewModel.getNews(
      searchType: SearchType.CATEGORY,
      category: category,
    );
  }
}
