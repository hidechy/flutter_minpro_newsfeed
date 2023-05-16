import 'package:flutter/material.dart';

import 'pages/about_us/about_us_page.dart';
import 'pages/head_line/head_line_page.dart';
import 'pages/news_list/news_list_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pages = [
    const HeadLinePage(),
    const NewsListPage(),
    const AboutUsPage(),
  ];

  int _currentIndex = 0;

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.highlight),
            label: 'トップニュース',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'ニュース一覧',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'このアプリについて',
          ),
        ],
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
      ),
    );
  }
}
