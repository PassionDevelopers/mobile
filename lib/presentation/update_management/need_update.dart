import 'dart:io';
import 'package:could_be/core/components/alert/dialog.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/navigation/pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language_code/language_code.dart';
import 'package:upgrader/upgrader.dart';
import '../../ui/color.dart';

class NeedUpdate extends StatelessWidget {
  const NeedUpdate({super.key, required this.isUpdate});
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    ignored() {
      showAlert(msg: '앱 실행을 위해 꼭 필요한 업데이트 입니다.', context: context);
      return false;
    }
    final languageCode = LanguageCode.code.code;
    return RegScaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.gray5,
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
                        child: Theme(
                          data: ThemeData(
                            textTheme: TextTheme(
                              bodyLarge: TextStyle(fontSize: 16, color: AppColors.black),
                              bodyMedium: TextStyle(fontSize: 14, color: AppColors.black),
                            ),
                            cardColor: AppColors.white,
                            cardTheme: CardThemeData(
                              color: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            primaryColor: AppColors.primary,
                          ),
                          child: UpgradeCard(
                            showLater: false,
                            showIgnore: false,
                            upgrader: Upgrader(
                              // languageCode: languageCode,
                              // countryCode: Platform.localeName,
                              messages: UpgraderMessages(code: 'ko'),
                              debugDisplayAlways: true,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  return Center(child: CircularProgressIndicator(color: AppColors.primary,),);
                }
            ) : Dialog(
                elevation:5,
                backgroundColor: AppColors.white,
                shadowColor: AppColors.gray4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                child : Column(
                  mainAxisSize: MainAxisSize.min,
                    children:[
                      Center(child: Padding(padding: const EdgeInsets.all(8), child: Text('서버 점검',))),
                      Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('서버 점검 중입니다. 잠시 후 다시 시도해 주시기 바랍니다.', maxLines: 2),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.gray4), onPressed: (){
                          if(Platform.isAndroid){
                            SystemNavigator.pop();
                          }else if(Platform.isIOS){
                            exit(0);
                          }
                        }, child: Text('확인')),
                      ),
                    ])) ,
          ),
        )
    );
  }
}