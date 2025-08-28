import 'package:flutter/material.dart';
import '../../data/terminology_dictionary.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';
import '../../themes/margins_paddings.dart';

class RichTooltip extends StatelessWidget {
  final TermDefinition termDefinition;
  final VoidCallback onClose;

  const RichTooltip({
    super.key,
    required this.termDefinition,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      constraints: const BoxConstraints(maxHeight: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(MyPaddings.medium),
            decoration: BoxDecoration(
              color: termDefinition.categoryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: termDefinition.categoryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    termDefinition.icon,
                    color: termDefinition.categoryColor,
                    size: 18,
                  ),
                ),
                SizedBox(width: MyPaddings.small),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        termDefinition.term,
                        style: MyFontStyle.h3.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray1,
                        ),
                      ),
                      Text(
                        termDefinition.category,
                        style: TextStyle(
                          fontSize: 11,
                          color: termDefinition.categoryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.gray4.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: AppColors.gray2,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(MyPaddings.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Short Definition
                    Text(
                      termDefinition.shortDef,
                      style: MyFontStyle.reg.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray1,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: MyPaddings.small),

                    // Detailed Definition
                    Text(
                      termDefinition.detailedDef,
                      style: MyFontStyle.reg.copyWith(
                        color: AppColors.gray2,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: MyPaddings.medium),

                    // Statistics
                    if (termDefinition.statistics.isNotEmpty) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.bar_chart,
                            size: 16,
                            color: AppColors.gray3,
                          ),
                          SizedBox(width: MyPaddings.small),
                          Text(
                            '주요 현황',
                            style: MyFontStyle.reg.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MyPaddings.small),
                      ...termDefinition.statistics.entries.map(
                        (entry) => Padding(
                          padding: EdgeInsets.only(bottom: MyPaddings.small),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '• ${entry.key}',
                                style: MyFontStyle.reg.copyWith(
                                  color: AppColors.gray2,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: termDefinition.categoryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  entry.value,
                                  style: MyFontStyle.small.copyWith(
                                    color: termDefinition.categoryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: MyPaddings.small),
                    ],

                    // Examples
                    if (termDefinition.examples.isNotEmpty) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            size: 16,
                            color: AppColors.gray3,
                          ),
                          SizedBox(width: MyPaddings.small),
                          Text(
                            '주요 사례',
                            style: MyFontStyle.small.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MyPaddings.small),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: termDefinition.examples
                            .map(
                              (example) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.gray5,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  example,
                                  style: MyFontStyle.small.copyWith(
                                    color: AppColors.gray2,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: MyPaddings.small),
                    ],

                    // Related Terms
                    if (termDefinition.relatedTerms.isNotEmpty) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.link,
                            size: 16,
                            color: AppColors.gray3,
                          ),
                          SizedBox(width: MyPaddings.small),
                          Text(
                            '관련 용어',
                            style: MyFontStyle.small.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MyPaddings.small),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: termDefinition.relatedTerms
                            .map(
                              (term) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: termDefinition.categoryColor.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  term,
                                  style: MyFontStyle.small.copyWith(
                                    color: termDefinition.categoryColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: MyPaddings.small),
                    ],

                    // Source
                    Container(
                      padding: EdgeInsets.all(MyPaddings.small),
                      decoration: BoxDecoration(
                        color: AppColors.gray5.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 12,
                            color: AppColors.gray3,
                          ),
                          SizedBox(width: MyPaddings.small),
                          Text(
                            '출처: ${termDefinition.source}',
                            style: MyFontStyle.small.copyWith(
                              color: AppColors.gray3,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}