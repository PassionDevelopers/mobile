import 'package:could_be/core/components/loading/issue_card_2_skeleton.dart';
import 'package:flutter/material.dart';

class CategoryRowLoading extends StatelessWidget {
  const CategoryRowLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 11),
      itemBuilder: (context, index) {
        return IssueCard2Skeleton();
      },
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
    );
  }
}
