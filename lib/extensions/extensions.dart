import '../models/db/database.dart';
import '../models/news.dart';

/// TODO dartのモデルクラスからDBのテーブルクラスへの変換
extension ConvertToArticleRecord on List<Article> {
  List<ArticleRecord> toArticleRecords(List<Article> articles) {
    final list = <ArticleRecord>[];

    articles.forEach(
      (element) {
        list.add(
          ArticleRecord(
            title: element.title ?? '',
            description: element.description ?? '',
            url: element.url ?? '',
            urlToImage: element.urlToImage ?? '',
            publishDate: element.publishDate ?? '',
            content: element.content ?? '',
          ),
        );
      },
    );

    return list;
  }
}

/// TODO DBのテーブルクラスからdartのモデルクラスへの変換
extension ConvertToArticle on List<ArticleRecord> {
  List<Article> toArticle(List<ArticleRecord> articleRecords) {
    final list = <Article>[];

    articleRecords.forEach((element) {
      list.add(
        Article(
          title: element.title,
          description: element.description,
          url: element.url,
          urlToImage: element.urlToImage,
          publishDate: element.publishDate,
          content: element.content,
        ),
      );
    });

    return list;
  }
}
