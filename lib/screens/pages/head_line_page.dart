import 'package:flutter/material.dart';

class HeadLinePage extends StatelessWidget {
  const HeadLinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('HeadLinePage'),
          ],
        ),
      ),
    );
  }
}
