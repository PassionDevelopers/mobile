import 'package:could_be/core/components/alert/dialog.dart';
import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CommentLink extends StatelessWidget {
  const CommentLink({super.key, required this.source});
  final List<String> source;
  @override
  Widget build(BuildContext context) {
    return source.isEmpty?
    // MyText.reg( '*근거 자료가 없는 댓글입니다.', color: AppColors.gray2, fontWeight: FontWeight.w500,) :
    const SizedBox():
    TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(0,0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
      ),
      onPressed: () async {
        final Uri url = Uri.parse(
          source.first,
        );
        try {
          if (!await canLaunchUrl(url)) {
            showMyToast(msg: '올바른 URL이 아닙니다.');
            throw Exception('올바른 URL이 아닙니다.');
          }else{
            showConfirm(context: context, msg: '외부 링크로 이동합니다.해당 링크는 앱 외부의 웹사이트로 연결되며, 보안이나 콘텐츠에 대해 저희가 책임지지 않습니다.계속하시겠습니까?', callback: ()async{
              await launchUrl(url, mode: LaunchMode.externalApplication);
            });
          }
        } catch (e) {
          showMyToast(msg: '올바른 URL이 아닙니다.');
          throw Exception('올바른 URL이 아닙니다.');
        }
      },
      child: MyText.reg('근거 자료: ${source.first}', decoration: TextDecoration.underline,
        decorationColor: Colors.blue,
        color: Colors.blue, fontWeight: FontWeight.w500,),
    );
  }
}
