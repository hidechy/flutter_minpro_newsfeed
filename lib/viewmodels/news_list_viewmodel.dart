// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:flutter/material.dart';

import '../data/category_info.dart';
import '../data/load_status.dart';
import '../data/search_type.dart';
import '../models/news.dart';
import '../repository/news_repository.dart';

class NewsListViewModel extends ChangeNotifier {
  NewsListViewModel({repository}) : _repository = repository as NewsRepository;

  final NewsRepository _repository;

  SearchType _searchType = SearchType.CATEGORY;

  SearchType get searchType => _searchType;

  Category _category = categories[0];

  Category get category => _category;

  String _keyword = '';

  String get keyword => _keyword;

  /// TODO repositoryのChangeNotifier化
  // bool _isLoading = false;
  //
  // bool get isLoading => _isLoading;
  /// TODO repositoryのChangeNotifier化

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  /// TODO repositoryのChangeNotifier化

  LoadStatus _loadStatus = LoadStatus.DONE;

  LoadStatus get loadStatus => _loadStatus;

  /// TODO repositoryのChangeNotifier化

  ///
  Future<void> getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    _searchType = searchType;
    _keyword = keyword ?? '';
    _category = category ?? categories[0];

    /// TODO repositoryのChangeNotifier化

    // _isLoading = true;
    //
    // _articles = await _repository.getNews(
    //   searchType: _searchType,
    //   keyword: _keyword,
    //   category: _category,
    // );
    //
    // _isLoading = false;
    //
    // notifyListeners();

    await _repository.getNews(
      searchType: _searchType,
      keyword: _keyword,
      category: _category,
    );

    /// TODO repositoryのChangeNotifier化
  }

  ///
  void onRepositoryUpdated(NewsRepository repository) {
    _articles = repository.articles;
    _loadStatus = repository.loadStatus;
    notifyListeners();
  }
}
