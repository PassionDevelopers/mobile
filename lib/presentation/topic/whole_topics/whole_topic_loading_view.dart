import 'package:flutter/cupertino.dart';

class WholeTopicLoadingView extends StatelessWidget {
  const WholeTopicLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 20.0,
      ),
    );
  }
}
