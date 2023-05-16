// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:flutter/material.dart';

import '../data/category_info.dart';
import '../data/search_type.dart';
import '../models/news.dart';
import '../repository/news_repository.dart';

class NewsListViewModel extends ChangeNotifier {
  //))))))))))))))))))))))))) TODO DI変更
  NewsListViewModel({repository}) : _repository = repository as NewsRepository;

  final NewsRepository _repository;

//  final NewsRepository _repository = NewsRepository();

  //))))))))))))))))))))))))) TODO DI変更

  SearchType _searchType = SearchType.CATEGORY;

  SearchType get searchType => _searchType;

  Category _category = categories[0];

  Category get category => _category;

  String _keyword = '';

  String get keyword => _keyword;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  ///
  Future<void> getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    _searchType = searchType;
    _keyword = keyword ?? '';
    _category = category ?? categories[0];

    _isLoading = true;

    _articles = await _repository.getNews(
      searchType: _searchType,
      keyword: _keyword,
      category: _category,
    );

    _isLoading = false;

    notifyListeners();
  }
}
