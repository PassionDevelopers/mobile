import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';

class BlindSpotView extends StatelessWidget {
  const BlindSpotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [

            // IssueQueryParamsView(changeQueryParam: viewModel.changeQueryParam),
            // const SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: HotIssueCard2(),
            // ),
            // ListenableBuilder(listenable: viewModel, builder: (context, _) {
            //   final state = viewModel.state;
            //   if (state.isLoading || state.issuesWithWholeCategories == null) {
            //     return CircularProgressIndicator();
            //   } else {
            //     return Column(
            //       children: state.issuesWithWholeCategories!.categories.map((category) {
            //         final issues = category.issues;
            //         return CategoryRow(category: category.category, issues: issues);
            //       }).toList(),
            //     );
            //   }
            // }),
          ],
        ),
      ),
    );
  }
}
