import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../models/db/dao.dart';
import '../models/db/database.dart';
import '../repository/news_repository.dart';
import '../viewmodels/head_line_viewmodel.dart';
import '../viewmodels/news_list_viewmodel.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider(
    create: (_) {
      return MyDatabase();
    },
    dispose: (_, db) {
      db.close();
    },
  )
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MyDatabase, NewsDao>(update: (_, db, dao) {
    return NewsDao(db);
  }),
  ProxyProvider<NewsDao, NewsRepository>(
    update: (_, dao, repository) {
      return NewsRepository(dao: dao);
    },
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<HeadLineViewModel>(
    create: (context) {
      return HeadLineViewModel(repository: context.read<NewsRepository>());
    },
  ),
  ChangeNotifierProvider<NewsListViewModel>(
    create: (context) {
      return NewsListViewModel(repository: context.read<NewsRepository>());
    },
  ),
];
