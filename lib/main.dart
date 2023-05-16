import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'di/providers.dart';

//))))))))))))))))))))))))) TODO DI変更
//import 'models/db/database.dart';
//))))))))))))))))))))))))) TODO DI変更
import 'screens/home_screen.dart';

//))))))))))))))))))))))))) TODO DI変更
//late MyDatabase myDatabase;
//))))))))))))))))))))))))) TODO DI変更

void main() async {
//))))))))))))))))))))))))) TODO DI変更
//  myDatabase = MyDatabase();
//))))))))))))))))))))))))) TODO DI変更

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
