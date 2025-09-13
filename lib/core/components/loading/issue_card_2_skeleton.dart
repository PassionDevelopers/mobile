import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/components/bias/bias_bar.dart';
import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/loading/basic_skeleton.dart';
import 'package:could_be/core/components/title/issue_info_title.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/domain/entities/issue/issue.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IssueCard2Skeleton extends StatelessWidget {

  const IssueCard2Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 211,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicSkeleton(height: 100,),
          SizedBox(height: 16),
          BasicSkeleton(height: 10,),
          SizedBox(height: 5),
          BasicSkeleton(height: 10, width: 80,),
          SizedBox(height: 10),
          BasicSkeleton(height: 4,),
          SizedBox(height: 10),
          BasicSkeleton(height: 10, width: 100,),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
