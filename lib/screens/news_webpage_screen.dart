import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/news.dart';

class NewsWebpageScreen extends StatefulWidget {
  const NewsWebpageScreen({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  State<NewsWebpageScreen> createState() => _NewsWebpageScreenState();
}

class _NewsWebpageScreenState extends State<NewsWebpageScreen> {
  late WebViewController webViewController;

  ///
  @override
  void initState() {
    super.initState();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.article.url!));
  }

  ///
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.article.title ?? ''),
          centerTitle: true,
        ),
        body: WebViewWidget(
          controller: webViewController,
        ),
      ),
    );
  }
}
