import 'package:flutter/material.dart';

import '../data/search_type.dart';
import '../models/news.dart';
import '../repository/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier {
  final NewsRepository _repository = NewsRepository();

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
