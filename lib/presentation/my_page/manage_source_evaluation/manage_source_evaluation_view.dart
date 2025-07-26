import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/issue_list/issue_type.dart';
import 'package:could_be/presentation/issue_list/main/issue_list_root.dart';
import 'package:flutter/material.dart';

class ManageSourceEvaluationView extends StatelessWidget {
  const ManageSourceEvaluationView({super.key});

  Widget buildEvaluatedSourceCard() {
    return Container(
      margin: EdgeInsets.only(top: MyPaddings.medium, bottom: MyPaddings.extraLarge),
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
          // Add your card content here
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
        body: Column(
          children: [

          ],
        )
    );
  }
}
