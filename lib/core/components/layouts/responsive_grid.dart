import 'package:flutter/material.dart';
import '../../responsive/responsive_utils.dart';
import '../../responsive/responsive_constants.dart';
import '../../themes/margins_paddings.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final ResponsiveGridType gridType;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.gridType = ResponsiveGridType.adaptive,
  });

  final double spacing = 8;
  final double runSpacing = 8;
  final int desktopColumns = ResponsiveBreakpoints.desktopColumns;
  final int smallDesktopColumns = ResponsiveBreakpoints.smallDesktopColumns;
  final int mobileColumns = ResponsiveBreakpoints.mobileColumns;
  final int tabletColumns = ResponsiveBreakpoints.tabletColumns;
  final EdgeInsetsGeometry padding = EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {

    final columns = _getColumns(context);
    final actualPadding = padding;

    return Padding(
      padding: actualPadding,
      child: _buildGrid(context, columns),
    );
  }


  int _getColumns(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return mobileColumns ?? ResponsiveBreakpoints.mobileColumns;
    } else if (ResponsiveUtils.isTablet(context)) {
      return tabletColumns ?? ResponsiveBreakpoints.tabletColumns;
    } else {
      return desktopColumns ?? ResponsiveBreakpoints.desktopColumns;
    }
  }

  Widget _buildGrid(BuildContext context, int columns) {
    switch (gridType) {
      case ResponsiveGridType.fixed:
        return _buildFixedGrid(columns);
      case ResponsiveGridType.staggered:
        return _buildStaggeredGrid(columns);
      case ResponsiveGridType.adaptive:
      default:
        return _buildAdaptiveGrid(context, columns);
    }
  }

  Widget _buildFixedGrid(int columns) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: runSpacing,
        childAspectRatio: 1.0,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }

  Widget _buildStaggeredGrid(int columns) {
    // 스태거드 그리드 구현 (간단한 버전)
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: children,
    );
  }

  Widget _buildAdaptiveGrid(BuildContext context, int columns) {
    if (columns == 1) {
      return Column(
        children: children
            .map((child) => Container(
                  margin: EdgeInsets.only(bottom: runSpacing),
                  child: child,
                ))
            .toList(),
      );
    }

    List<Widget> rows = [];
    for (int i = 0; i < children.length; i += columns) {
      List<Widget> rowChildren = [];
      for (int j = 0; j < columns && i + j < children.length; j++) {
        rowChildren.add(
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: j < columns - 1 ? spacing : 0,
              ),
              child: children[i + j],
            ),
          ),
        );
      }
      
      // 마지막 행에서 컬럼이 부족한 경우 빈 공간 추가
      while (rowChildren.length < columns) {
        rowChildren.add(Expanded(child: SizedBox()));
      }

      rows.add(
        Container(
          margin: EdgeInsets.only(
            bottom: i + columns < children.length ? runSpacing : 0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowChildren,
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}

class ResponsiveGridItem extends StatelessWidget {
  final Widget child;
  final int? flex;

  const ResponsiveGridItem({
    super.key,
    required this.child,
    this.flex,
  });

  @override
  Widget build(BuildContext context) {
    if (flex != null) {
      return Expanded(
        flex: flex!,
        child: child,
      );
    }
    return child;
  }
}

class ResponsiveWrap extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final EdgeInsets? padding;

  const ResponsiveWrap({
    super.key,
    required this.children,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final actualPadding = padding ?? ResponsiveUtils.getResponsivePadding(
      context,
      mobile: MyPaddings.small.toDouble(),
      tablet: MyPaddings.medium.toDouble(),
      desktop: MyPaddings.large.toDouble(),
    );

    return Padding(
      padding: actualPadding,
      child: Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        alignment: alignment,
        runAlignment: runAlignment,
        children: children,
      ),
    );
  }
}