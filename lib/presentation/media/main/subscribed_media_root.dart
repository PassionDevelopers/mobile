import 'package:could_be/presentation/media/main/subscribed_media_view.dart';
import 'package:could_be/presentation/media/main/subscribed_media_view_model.dart';
import 'package:flutter/material.dart';

import '../../../core/di/use_case/use_case.dart';
import '../subscribed_media_loading_view.dart';

class SubscribedMediaRoot extends StatelessWidget {
  const SubscribedMediaRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = SubscribedMediaViewModel(
      fetchMediaUseCase: fetchMediaUseCase,
    );
    return ListenableBuilder(listenable: viewModel, builder: (context, _) {
      final state = viewModel.state;
      if (state.isLoading) {
        return SubscribedMediaLoadingView();
      }else{
        if(state.media == null){
          return Center(child: Text('No subscribed media found'));
        } else {
          return SubscribedMediaView(media: state.media!);
        }
      }

    });
  }
}
