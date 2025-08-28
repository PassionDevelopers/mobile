import 'package:flutter/material.dart';

void infiniteScrollListener({
  required ScrollController scrollController,
  required VoidCallback onLoadMore,
  double threshold = 100.0,
}) {
  scrollController.addListener(() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - threshold) {
      onLoadMore();
    }
  });
}