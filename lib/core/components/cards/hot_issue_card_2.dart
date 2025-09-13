import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/domain/entities/issue/hot_issues.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HotIssueCard2 extends StatelessWidget {
  const HotIssueCard2({super.key, required this.updateTime, required this.hotIssues});
  final DateTime updateTime;
  final HotIssues hotIssues;
  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 108,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF59616E), width: 1),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(11.0),
              child: Image.asset('assets/images/icon/background.png', fit: BoxFit.cover, width: double.infinity, height: double.infinity,)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 105,
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Image.asset('assets/images/icon/news.png', fit: BoxFit.contain),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 5,
                      children: [
                        Text(
                          '10분 전 업데이트',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: const Color(0xFFB0B8C2),
                            fontSize: 9,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 1.11,
                          ),
                        ),
                        Text(
                          '바쁘신가요?\n이것만 보세요.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () {
                context.push(RouteNames.hotIssueFeed, extra: hotIssues);
                UnifiedAnalyticsHelper.logEvent(name: AnalyticsEventNames.openHotIssues);
              },
              child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              width: double.infinity,
              height: double.infinity,
            )),
          )
        ],
      ),
    );
  }
}
