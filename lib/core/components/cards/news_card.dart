import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/issue.dart';
import '../../../presentation/routes/get_route_names.dart';
import '../../../presentation/themes/margins_paddings.dart';
import '../../../ui/color.dart';
import '../bias_bar.dart';
import '../chips/key_word_chip_component.dart';
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
class NewsCard extends StatelessWidget {
  final Issue issue;
  final bool isDailyIssue;

  const NewsCard({super.key, required this.issue, required this.isDailyIssue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MyPaddings.large, vertical: MyPaddings.small),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: (){
          // Get.toNamed(RouteNames.feed);
          Get.toNamed(RouteNames.shortsView, arguments: issue.id);
          // Get.to(NewsApp());
        },
        child: Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.card),
          child: Column(
            children: [
              if(isDailyIssue) Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(16)), color: AppColors.hover),
                    child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network('https://picsum.photos/1000/500', fit: BoxFit.cover,))
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(MyPaddings.large, isDailyIssue? MyPaddings.medium : MyPaddings.large, MyPaddings.large, MyPaddings.large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            issue.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ),
                        // if (issue.getBlindSpot() != null) BlindChip(isRightBlind: issue.getBlindSpot()!, )
                      ],
                    ),
                    SizedBox(height: MyPaddings.large),
                    SizedBox(
                      height: 32,
                      child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                        return KeyWordChip(title: issue.keywords[index],);
                      }, itemCount: issue.keywords.length, shrinkWrap: true,),
                    ),
                    // Bias Bar
                    SizedBox(height: MyPaddings.medium),
                    CardBiasBar(coverageSpectrum: issue.coverageSpectrum,),
                    SizedBox(height: MyPaddings.medium),
                    Row(
                      children: [
                        Icon(Icons.article_outlined, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          '${issue.coverageSpectrum.total}개 매체',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        // Text(
                        //   issue.getTimeAgo(),
                        //   style: TextStyle(
                        //     fontSize: 13,
                        //     color: Colors.grey[600],
                        //   ),
                        // ),
                        SizedBox(width: 16),
                        Icon(Icons.visibility, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          issue.view.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
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