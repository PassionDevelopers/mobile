import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class NoticeView extends StatelessWidget {
  const NoticeView({super.key});

  Widget htmlBuilder() {
    return Html(
      data: """
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>다시 스탠드 설문조사</title>
    <style>
        body { font-family: 'Malgun Gothic', Arial, sans-serif; max-width: 800px; margin: 20px auto; padding: 20px; line-height: 1.6; }
        h1 { color: #2c5aa0; text-align: center; border-bottom: 3px solid #2c5aa0; padding-bottom: 10px; }
        .intro { background-color: #f8f9fa; padding: 20px; border-left: 4px solid #2c5aa0; margin-bottom: 30px; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        th { background-color: #2c5aa0; color: white; font-weight: bold; }
        .media-name { background-color: #f8f9fa; font-weight: bold; text-align: left; padding-left: 15px; }
        input[type="checkbox"] { transform: scale(1.2); }
        .text-area { width: 100%; min-height: 100px; border: 2px solid #ddd; padding: 10px; font-family: inherit; }
        .section { margin: 30px 0; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px; }
        .required { color: red; font-weight: bold; }
        .note { background-color: #fff3cd; border: 1px solid #ffeaa7; padding: 15px; border-radius: 5px; margin: 15px 0; }
    </style>
</head>
<body>
    <h1>다시 스탠드: 전문가 대상 매체 편향성 인식 조사</h1>
    
    <div class="intro">
        <strong>다시 스탠드: 다양한 시각의 뉴스 스탠드 서비스의 매체 편향성 분류를 위해 실시하는 전문가 대상 설문 입니다.</strong><br><br>
        결과는 철저하게 익명으로 유지되며, 설문 마지막 란에 공개 범위도 직접 설정하실 수 있습니다.<br><br>
        사회 갈등 완화를 위해 사람들이 다양한 시각을 이해할 수 있도록 돕고자 하는 청년들의 의지에 든든한 보탬이 되어주셔서 정말 감사드립니다.
    </div>

    <div class="section">
        <h2>📋 아래 매체들이 어느 성향에 속하는지 선택해주세요 <span class="required">*</span></h2>
        
        <table>
            <tr><th>매체명</th><th>진보</th><th>중도진보</th><th>중도</th><th>중도보수</th><th>보수</th><th>잘모름</th></tr>
            <tr><td class="media-name">문화일보</td><td><input type="checkbox" name="문화일보"></td><td><input type="checkbox" name="문화일보"></td><td><input type="checkbox" name="문화일보"></td><td><input type="checkbox" name="문화일보"></td><td><input type="checkbox" name="문화일보"></td><td><input type="checkbox" name="문화일보"></td></tr>
            <tr><td class="media-name">SBS</td><td><input type="checkbox" name="SBS"></td><td><input type="checkbox" name="SBS"></td><td><input type="checkbox" name="SBS"></td><td><input type="checkbox" name="SBS"></td><td><input type="checkbox" name="SBS"></td><td><input type="checkbox" name="SBS"></td></tr>
            <tr><td class="media-name">뉴스1</td><td><input type="checkbox" name="뉴스1"></td><td><input type="checkbox" name="뉴스1"></td><td><input type="checkbox" name="뉴스1"></td><td><input type="checkbox" name="뉴스1"></td><td><input type="checkbox" name="뉴스1"></td><td><input type="checkbox" name="뉴스1"></td></tr>
            <tr><td class="media-name">오마이뉴스</td><td><input type="checkbox" name="오마이뉴스"></td><td><input type="checkbox" name="오마이뉴스"></td><td><input type="checkbox" name="오마이뉴스"></td><td><input type="checkbox" name="오마이뉴스"></td><td><input type="checkbox" name="오마이뉴스"></td><td><input type="checkbox" name="오마이뉴스"></td></tr>
            <tr><td class="media-name">한겨레</td><td><input type="checkbox" name="한겨레"></td><td><input type="checkbox" name="한겨레"></td><td><input type="checkbox" name="한겨레"></td><td><input type="checkbox" name="한겨레"></td><td><input type="checkbox" name="한겨레"></td><td><input type="checkbox" name="한겨레"></td></tr>
            <tr><td class="media-name">국민일보</td><td><input type="checkbox" name="국민일보"></td><td><input type="checkbox" name="국민일보"></td><td><input type="checkbox" name="국민일보"></td><td><input type="checkbox" name="국민일보"></td><td><input type="checkbox" name="국민일보"></td><td><input type="checkbox" name="국민일보"></td></tr>
            <tr><td class="media-name">JTBC</td><td><input type="checkbox" name="JTBC"></td><td><input type="checkbox" name="JTBC"></td><td><input type="checkbox" name="JTBC"></td><td><input type="checkbox" name="JTBC"></td><td><input type="checkbox" name="JTBC"></td><td><input type="checkbox" name="JTBC"></td></tr>
            <tr><td class="media-name">MBN</td><td><input type="checkbox" name="MBN"></td><td><input type="checkbox" name="MBN"></td><td><input type="checkbox" name="MBN"></td><td><input type="checkbox" name="MBN"></td><td><input type="checkbox" name="MBN"></td><td><input type="checkbox" name="MBN"></td></tr>
            <tr><td class="media-name">KBS</td><td><input type="checkbox" name="KBS"></td><td><input type="checkbox" name="KBS"></td><td><input type="checkbox" name="KBS"></td><td><input type="checkbox" name="KBS"></td><td><input type="checkbox" name="KBS"></td><td><input type="checkbox" name="KBS"></td></tr>
            <tr><td class="media-name">한국일보</td><td><input type="checkbox" name="한국일보"></td><td><input type="checkbox" name="한국일보"></td><td><input type="checkbox" name="한국일보"></td><td><input type="checkbox" name="한국일보"></td><td><input type="checkbox" name="한국일보"></td><td><input type="checkbox" name="한국일보"></td></tr>
            <tr><td class="media-name">동아일보</td><td><input type="checkbox" name="동아일보"></td><td><input type="checkbox" name="동아일보"></td><td><input type="checkbox" name="동아일보"></td><td><input type="checkbox" name="동아일보"></td><td><input type="checkbox" name="동아일보"></td><td><input type="checkbox" name="동아일보"></td></tr>
            <tr><td class="media-name">조선일보</td><td><input type="checkbox" name="조선일보"></td><td><input type="checkbox" name="조선일보"></td><td><input type="checkbox" name="조선일보"></td><td><input type="checkbox" name="조선일보"></td><td><input type="checkbox" name="조선일보"></td><td><input type="checkbox" name="조선일보"></td></tr>
            <tr><td class="media-name">중앙일보</td><td><input type="checkbox" name="중앙일보"></td><td><input type="checkbox" name="중앙일보"></td><td><input type="checkbox" name="중앙일보"></td><td><input type="checkbox" name="중앙일보"></td><td><input type="checkbox" name="중앙일보"></td><td><input type="checkbox" name="중앙일보"></td></tr>
            <tr><td class="media-name">한국경제TV</td><td><input type="checkbox" name="한국경제TV"></td><td><input type="checkbox" name="한국경제TV"></td><td><input type="checkbox" name="한국경제TV"></td><td><input type="checkbox" name="한국경제TV"></td><td><input type="checkbox" name="한국경제TV"></td><td><input type="checkbox" name="한국경제TV"></td></tr>
            <tr><td class="media-name">채널 A</td><td><input type="checkbox" name="채널A"></td><td><input type="checkbox" name="채널A"></td><td><input type="checkbox" name="채널A"></td><td><input type="checkbox" name="채널A"></td><td><input type="checkbox" name="채널A"></td><td><input type="checkbox" name="채널A"></td></tr>
            <tr><td class="media-name">세계일보</td><td><input type="checkbox" name="세계일보"></td><td><input type="checkbox" name="세계일보"></td><td><input type="checkbox" name="세계일보"></td><td><input type="checkbox" name="세계일보"></td><td><input type="checkbox" name="세계일보"></td><td><input type="checkbox" name="세계일보"></td></tr>
            <tr><td class="media-name">경향신문</td><td><input type="checkbox" name="경향신문"></td><td><input type="checkbox" name="경향신문"></td><td><input type="checkbox" name="경향신문"></td><td><input type="checkbox" name="경향신문"></td><td><input type="checkbox" name="경향신문"></td><td><input type="checkbox" name="경향신문"></td></tr>
            <tr><td class="media-name">YTN</td><td><input type="checkbox" name="YTN"></td><td><input type="checkbox" name="YTN"></td><td><input type="checkbox" name="YTN"></td><td><input type="checkbox" name="YTN"></td><td><input type="checkbox" name="YTN"></td><td><input type="checkbox" name="YTN"></td></tr>
            <tr><td class="media-name">연합뉴스</td><td><input type="checkbox" name="연합뉴스"></td><td><input type="checkbox" name="연합뉴스"></td><td><input type="checkbox" name="연합뉴스"></td><td><input type="checkbox" name="연합뉴스"></td><td><input type="checkbox" name="연합뉴스"></td><td><input type="checkbox" name="연합뉴스"></td></tr>
            <tr><td class="media-name">서울신문</td><td><input type="checkbox" name="서울신문"></td><td><input type="checkbox" name="서울신문"></td><td><input type="checkbox" name="서울신문"></td><td><input type="checkbox" name="서울신문"></td><td><input type="checkbox" name="서울신문"></td><td><input type="checkbox" name="서울신문"></td></tr>
            <tr><td class="media-name">MBC</td><td><input type="checkbox" name="MBC"></td><td><input type="checkbox" name="MBC"></td><td><input type="checkbox" name="MBC"></td><td><input type="checkbox" name="MBC"></td><td><input type="checkbox" name="MBC"></td><td><input type="checkbox" name="MBC"></td></tr>
            <tr><td class="media-name">뉴시스</td><td><input type="checkbox" name="뉴시스"></td><td><input type="checkbox" name="뉴시스"></td><td><input type="checkbox" name="뉴시스"></td><td><input type="checkbox" name="뉴시스"></td><td><input type="checkbox" name="뉴시스"></td><td><input type="checkbox" name="뉴시스"></td></tr>
        </table>
    </div>

    <div class="section">
        <h2>📝 전문가 정보 노출 범위 <span class="required">*</span></h2>
        <p>저희 앱의 신뢰도를 높이고자 전문가이신 작성자님의 의견을 반영하여 매체의 성향을 분류하였다는 내용을 포함시키고자 합니다. 작성자님의 인적사항을 앱에서 어느 범위까지 노출해도 되는지 말씀해주시기 바랍니다.</p>
        <p><strong>예시:</strong> 서울 소재 대학 정치 관련 교수, 전직 국회의원, 현직 방송사 기자 등</p>
        <textarea class="text-area" placeholder="여기에 답변을 작성해주세요..."></textarea>
    </div>

    <div class="section">
        <h2>📞 연락처 또는 피드백</h2>
        <p>혹시 저희 서비스의 앞으로의 성장이 궁금하시거나 발전 방향에 대한 조언을 해주실 수 있으시다면 아래에 연락처를 남겨주시기 바랍니다.</p>
        <div class="note">
            <strong>개인정보 보호:</strong> 남겨주신 연락처는 '다시 스탠드'의 팀장 한명만 보관하고 다른 팀원들을 포함하여 그 누구에게도 공개하지 않을 것이며, 만약 요청하실 경우 그 즉시 파기할 것을 약속드립니다.
        </div>
        <textarea class="text-area" placeholder="연락처나 피드백을 작성해주세요..."></textarea>
    </div>

   
</body>
</html>
        
        """,
      extensions: [
        TagExtension(
          tagsToExtend: {"flutter"},
          child: const FlutterLogo(),
        ),
      ],
      style: {

        "p.fancy": Style(
          textAlign: TextAlign.center,
          padding: HtmlPaddings(left: HtmlPadding(16), right: HtmlPadding(16)),
          backgroundColor: Colors.grey,
          margin: Margins(left: Margin(50, Unit.px), right: Margin.auto()),
          width: Width(300, Unit.px),
          fontWeight: FontWeight.bold,
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(child: htmlBuilder())
    );
  }
}
