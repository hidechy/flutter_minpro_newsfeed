// ignore_for_file: library_private_types_in_public_api

/*
        PageTransformerを使ってスムーズなページ移動を実現させよう
        （この人の作ったクラスを使わせてもらおう：page_transformer.dartをコピーして使わせてもらおう）
        https://github.com/roughike/page-transformer
        https://github.com/roughike/page-transformer/blob/master/lib/page_transformer.dart
*/

import 'package:flutter/material.dart';

/// A function that builds a [PageView] lazily.
typedef PageViewBuilder = PageView Function(
    BuildContext context, PageVisibilityResolver visibilityResolver);

/// A class that can be used to compute visibility information about
/// the current page.
class PageVisibilityResolver {
  PageVisibilityResolver({
    ScrollMetrics? metrics,
    double? viewPortFraction,
  })  : _pageMetrics = metrics,
        _viewPortFraction = viewPortFraction;

  final ScrollMetrics? _pageMetrics;
  final double? _viewPortFraction;

  /// Calculates visibility information for the page at [pageIndex].
  /// Used inside PageViews' itemBuilder, but can be also used in a
  /// simple PageView that simply has an array of children passed to it.
  PageVisibility resolvePageVisibility(int pageIndex) {
    final pagePosition = _calculatePagePosition(pageIndex);
    final visiblePageFraction =
        _calculateVisiblePageFraction(pageIndex, pagePosition);

    return PageVisibility(
      visibleFraction: visiblePageFraction,
      pagePosition: pagePosition,
    );
  }

  double _calculateVisiblePageFraction(int index, double pagePosition) {
    if (pagePosition > -1.0 && pagePosition <= 1.0) {
      return 1.0 - pagePosition.abs();
    }

    return 0;
  }

  double _calculatePagePosition(int index) {
    final viewPortFraction = _viewPortFraction ?? 1.0;
    final pageViewWidth =
        (_pageMetrics?.viewportDimension ?? 1.0) * viewPortFraction;
    final pageX = pageViewWidth * index;
    final scrollX = _pageMetrics?.pixels ?? 0.0;
    final pagePosition = (pageX - scrollX) / pageViewWidth;
    final safePagePosition = !pagePosition.isNaN ? pagePosition : 0.0;

    if (safePagePosition > 1.0) {
      return 1;
    } else if (safePagePosition < -1.0) {
      return -1;
    }

    return safePagePosition;
  }
}

/// A class that contains visibility information about the current page.
class PageVisibility {
  PageVisibility({
    required this.visibleFraction,
    required this.pagePosition,
  });

  /// How much of the page is currently visible, between 0.0 and 1.0.
  ///
  /// For example, if only the half of the page is visible, the
  /// value of this is going to be 0.5.
  ///
  /// This doesn't contain information about where the page is
  /// disappearing to or appearing from. For that, see [pagePosition].
  final double visibleFraction;

  /// Tells the position of this page, relative to being visible in
  /// a "non-dragging" position, between -1.0 and 1.0.
  ///
  /// For example, if the page is fully visible, this value equals 0.0.
  ///
  /// If the page is fully out of view on the right, this value is
  /// going to be 1.0.
  ///
  /// Likewise, if the page is fully out of view, on the left, this
  /// value is going to be -1.0.
  final double pagePosition;
}

/// A widget for getting useful information about a pages' position
/// and how much of it is visible in a PageView.
///
/// Note: Does not transform pages in any way, but provides the means
/// to easily do it, in the form of [PageVisibility].
class PageTransformer extends StatefulWidget {
  const PageTransformer({
    super.key,
    required this.pageViewBuilder,
  });

  final PageViewBuilder pageViewBuilder;

  @override
  _PageTransformerState createState() => _PageTransformerState();
}

class _PageTransformerState extends State<PageTransformer> {
  PageVisibilityResolver? _visibilityResolver;

  @override
  Widget build(BuildContext context) {
    final pageView = widget.pageViewBuilder(
        context, _visibilityResolver ?? PageVisibilityResolver());

    final controller = pageView.controller;
    final viewPortFraction = controller.viewportFraction;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        setState(() {
          _visibilityResolver = PageVisibilityResolver(
            metrics: notification.metrics,
            viewPortFraction: viewPortFraction,
          );
        });
        return false;
      },
      child: pageView,
    );
  }
}
