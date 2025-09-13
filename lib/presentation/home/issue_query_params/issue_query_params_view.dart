import 'package:could_be/core/components/chips/issue_chip_2.dart';
import 'package:could_be/core/components/loading/chip_loading_view.dart';
import 'package:could_be/domain/entities/issue/issue_query_params.dart';
import 'package:flutter/material.dart';

import '../../../core/components/chips/issue_chip.dart';
import '../../../core/di/di_setup.dart';
import '../../../core/themes/margins_paddings.dart';
import 'issue_query_params_view_model.dart';

class IssueQueryParamsView extends StatelessWidget {
  const IssueQueryParamsView({super.key, required this.viewModel, required this.changeQueryParam});
  final IssueQueryParamsViewModel viewModel;
  final Function (IssueQueryParam ) changeQueryParam;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          final List<IssueQueryParam> queryParams = state.issueQueryParams?.queryParams.where(
            (param) => param.displayName.isNotEmpty).toList() ?? [];
          if(state.isLoading) {
            return ChipLoadingView();
          }else{
            if(queryParams.isEmpty) {
              return Center(child: Text('이슈 카테고리가 없습니다.'));
            }else{
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 28),
                scrollDirection: Axis.horizontal,
                itemCount: queryParams.length,
                itemBuilder: (context, index) {
                  return IssueChip2(
                    title: queryParams[index].displayName,
                    isActive: state.selectedIndex == index,
                    onTap: () {
                      viewModel.setSelectedIndex(index);
                      changeQueryParam(queryParams[index]);
                    },
                  );
                  return IssueChip(
                    padding: index == 0 ? MyPaddings.largeMedium : null,
                    title: queryParams[index].displayName,
                    isActive: state.selectedIndex == index,
                    onTap: () {
                      viewModel.setSelectedIndex(index);
                      changeQueryParam(queryParams[index]);
                    },
                  );
                },
              );
            }
          }
        }
      ),
    );
  }
}
