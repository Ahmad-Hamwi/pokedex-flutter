import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../widgets/circular_progress.dart';
import '../widgets/layout_empty.dart';
import '../widgets/layout_error.dart';
import '../widgets/layout_no_more_data.dart';
import '../widgets/layout_page_error.dart';

class PagedBuilderDelegate<ItemType>
    extends PagedChildBuilderDelegate<ItemType> {
  // ignore: annotate_overrides, overridden_fields
  final ItemWidgetBuilder<ItemType> itemBuilder;
  final VoidCallback onRetryOnFail;
  final VoidCallback onRefresh;
  final String? emptyMessage;
  final bool? showNoMoreDataMessage;

  PagedBuilderDelegate(
      {required this.itemBuilder,
      required this.onRetryOnFail,
      required this.onRefresh,
      this.showNoMoreDataMessage,
      this.emptyMessage})
      : super(
          transitionDuration: const Duration(milliseconds: 200),
          itemBuilder: itemBuilder,
          firstPageProgressIndicatorBuilder: (context) =>
              const CircularProgressWidget(),
          newPageProgressIndicatorBuilder: (context) => const Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressWidget(),
          ),
          firstPageErrorIndicatorBuilder: (context) => LayoutError(
            onRetry: onRetryOnFail,
          ),
          newPageErrorIndicatorBuilder: (context) =>
              LayoutPageError(onRetry: onRetryOnFail),
          noItemsFoundIndicatorBuilder: (context) => LayoutEmpty(
            onRefresh: onRefresh,
            text: emptyMessage,
          ),
          noMoreItemsIndicatorBuilder: showNoMoreDataMessage == null
              ? (context) => const LayoutNoMoreData()
              : showNoMoreDataMessage
                  ? (context) => const LayoutNoMoreData()
                  : null,
          animateTransitions: true,
        );
}
