
import 'dart:io';

import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upgrader/upgrader.dart';

import '../../ui/color.dart';
import '../components/alert/dialog.dart';
import '../components/navigation/pop_scope.dart';

class NeedUpdate extends StatelessWidget {
  const NeedUpdate({Key? key, required this.isUpdate}) : super(key: key);
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    ignored() {
      showAlert(msg: '앱 실행을 위해 꼭 필요한 업데이트 입니다.', context: context);
      return false;
    }

    return MyScaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.white,
          padding: const EdgeInsets.all(8.0),
          child: MyPopScope(
            callBack: (){},
            child: isUpdate? FutureBuilder(
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
                            countryCode: Platform.localeName,
                            debugDisplayAlways: true,
                          ),
                          onIgnore: ignored,
                          onLater: ignored,
                        ),
                      );
                    }
                  }
                  return const Center(child: CircularProgressIndicator(color: AbpColor.n8,),);
                }
            ) : Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                child : Container(
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(30),),
                  child: Column(
                      children:[
                        Center(child: Padding(padding: const EdgeInsets.all(8), child: Text('서버 점검',))),
                        Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('서버 점검 중입니다. 잠시 후 다시 시도해 주시기 바랍니다.', maxLines: 2),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary), onPressed: (){
                            if(Platform.isAndroid){
                              SystemNavigator.pop();
                            }else if(Platform.isIOS){
                              exit(0);
                            }
                          }, child: Text('확인')),
                        ),
                      ]),
                )) ,
          ),
        )
    );
  }
}