import 'dart:developer';

import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/app_bar/reg_app_bar.dart';
import 'package:could_be/core/components/cards/source_evaluate_card.dart';
import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/issue_list/issue_type.dart';
import 'package:could_be/presentation/issue_list/main/issue_list_root.dart';
import 'package:could_be/presentation/my_page/manage_source_evaluation/manage_source_evaluation_view_model.dart';
import 'package:flutter/material.dart';

class ManageSourceEvaluationView extends StatelessWidget {
  const ManageSourceEvaluationView({super.key});

  Widget buildEvaluatedSourceCard() {
    return Container(
      margin: EdgeInsets.only(
        top: MyPaddings.medium,
        bottom: MyPaddings.extraLarge,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // SourceEvaluateCard(userEvaluatedPerspective: userEvaluatedPerspective, onBiasSelected: onBiasSelected)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<ManageSourceEvaluationViewModel>();
    return RegScaffold(
      isScrollPage: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            RegAppBar(title: '평가한 언론'),
            ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                final state = viewModel.state;
                if (state.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.sources == null || state.sources!.sources.isEmpty) {
                  return Center(
                    child: NotFound(notFoundType: NotFoundType.source)
                  );
                }
                return Column(
                  children: state.sources!.sources.map((source) {
                        log('source: ${source.name}, perspective: ${source.userEvaluatedPerspective?.toPerspective()}');
                        return SourceEvaluateCard(
                          source: source,
                          onBiasSelected: (bias) {
                            viewModel.manageSourceEvaluation(sourceId: source.id, perspective: bias);
                          },
                          userEvaluatedPerspective: source.userEvaluatedPerspective?.toPerspective(),
                        );
                      }).toList(),
                );
              },
            ),
            BottomSafePadding()
          ],
        ),
      ),
    );
  }
}
