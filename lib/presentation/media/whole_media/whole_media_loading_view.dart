import 'package:flutter/cupertino.dart';

class WholeMediaLoadingView extends StatelessWidget {
  const WholeMediaLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 20.0,
      ),
    );
  }
}
