import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/entities/article/article.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../themes/color.dart';
import '../../method/date_time_parsing.dart';
import '../../responsive/responsive_utils.dart';
import '../../themes/margins_paddings.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onWebViewSelected;
  final bool? isSelected;

  const NewsCard({
    super.key,
    required this.article,
    this.onWebViewSelected,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        if (onWebViewSelected != null) {
          onWebViewSelected!();
        } else {
          context.push(
            RouteNames.webView,
            extra: {
              'articleInfo': (
              [article],
              article.id,
              article.source.id,
              ),
            },
          );
        }
      },
      child: Ink(
        height: 103,
        padding: EdgeInsets.symmetric(horizontal: MyPaddings.large, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected == true ? AppColors.black.withAlpha(50) : null,
        ),
        child: Ink(
          child: Row(
            children: [
              ImageContainer(height: double.infinity, width: 83, borderRadius: BorderRadius.circular(6), imageUrl: article.imageUrl),
              const SizedBox(width: MyPaddings.large,),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.h3(article.title, maxLines: 2),
                    Spacer(),
                    MyText.small('${article.source.name} · ${getTimeAgo(article.publishedAt)}', color: AppColors.gray700),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
