import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/presentation/media/media_profile_component.dart';
import 'package:could_be/presentation/media/whole_media/whole_media_view_model.dart';
import 'package:flutter/material.dart';
import '../../../core/themes/margins_paddings.dart';

class WholeMediaView extends StatelessWidget {
  const WholeMediaView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<WholeMediaViewModel>();

    return MyScaffold(
      appBarTitle: '관심 매체 설정',
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.sources == null || state.sources!.sources.isEmpty) {
            return Center(child: Text('현재 매체 정보를 불러올 수 없습니다.'));
          } else {
            final sources = state.sources!.sources;
            return GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: MyPaddings.largeMedium,
                vertical: MyPaddings.medium,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.7,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemCount: sources.length,
              itemBuilder: (context, index) {
                final source = sources[index];
                return MediaProfile(source: source,
                  isShowingArticles: false, onSubscribe: (){
                    viewModel.manageSourceSubscriptionBySourceId(source.id);
                  },);
              },
            );
          }
        },
      ),
    );
  }
}
