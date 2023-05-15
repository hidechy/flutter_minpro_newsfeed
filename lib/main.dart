import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:test_minpro_newsfeed/viewmodels/head_line_viewmodel.dart';

import 'screens/home_screen.dart';
import 'viewmodels/news_list_viewmodel.dart';

void main() async {
  await dotenv.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsListViewModel>(
          create: (context) => NewsListViewModel(),
        ),
        ChangeNotifierProvider<HeadLineViewModel>(
          create: (context) => HeadLineViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
