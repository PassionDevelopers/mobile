import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/navigation/pop_scope.dart';
import 'package:flutter/material.dart';

class UnsupportedDevice extends StatelessWidget {
  const UnsupportedDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      isScrollPage: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: MyPopScope(
            callBack: (){},
            child: Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                child : Container(
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(30),),
                  child: Column(
                      children:[
                        // flexLayout(1, const SizedBox()),
                        // flexLayout(1,Center(child: Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: autoSizeText('Unsupported device.', color: AbpColor.n8, maxLines: 2),
                        // ))),
                        // flexLayout(1, const SizedBox()),
                      ]),
                )
            ) ,
          ),
        )
    );
  }
}