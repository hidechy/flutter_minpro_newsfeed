// ignore_for_file: strict_raw_type

import 'package:drift/drift.dart';

import 'database.dart';

part 'dao.g.dart';

///
@DriftAccessor(tables: [ArticleRecords])
class NewsDao extends DatabaseAccessor<MyDatabase> with _$NewsDaoMixin {
  NewsDao(super.db);

  ///
  Future clearDB() {
    return delete(articleRecords).go();
  }

  /// TODO バルクインサート
  Future insertDB(List<ArticleRecord> articles) async {
    await batch((batch) {
      batch.insertAll(articleRecords, articles);
    });
  }

  ///
  Future<List<ArticleRecord>> get articlesFromDB {
    return select(articleRecords).get();
  }

  /// TODO トランザクション処理
  Future<List<ArticleRecord>> insertAndReadNewsFromDB(
    List<ArticleRecord> articles,
  ) {
    return transaction(
      () async {
        await clearDB();
        await insertDB(articles);
        return articlesFromDB;
      },
    );
  }
}
