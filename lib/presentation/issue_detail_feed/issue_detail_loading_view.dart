import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/issue_detail_feed/components/move_to_next_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class IssueDetailLoadingView extends StatefulWidget {
  const IssueDetailLoadingView({super.key});

  @override
  State<IssueDetailLoadingView> createState() => _IssueDetailLoadingViewState();
}

class _IssueDetailLoadingViewState extends State<IssueDetailLoadingView> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 60.0,
                      margin: EdgeInsets.only(
                          top: MyPaddings.small
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(height: MyPaddings.small),
                    Container(
                      width: 180.0,
                      height: 15.0,
                      margin: EdgeInsets.only(bottom: MyPaddings.small),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(height: MyPaddings.small),
                    Container(
                      width: double.infinity,

                      height: 30.0,
                      margin: EdgeInsets.only(bottom: MyPaddings.small),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(height: MyPaddings.small),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MyPaddings.large),
            // MoveToNextButton(
            //   moveToNextPage: () {},
            //   buttonText: '성향별 보도 내용 보기',
            // ),
          ],
        ));
  }
}

