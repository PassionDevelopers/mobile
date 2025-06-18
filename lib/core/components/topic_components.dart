import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation/routes/get_route_names.dart';
import '../../presentation/themes/margins_paddings.dart';
import '../../presentation/themes/radiuses.dart';
import '../../ui/color.dart';
import '../../ui/fonts.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({super.key, required this.title, required this.isBack});
  final String title;
  final bool isBack;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if(isBack)  {
            Get.back();
          }else{
            Get.toNamed(RouteNames.topicDetail, arguments: title);
          }
        },
        borderRadius: BorderRadius.all(MyRadiuses.large),
        child: AspectRatio(
          aspectRatio: 2.5,
          child: Ink(
            width: double.infinity,
            padding: EdgeInsets.all(MyPaddings.large),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 토픽 이름
                Expanded(flex: 10, child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.h1(title,),
                    IconButton(
                        onPressed: () {
                        },
                        icon: Icon(Icons.favorite_border, color: AppColors.secondary,
                        )),
                    // IconButton(
                    //     onPressed: () {
                    //       Get.toNamed('/topic/delete', arguments: title);
                    //     },
                    //     icon: Icon(Icons.notifications_none_rounded, color: AppColors.primaryLight2, size: 20,
                    // )),
                  ],
                )),
                Spacer(flex: 1),
                // 숫자와 증가율
                Expanded(flex: 10, child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyText.accent('3,567'),
                    SizedBox(width: 8),
                    MyText.h3('개 이슈', color: AppColors.textSecondary)
                  ],
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
