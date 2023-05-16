/// TODO repositoryのChangeNotifier化
//import 'package:path/path.dart';

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

  /// TODO repositoryのChangeNotifier化

  // ProxyProvider<NewsDao, NewsRepository>(
  //   update: (_, dao, repository) {
  //     return NewsRepository(dao: dao);
  //   },
  // ),

  ChangeNotifierProvider<NewsRepository>(
    create: (context) => NewsRepository(
      dao: context.read<NewsDao>(),
    ),
  ),

  /// TODO repositoryのChangeNotifier化
];

List<SingleChildWidget> viewModels = [
  /// TODO repositoryのChangeNotifier化

  // ChangeNotifierProvider<HeadLineViewModel>(
  //   create: (context) {
  //     return HeadLineViewModel(repository: context.read<NewsRepository>());
  //   },
  // ),

  ChangeNotifierProxyProvider<NewsRepository, HeadLineViewModel>(
    create: (context) {
      return HeadLineViewModel(repository: context.read<NewsRepository>());
    },
    update: (context, repository, viewModel) {
      return viewModel!..onRepositoryUpdated(repository);
    },
  ),

  /// TODO repositoryのChangeNotifier化

  /// TODO repositoryのChangeNotifier化
  // ChangeNotifierProvider<NewsListViewModel>(
  //   create: (context) {
  //     return NewsListViewModel(repository: context.read<NewsRepository>());
  //   },
  // ),

  ChangeNotifierProxyProvider<NewsRepository, NewsListViewModel>(
    create: (context) {
      return NewsListViewModel(repository: context.read<NewsRepository>());
    },
    update: (context, repository, viewModel) {
      return viewModel!..onRepositoryUpdated(repository);
    },
  ),

  /// TODO repositoryのChangeNotifier化
];
