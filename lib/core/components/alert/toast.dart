import 'package:fluttertoast/fluttertoast.dart';

import '../../themes/color.dart';

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

void showMyToastUp({required String msg}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.gray3,
    textColor: AppColors.white,
    fontSize: 16.0,
  );
}
