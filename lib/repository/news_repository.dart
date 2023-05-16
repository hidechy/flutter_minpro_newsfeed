// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../data/category_info.dart';
import '../data/load_status.dart';
import '../data/search_type.dart';
import '../extensions/extensions.dart';
import '../models/db/dao.dart';
import '../models/news.dart';

class NewsRepository extends ChangeNotifier {
  NewsRepository({dao}) : _dao = dao as NewsDao;

  final NewsDao _dao;

  /// TODO repositoryのChangeNotifier化
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  LoadStatus _loadStatus = LoadStatus.DONE;

  LoadStatus get loadStatus => _loadStatus;

  /// TODO repositoryのChangeNotifier化

  /// TODO repositoryのChangeNotifier化
  ///
//  Future<List<Article>> getNews({
  Future<void> getNews({
    /// TODO repositoryのChangeNotifier化
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    /// TODO repositoryのChangeNotifier化
//    var result = <Article>[];

    _loadStatus = LoadStatus.LOADING;
    notifyListeners();

    /// TODO repositoryのChangeNotifier化

    var url = 'https://newsapi.org/v2/top-headlines?country=us';

    http.Response? response;

    switch (searchType) {
      case SearchType.HEAD_LINE:
        url += '&apiKey=${dotenv.get('NEWS_API_TOKEN')}';
        break;

      case SearchType.KEYWORD:
        url += '&q=$keyword&apiKey=${dotenv.get('NEWS_API_TOKEN')}';
        break;

      case SearchType.CATEGORY:
        url +=
            '&category=${category?.nameEn}&apiKey=${dotenv.get('NEWS_API_TOKEN')}';
        break;
    }

    response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = response.body;

      /// TODO repositoryのChangeNotifier化
      // result = await insertAndReadNewsFromDB(
      //     jsonDecode(responseBody) as Map<String, dynamic>);

      await insertAndReadNewsFromDB(
          jsonDecode(responseBody) as Map<String, dynamic>);

      _loadStatus = LoadStatus.DONE;

      /// TODO repositoryのChangeNotifier化
    } else {
      /// TODO repositoryのChangeNotifier化
      _loadStatus = LoadStatus.ERROR;

      /// TODO repositoryのChangeNotifier化

      throw Exception('Failed to load news.');
    }

    /// TODO repositoryのChangeNotifier化
//    return result;

    notifyListeners();

    /// TODO repositoryのChangeNotifier化
  }

  /// TODO repositoryのChangeNotifier化
  ///
//  Future<List<Article>> insertAndReadNewsFromDB(
  Future<void> insertAndReadNewsFromDB(

      /// TODO repositoryのChangeNotifier化

      Map<String, dynamic> responseBody) async {
    /// TODO repositoryのChangeNotifier化
//    final articles = News.fromJson(responseBody).articles;
//     final articleRecords = await _dao.insertAndReadNewsFromDB(
//       articles.toArticleRecords(articles),
//     );
//    return articleRecords.toArticle(articleRecords);

    final articlesFromNetwork = News.fromJson(responseBody).articles;

    final articlesFromDB = await _dao.insertAndReadNewsFromDB(
      articlesFromNetwork.toArticleRecords(articlesFromNetwork),
    );

    _articles = articlesFromDB.toArticle(articlesFromDB);

    /// TODO repositoryのChangeNotifier化
  }
}

//XXXXXXXXXXXXX
//XXXXXXXXXXXXX
//XXXXXXXXXXXXX
//XXXXXXXXXXXXX
//XXXXXXXXXXXXX

// // ignore_for_file: inference_failure_on_untyped_parameter
//
// import 'dart:convert';
//
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
//
// import '../data/category_info.dart';
// import '../data/search_type.dart';
// import '../extensions/extensions.dart';
// import '../models/db/dao.dart';
// import '../models/news.dart';
//
// class NewsRepository {
//   //))))))))))))))))))))))))) TODO DI変更
//   NewsRepository({dao}) : _dao = dao as NewsDao;
//
//   final NewsDao _dao;
//
//   //))))))))))))))))))))))))) TODO DI変更
//
//   ///
//   Future<List<Article>> getNews({
//     required SearchType searchType,
//     String? keyword,
//     Category? category,
//   }) async {
//     var result = <Article>[];
//
//     // TODO [jp]だと画像のurlが取得できない
//     var url = 'https://newsapi.org/v2/top-headlines?country=us';
//
//     http.Response? response;
//
//     switch (searchType) {
//       case SearchType.HEAD_LINE:
//         url += '&apiKey=${dotenv.get('NEWS_API_TOKEN')}';
//         break;
//
//       case SearchType.KEYWORD:
//         url += '&q=$keyword&apiKey=${dotenv.get('NEWS_API_TOKEN')}';
//         break;
//
//       case SearchType.CATEGORY:
//         url +=
//             '&category=${category?.nameEn}&apiKey=${dotenv.get('NEWS_API_TOKEN')}';
//         break;
//     }
//
//     response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       final responseBody = response.body;
//
//       //
//       // result = News.fromJson(jsonDecode(responseBody) as Map<String, dynamic>)
//       //     .articles;
//       //
//
//       /// TODO DB使用への変更
//       result = await insertAndReadNewsFromDB(
//           jsonDecode(responseBody) as Map<String, dynamic>);
//     } else {
//       throw Exception('Failed to load news.');
//     }
//
//     return result;
//   }
//
//   ///
//   Future<List<Article>> insertAndReadNewsFromDB(
//       Map<String, dynamic> responseBody) async {
//     //))))))))))))))))))))))))) TODO DI変更
//     // final dao = myDatabase.newsDao;
//
//     final articles = News.fromJson(responseBody).articles;
//
//     /// TODO DartのモデルクラスからDBのテーブルクラスに変換する
//     final articleRecords = await _dao.insertAndReadNewsFromDB(
//       articles.toArticleRecords(articles),
//     );
//
//     /// TODO DBのテーブルクラスからDartのモデルクラスに変換する
//     return articleRecords.toArticle(articleRecords);
//   }
// }
