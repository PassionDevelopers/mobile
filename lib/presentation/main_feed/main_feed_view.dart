import 'package:could_be/core/components/app_bar/main_feed_app_bar.dart';
import 'package:could_be/presentation/core/issue_list/refresh.dart';
import 'package:could_be/presentation/home/issue_query_params/issue_query_params_view_model.dart';
import 'package:could_be/presentation/hot_issue/hot_Issue_card_view.dart';
import 'package:could_be/presentation/main_feed/category_row.dart';
import 'package:could_be/core/components/cards/hot_issue_card_2.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/presentation/home/issue_query_params/issue_query_params_view.dart';
import 'package:could_be/presentation/hot_issue/hot_issues_view_model.dart';
import 'package:could_be/presentation/issue_list/issue_type.dart';
import 'package:could_be/presentation/main_feed/main_feed_view_model.dart';
import 'package:flutter/material.dart';

class MainFeedView extends StatelessWidget {
  const MainFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<MainFeedViewModel>();
    final HotIssuesViewModel hotIssuesViewModel = getIt<HotIssuesViewModel>();
    final issueQueryviewModel = getIt<IssueQueryParamsViewModel>();

    return IssueListRefresher(
      onRefresh: () async {
        viewModel.fetchIssuesWithWholeCategories();
        issueQueryviewModel.fetchIssueQueryParams();
        hotIssuesViewModel.fetchHotIssues();
      },
      content: SingleChildScrollView(
        child: Column(
          children: [
            MainFeedAppBar(onPressed: () {}),
            IssueQueryParamsView(
              viewModel: issueQueryviewModel,
              changeQueryParam: viewModel.changeQueryParam,
            ),
            const SizedBox(height: 10),
            HotIssueCardView(viewModel: viewModel, hotIssuesViewModel: hotIssuesViewModel),
            ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                final state = viewModel.state;
                return Column(
                  children:
                      state.issuesWithWholeCategories.categories.map((
                        category,
                      ) {
                        final issues = category.issues;
                        return CategoryRow(
                          category: category.category,
                          isLoading: state.isLoading,
                          issues: issues,
                        );
                      }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
