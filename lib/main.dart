import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'di/providers.dart';
import 'models/db/database.dart';
import 'screens/home_screen.dart';

late MyDatabase myDatabase;

void main() async {
  myDatabase = MyDatabase();

  await dotenv.load();

  runApp(
    MultiProvider(
      //))))))))))))))))))))))))) TODO DI変更
      // providers: [
      //   ChangeNotifierProvider<NewsListViewModel>(
      //     create: (context) => NewsListViewModel(),
      //   ),
      //   ChangeNotifierProvider<HeadLineViewModel>(
      //     create: (context) => HeadLineViewModel(),
      //   ),
      // ],

      providers: globalProviders,
      //))))))))))))))))))))))))) TODO DI変更

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
