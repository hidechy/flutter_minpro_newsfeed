// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:flutter/material.dart';

import '../data/search_type.dart';
import '../models/news.dart';
import '../repository/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier {
  //))))))))))))))))))))))))) TODO DI変更
  HeadLineViewModel({repository}) : _repository = repository as NewsRepository;

  final NewsRepository _repository;

//  final NewsRepository _repository = NewsRepository();
  //))))))))))))))))))))))))) TODO DI変更

  SearchType _searchType = SearchType.CATEGORY;

  SearchType get searchType => _searchType;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  ///
  Future<void> getHeadLines({required SearchType searchType}) async {
    _searchType = searchType;

    _isLoading = true;

    notifyListeners();

    _articles = await _repository.getNews(searchType: SearchType.HEAD_LINE);

    _isLoading = false;

    notifyListeners();
  }
}
