import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool _selected = false;

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedContainer(
            width: _selected ? 300 : 100,
            height: _selected ? 100 : 25,
            duration: const Duration(milliseconds: 500),
            child: const AutoSizeText(
              'NewsFeedApp',
              style: TextStyle(fontSize: 40),
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selected = !_selected;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
