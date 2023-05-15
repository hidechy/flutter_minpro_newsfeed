import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../data/category_info.dart';
import '../data/search_type.dart';
import '../models/news.dart';

class NewsRepository {
  ///
  Future<List<Article>> getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    var result = <Article>[];

    // TODO [jp]だと画像のurlが取得できない
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

      result = News.fromJson(jsonDecode(responseBody) as Map<String, dynamic>)
          .articles;
    } else {
      throw Exception('Failed to load news.');
    }

    return result;
  }
}
