import 'package:fluttertoast/fluttertoast.dart';

import '../../../ui/color.dart';

void showMyToast({required String msg}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.gray3,
    textColor: AppColors.white,
    fontSize: 16.0,
  );
}
