import 'package:could_be/core/components/loading/chip_loading_view.dart';
import 'package:could_be/domain/entities/issue_query_params.dart';
import 'package:flutter/material.dart';

import '../../../core/components/chips/issue_chip.dart';
import '../../../core/di/di_setup.dart';
import '../../../core/themes/margins_paddings.dart';
import 'issue_query_params_view_model.dart';

class IssueQueryParamsView extends StatelessWidget {
  const IssueQueryParamsView({super.key, required this.changeQueryParam});
  final void Function(IssueQueryParam issueQueryParam) changeQueryParam;
  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<IssueQueryParamsViewModel>();
    return Container(
      height: 50,
      padding: EdgeInsets.only(top: MyPaddings.medium),
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
                scrollDirection: Axis.horizontal,
                itemCount: queryParams.length,
                itemBuilder: (context, index) {
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
