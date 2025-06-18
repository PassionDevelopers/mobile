import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../ui/color.dart';

class LinkSearchView extends StatefulWidget {
  const LinkSearchView({super.key});

  @override
  State<LinkSearchView> createState() => _LinkSearchViewState();
}

class _LinkSearchViewState extends State<LinkSearchView> {
  bool _isAnalyzing = false;

  Future<void>_analyzeLink()async{
    // if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isAnalyzing = true;
    });

    // 실제 API 호출 대신 목업 데이터로 대체
    await Future.delayed(const Duration(seconds: 1));

    // // 링크 저장
    // await _saveRecentSearch(_linkController.text);
    //
    // // 가상의 분석 결과 설정
    // setState(() {
    //   _isAnalyzing = false;
    //   _hasAnalyzed = true;
    //   _videoTitle = '미국의 25% 자동차 관세 부과와 현지 생산 본격화로 4월 대미 수출 20% 감소';
    //   _summary = '이 영상에서는 현 정부의 국정 운영에 대한 전문가들의 다양한 의견과 평가가 논의되었습니다. 주요 이슈로는 경제 정책, 부동산 대책, 외교 안보, 복지 정책 등이 다루어졌으며, 각 정치적 성향에 따라 다른 관점에서의 평가가 제시되었습니다.';
    //   _leftPerspective = '현 정부는 부의 불평등을 해소하기 위한 정책이 부족하며, 대기업 친화적인 경제 정책으로 인해 양극화가 심화되고 있습니다. 또한 부동산 정책 실패로 서민들의 주거 불안은 계속되고 있으며, 사회 안전망 강화와 복지 확대가 시급합니다.';
    //   _centerPerspective = '현 정부는 국내외 경제 위기 속에서 안정적인 경제 운영을 위해 노력하고 있으나, 일부 정책들의 효과는 제한적입니다. 부동산 시장 안정화를 위한 보완책이 필요하며, 여야 협치를 통한 합리적인 정책 조정이 필요한 시점입니다.';
    //   _rightPerspective = '현 정부는 규제 완화와 민간 중심의 경제 활성화 정책을 통해 경제 위기를 극복하기 위해 노력하고 있습니다. 다만 더 과감한 세제 개혁과 노동시장 유연화가 필요하며, 외교 안보 분야에서는 한미동맹 강화를 통한 국익 확보에 집중해야 합니다.';
    //   _leftPercent = 32.0;
    //   _centerPercent = 41.0;
    //   _rightPercent = 27.0;
    //
    //   leftNews = [
    //     // {'title' : '한덕수 국무총리가 5대 개혁 강력 추진 의지 표명',
    //     //   'summary': '한덕수 국무총리는 개천절 경축식에서 개혁의 중요성을 강조하며 연금, 의료, 교육, 노동, 저출생 등 5대 개혁을 강력히 추진하겠다고 밝혔습니다. 그는 또한 자유민주와 법치의 가치를 지키고 국민 통합에 힘쓰겠다는 의지를 표명했습니다.',
    //     //   'channel_name': 'MBCNEWS', 'bias': 'left'},
    //     {'title': '정부 경제정책, 양극화 심화시킨다', 'channel' : 'jtbc', 'source': '진보일보', 'url': 'https://example.com/news1', 'orientation': 'left'},
    //     {'title': '복지 확대 없는 성장은 의미 없어', 'channel' : 'mbn', 'source': '민중의소리', 'url': 'https://example.com/news4', 'orientation': 'left'},
    //     {'title': '주거 불안 여전... 서민들 고통', 'channel' : 'yonhap', 'source': '노동신문', 'url': 'https://example.com/news7', 'orientation': 'left'},
    //     {'title': '사회 안전망 확충이 최우선', 'channel' : 'channelA', 'source': '정의신문', 'url': 'https://example.com/news10', 'orientation': 'left'},
    //   ];
    //   rightNews = [
    //     {'title': '규제 완화로 경제 활성화 기대', 'channel' : 'kbs', 'source': '보수신문', 'url': 'https://example.com/news3', 'orientation': 'right'},
    //     {'title': '세제 개혁으로 기업 경쟁력 강화해야', 'channel' : 'sbs', 'source': '자유일보', 'url': 'https://example.com/news6', 'orientation': 'right'},
    //     {'title': '한미동맹 강화로 안보 확보', 'channel' : 'tvchosun', 'source': '국방일보', 'url': 'https://example.com/news9', 'orientation': 'right'},
    //     {'title': '과감한 규제 철폐로 혁신 이끌어야', 'channel' : 'jtbc', 'source': '미래일보', 'url': 'https://example.com/news12', 'orientation': 'right'},
    //   ];
    //   centerNews = [
    //     {'title': '부동산 정책 효과 미미... 보완책 필요', 'channel' : 'mbc', 'source': '중앙일보', 'url': 'https://example.com/news2', 'orientation': 'center'},
    //     {'title': '정부 정책, 균형적 접근 필요', 'channel' : 'news_tapa', 'source': '국민일보', 'url': 'https://example.com/news5', 'orientation': 'center'},
    //     {'title': '여야 협치로 정책 보완해야', 'channel' : 'ytn', 'source': '동아일보', 'url': 'https://example.com/news8', 'orientation': 'center'},
    //     {'title': '경제 위기 속 안정적 정책 운영 중요', 'channel' : 'ohmy_tv', 'source': '경제일보', 'url': 'https://example.com/news11', 'orientation': 'center'},
    //   ];
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primary ],
        ),
      ),
      child: Center(
        child: SizedBox(
          // width: screenSize.width > 1200? 1200 : null,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 40,
              // horizontal: isDesktop ? 100 : (isTablet ? 50 : 20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '쿳비',
                      style: TextStyle(
                        // fontSize: isDesktop ? 48 : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // if (isDesktop)
                    //   Row(
                    //     children: [
                    //       NavItem('서비스 소개'),
                    //       NavItem('사용 방법'),
                    //       NavItem('FAQ'),
                    //       NavItem('문의하기'),
                    //     ],
                    //   ),
                  ],
                ),
                // if (!isDesktop)
                  SizedBox(height: 20),
                // if (!isDesktop)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(child: NavItem('소개')),
                //       Expanded(child: NavItem('사용법')),
                //       Expanded(child: NavItem('FAQ')),
                //       Expanded(child: NavItem('문의')),
                //     ],
                //   ),
                SizedBox(height: 60),
                Text(
                  '알고리즘을 벗어난\n다양한 관점을 한눈에',
                  style: TextStyle(
                    // fontSize: isDesktop ? 48 : (isTablet ? 36 : 28),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '유튜브 영상의 내용을 AI가 분석하여 좌-중-우 정치적 관점에서의 다양한 해석과 관련 뉴스를 제공합니다.',
                  style: TextStyle(
                    // fontSize: isDesktop ? 18 : 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  // key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        // controller: _linkController,
                        decoration: InputDecoration(
                          hintText: 'YouTube 영상 링크를 입력하세요',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.link),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '링크를 입력해주세요';
                          }
                          if (!value.contains('youtube.com') && !value.contains('youtu.be')) {
                            return '유효한 YouTube 링크를 입력해주세요';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isAnalyzing ? null : _analyzeLink,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue.shade800,
                            disabledBackgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: _isAnalyzing
                              ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue.shade800),
                          )
                              : Text('분석하기'),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            // 공유하기 기능 구현
                            // final Uri shareUrl = Uri.parse('https://www.youtube.com/watch?v=${_linkController.text}');
                            // SharePlus.instance.share(
                            //   ShareParams(uri: shareUrl, text: '친구가 다양한 시각의 뉴스를 공유했어요.'),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text('공유하기'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
  );
  }
}
