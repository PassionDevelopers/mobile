import 'package:could_be/core/components/cards/issue_card_2.dart';
import 'package:could_be/core/method/category_method.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/domain/entities/issue/issue.dart';
import 'package:could_be/presentation/main_feed/category_row_loading.dart';
import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  final List<Issue> issues;
  final String category;
  final bool isLoading;

  const CategoryRow({
    super.key,
    required this.isLoading,
    required this.category,
    required this.issues,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.h3(getCategoryDisplayName(category)),
                GestureDetector(
                  onTap: () {},
                  child: MyText.reg(
                    '더보기',
                    textAlign: TextAlign.right,
                    color: AppColors.gray700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 211,
            width: double.infinity,
            child:
                isLoading
                    ? CategoryRowLoading()
                    : issues.isNotEmpty
                    ? ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 11),
                      itemBuilder: (context, index) {
                        return IssueCard2(issue: issues[index]);
                      },
                      itemCount: issues.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                    )
                    : Center(
                      child: MyText.reg(
                        '해당 카테고리에 이슈가 없습니다.',
                        color: AppColors.gray600,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
