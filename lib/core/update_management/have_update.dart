import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/data/data_source/local/user_preferences.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upgrader/upgrader.dart';

import '../components/alert/dialog.dart';

class HaveUpdate extends StatelessWidget {
  const HaveUpdate({super.key, required this.latestVersionNow});
  final String latestVersionNow;

  @override
  Widget build(BuildContext context) {
    ignored() {
      showConfirm(context: context, msg: '이번 앱 업데이트를 건너뛰시겠습니까?',
        callback: (){
        UserPreferences.setIgnoredVersion(latestVersionNow);
        context.go(RouteNames.root);
      });
      return true;
    }
    return MyScaffold(
        body: Container(
            padding: const EdgeInsets.all(8.0),
            height: double.infinity,
            width: double.infinity,
            child: FutureBuilder(
                future: Upgrader().initialize(),
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Center(
                      child:Text('알 수 없는 에러가 발생하였습니다.'),
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                    if(snapshot.data!){
                      return Center(
                        child: UpgradeCard(
                          showLater: false,
                          upgrader: Upgrader(
                            debugDisplayAlways: true,
                          ),
                          onIgnore: ignored,
                          onLater: ignored,
                        ),
                      );
                    }
                  }
                  return Center(child: CircularProgressIndicator(color: AppColors.primary,),);
                }
            )
        )
    );
  }
}