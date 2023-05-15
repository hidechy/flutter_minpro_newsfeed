import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_minpro_newsfeed/viewmodels/news_list_viewmodel.dart';

import '../../../data/category_info.dart';
import '../../../data/search_type.dart';
import 'components/category_chips.dart';
import 'components/news_search_bar.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              NewsSearchBar(
                onSearch: (keyword) => getKeywordNews(
                  context: context,
                  keyword: keyword,
                ),
              ),
              CategoryChips(
                onCategorySelected: (category) => getCategoryNews(
                  context: context,
                  category: category,
                ),
              ),
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
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
    required keyword,
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
