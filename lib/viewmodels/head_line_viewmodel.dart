// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:flutter/material.dart';

import '../data/load_status.dart';
import '../data/search_type.dart';
import '../models/news.dart';
import '../repository/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier {
  HeadLineViewModel({repository}) : _repository = repository as NewsRepository;

  final NewsRepository _repository;

  SearchType _searchType = SearchType.CATEGORY;

  SearchType get searchType => _searchType;

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
  Future<void> getHeadLines({required SearchType searchType}) async {
    _searchType = searchType;

    /// TODO repositoryのChangeNotifier化
//    _isLoading = true;
    /// TODO repositoryのChangeNotifier化

//    notifyListeners();

    // _articles = await _repository.getNews(searchType: SearchType.HEAD_LINE);
    await _repository.getNews(searchType: SearchType.HEAD_LINE);

    /// TODO repositoryのChangeNotifier化
//    _isLoading = false;
    /// TODO repositoryのChangeNotifier化

//    notifyListeners();
  }

  ///
  void onRepositoryUpdated(NewsRepository repository) {
    _articles = repository.articles;

    _loadStatus = repository.loadStatus;

    notifyListeners();
  }
}
