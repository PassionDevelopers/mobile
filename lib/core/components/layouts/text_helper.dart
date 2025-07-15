import 'dart:math';

import 'package:flutter/material.dart';

class AutoSizedTabBarView extends StatefulWidget {
  final List<Widget> children;
  final TabController tabController;

  const AutoSizedTabBarView({
    super.key,
    required this.children,
    required this.tabController,
  });

  @override
  State<AutoSizedTabBarView> createState() => _AutoSizedTabBarViewState();
}

class _AutoSizedTabBarViewState extends State<AutoSizedTabBarView> {
  double? _maxHeight;
  final List<GlobalKey> _keys = [];

  @override
  void initState() {
    super.initState();
    _keys.addAll(widget.children.map((e) => GlobalKey()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateMaxHeight();
    });
  }

  void _calculateMaxHeight() {
    double maxHeight = 0;

    for (final key in _keys) {
      final RenderBox? renderBox =
      key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        maxHeight = max(maxHeight, renderBox.size.height);
      }
    }

    if (maxHeight > 400) {
      setState(() {
        _maxHeight = maxHeight;
      });
    }else{
      setState(() {
        _maxHeight = 400; // 최소 높이 설정
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_maxHeight == null) {
      // 높이 계산을 위한 숨겨진 위젯들
      return Stack(
        children: [
          Opacity(
            opacity: 0,
            child: Column(
              children: widget.children.asMap().entries.map((entry) {
                return Container(
                  key: _keys[entry.key],
                  child: entry.value,
                );
              }).toList(),
            ),
          ),
          const Center(child: CircularProgressIndicator()),
        ],
      );
    }

    return SizedBox(
      height: _maxHeight,
      child: TabBarView(
        controller: widget.tabController,
          children: widget.children),
    );
  }
}