
import 'dart:io';
import 'package:share_plus/share_plus.dart';

void shareDasiStand(){
  final storeUrl = Uri.parse(
      Platform.isIOS?
      'https://apps.apple.com/kr/app/%EB%8B%A4%EC%8B%9C-%EC%8A%A4%ED%83%A0%EB%93%9C-%EB%8B%A4%EC%96%91%ED%95%9C-%EC%8B%9C%EA%B0%81%EC%9D%98-%EB%89%B4%EC%8A%A4-%EC%8A%A4%ED%83%A0%EB%93%9C/id6748309466'
          : 'https://play.google.com/store/apps/details?id=com.PassionDev.DasiStand'
  );
  final params = ShareParams(uri: storeUrl,
    subject: '다시 스탠드와 함께 균형잡힌 시각을 기르세요!',
  );
  SharePlus.instance.share(params);
}