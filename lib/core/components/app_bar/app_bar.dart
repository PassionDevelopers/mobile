import 'package:could_be/presentation/search/search_field.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

import '../../themes/color.dart';
import '../../responsive/responsive_utils.dart';
import '../../themes/margins_paddings.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key, required this.onSearchSubmitted});
  final void Function(String query) onSearchSubmitted;

  Widget _buildLogo() {
    final toolbarHeight = AppBar().preferredSize.height;

    return Ink(
      color: AppColors.white,
      height: toolbarHeight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MyPaddings.mediumLarge.toDouble(),
          ),
          child: Image.asset('assets/images/logo/logo_black.jpeg', height: 40),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MySearchField(
      onSearchSubmitted: onSearchSubmitted,
      // onNoticePressed: (){
      //   context.push(RouteNames.notice);
      // },
    );
  }
}





