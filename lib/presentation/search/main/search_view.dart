import 'package:could_be/presentation/search/search_field.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/search/search_result_view.dart';
import 'package:could_be/presentation/search/main/search_view_model.dart';
import 'package:could_be/presentation/topic/whole_topics/whole_topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.wholeTopicViewModel});
  final WholeTopicViewModel wholeTopicViewModel;
  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<SearchViewModel>();

    return RegScaffold(
      isScrollPage: true,
      body: Ink(
        color: AppColors.white,
        child: Column(
          children: [
            const SizedBox(height: 26,),
            Row(
              children: [
                const SizedBox(width: MyPaddings.large,),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back_ios_new)),
                const SizedBox(width: MyPaddings.large,),
                Expanded(child: MySearchField(onSearchSubmitted: viewModel.searchTopics)),
                const SizedBox(width: MyPaddings.large,),
                ListenableBuilder(listenable: viewModel, builder: (context, _) {
                  final state = viewModel.state;
                  if(state.isLoading || state.searchedTopics == null){
                    return SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.gray700,),
                    );
                  }else{
                    return SearchResultView(searchedTopics: state.searchedTopics!,
                        manageTopicSubscription: wholeTopicViewModel.manageTopicSubscription);
                  }
                  return SizedBox.shrink();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
