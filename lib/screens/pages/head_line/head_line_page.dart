import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/search_type.dart';
import '../../../viewmodels/head_line_viewmodel.dart';

class HeadLinePage extends StatelessWidget {
  const HeadLinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HeadLineViewModel>();

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(
        () => viewModel.getHeadLines(
          searchType: SearchType.HEAD_LINE,
        ),
      );
    }

    return Scaffold(
      body: const SafeArea(
        child: Column(
          children: [
            Text('HeadLinePage'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onRefresh(context: context);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  ///
  Future<void> onRefresh({required BuildContext context}) async {
    final viewModel = context.read<HeadLineViewModel>();

    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }
}
