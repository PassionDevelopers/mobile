
import 'package:flutter/material.dart';
import '../../core/components/home_components.dart';
import '../../core/components/layouts/scaffold_layout.dart';
import '../media/media_components.dart';
import '../../ui/color.dart';
import '../community/major_user_opinion_view.dart';

class IssueView extends StatefulWidget {
  const IssueView({Key? key}) : super(key: key);

  @override
  _IssueViewState createState() => _IssueViewState();
}

class _IssueViewState extends State<IssueView> with SingleTickerProviderStateMixin {
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TabController _tabController;
  bool _isAnalyzing = false;
  bool _hasAnalyzed = false;
  List<String> _recentSearches = [];

  // 분석 결과 데이터
  String _videoTitle = '';
  String _summary = '';
  String _leftPerspective = '';
  String _centerPerspective = '';
  String _rightPerspective = '';
  double _leftPercent = 0.0;
  double _centerPercent = 0.0;
  double _rightPercent = 0.0;
  List<Map<String, String>> leftNews = [];
  List<Map<String, String>> rightNews = [];
  List<Map<String, String>> centerNews = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      setState(() {});
    });
    setState(() {
      _isAnalyzing = false;
      _hasAnalyzed = true;
      _videoTitle = '미국의 25% 자동차 관세 부과와 현지 생산 본격화로 4월 대미 수출 20% 감소';
      _summary = '이 영상에서는 현 정부의 국정 운영에 대한 전문가들의 다양한 의견과 평가가 논의되었습니다. 주요 이슈로는 경제 정책, 부동산 대책, 외교 안보, 복지 정책 등이 다루어졌으며, 각 정치적 성향에 따라 다른 관점에서의 평가가 제시되었습니다.';
      _leftPerspective = '현 정부는 부의 불평등을 해소하기 위한 정책이 부족하며, 대기업 친화적인 경제 정책으로 인해 양극화가 심화되고 있습니다. 또한 부동산 정책 실패로 서민들의 주거 불안은 계속되고 있으며, 사회 안전망 강화와 복지 확대가 시급합니다.';
      _centerPerspective = '현 정부는 국내외 경제 위기 속에서 안정적인 경제 운영을 위해 노력하고 있으나, 일부 정책들의 효과는 제한적입니다. 부동산 시장 안정화를 위한 보완책이 필요하며, 여야 협치를 통한 합리적인 정책 조정이 필요한 시점입니다.';
      _rightPerspective = '현 정부는 규제 완화와 민간 중심의 경제 활성화 정책을 통해 경제 위기를 극복하기 위해 노력하고 있습니다. 다만 더 과감한 세제 개혁과 노동시장 유연화가 필요하며, 외교 안보 분야에서는 한미동맹 강화를 통한 국익 확보에 집중해야 합니다.';
      _leftPercent = 32.0;
      _centerPercent = 41.0;
      _rightPercent = 27.0;

      leftNews = [
        // {'title' : '한덕수 국무총리가 5대 개혁 강력 추진 의지 표명',
        //   'summary': '한덕수 국무총리는 개천절 경축식에서 개혁의 중요성을 강조하며 연금, 의료, 교육, 노동, 저출생 등 5대 개혁을 강력히 추진하겠다고 밝혔습니다. 그는 또한 자유민주와 법치의 가치를 지키고 국민 통합에 힘쓰겠다는 의지를 표명했습니다.',
        //   'channel_name': 'MBCNEWS', 'bias': 'left'},
        {'title': '정부 경제정책, 양극화 심화시킨다', 'channel' : 'jtbc', 'source': '진보일보', 'url': 'https://example.com/news1', 'orientation': 'left'},
        {'title': '복지 확대 없는 성장은 의미 없어', 'channel' : 'mbn', 'source': '민중의소리', 'url': 'https://example.com/news4', 'orientation': 'left'},
        {'title': '주거 불안 여전... 서민들 고통', 'channel' : 'yonhap', 'source': '노동신문', 'url': 'https://example.com/news7', 'orientation': 'left'},
        {'title': '사회 안전망 확충이 최우선', 'channel' : 'channelA', 'source': '정의신문', 'url': 'https://example.com/news10', 'orientation': 'left'},
      ];
      rightNews = [
        {'title': '규제 완화로 경제 활성화 기대', 'channel' : 'kbs', 'source': '보수신문', 'url': 'https://example.com/news3', 'orientation': 'right'},
        {'title': '세제 개혁으로 기업 경쟁력 강화해야', 'channel' : 'sbs', 'source': '자유일보', 'url': 'https://example.com/news6', 'orientation': 'right'},
        {'title': '한미동맹 강화로 안보 확보', 'channel' : 'tvchosun', 'source': '국방일보', 'url': 'https://example.com/news9', 'orientation': 'right'},
        {'title': '과감한 규제 철폐로 혁신 이끌어야', 'channel' : 'jtbc', 'source': '미래일보', 'url': 'https://example.com/news12', 'orientation': 'right'},
      ];
      centerNews = [
        {'title': '부동산 정책 효과 미미... 보완책 필요', 'channel' : 'mbc', 'source': '중앙일보', 'url': 'https://example.com/news2', 'orientation': 'center'},
        {'title': '정부 정책, 균형적 접근 필요', 'channel' : 'news_tapa', 'source': '국민일보', 'url': 'https://example.com/news5', 'orientation': 'center'},
        {'title': '여야 협치로 정책 보완해야', 'channel' : 'ytn', 'source': '동아일보', 'url': 'https://example.com/news8', 'orientation': 'center'},
        {'title': '경제 위기 속 안정적 정책 운영 중요', 'channel' : 'ohmy_tv', 'source': '경제일보', 'url': 'https://example.com/news11', 'orientation': 'center'},
      ];
    });
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _linkController.dispose();
    _emailController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // 최근 검색어 불러오기
  Future<void> _loadRecentSearches() async {
    final prefs = null;
    setState(() {
      _recentSearches = ['윤석열 내란 혐의 3차 공판', '첫 미중 협상 종료', '5월 초 대미 수출 급감']; // 예시 데이터
      // _recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

//  최근 검색어 저장하기
  Future<void> _saveRecentSearch(String link) async {
    if (link.isEmpty) return;

    final prefs = null;

    // URL의 형태로 변환하여 저장 (저장공간 절약)
    Uri? uri = Uri.tryParse(link);
    if (uri == null) return;

    String videoId = uri.queryParameters['v'] ?? '';
    if (videoId.isEmpty) return;

    // 중복 검색 방지
    if (!_recentSearches.contains(videoId)) {
      _recentSearches.insert(0, videoId);

      // 최대 10개까지만 저장
      if (_recentSearches.length > 10) {
        _recentSearches.removeLast();
      }


      await prefs.setStringList('recentSearches', _recentSearches);
      setState(() {});
    }
  }

  //링크 분석하기
  Future<void>_analyzeLink()async{
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isAnalyzing = true;
    });

    // 실제 API 호출 대신 목업 데이터로 대체
    await Future.delayed(const Duration(seconds: 1));

    // 링크 저장
    await _saveRecentSearch(_linkController.text);

    // 가상의 분석 결과 설정
    setState(() {
      _isAnalyzing = false;
      _hasAnalyzed = true;
      _videoTitle = '미국의 25% 자동차 관세 부과와 현지 생산 본격화로 4월 대미 수출 20% 감소';
      _summary = '이 영상에서는 현 정부의 국정 운영에 대한 전문가들의 다양한 의견과 평가가 논의되었습니다. 주요 이슈로는 경제 정책, 부동산 대책, 외교 안보, 복지 정책 등이 다루어졌으며, 각 정치적 성향에 따라 다른 관점에서의 평가가 제시되었습니다.';
      _leftPerspective = '현 정부는 부의 불평등을 해소하기 위한 정책이 부족하며, 대기업 친화적인 경제 정책으로 인해 양극화가 심화되고 있습니다. 또한 부동산 정책 실패로 서민들의 주거 불안은 계속되고 있으며, 사회 안전망 강화와 복지 확대가 시급합니다.';
      _centerPerspective = '현 정부는 국내외 경제 위기 속에서 안정적인 경제 운영을 위해 노력하고 있으나, 일부 정책들의 효과는 제한적입니다. 부동산 시장 안정화를 위한 보완책이 필요하며, 여야 협치를 통한 합리적인 정책 조정이 필요한 시점입니다.';
      _rightPerspective = '현 정부는 규제 완화와 민간 중심의 경제 활성화 정책을 통해 경제 위기를 극복하기 위해 노력하고 있습니다. 다만 더 과감한 세제 개혁과 노동시장 유연화가 필요하며, 외교 안보 분야에서는 한미동맹 강화를 통한 국익 확보에 집중해야 합니다.';
      _leftPercent = 32.0;
      _centerPercent = 41.0;
      _rightPercent = 27.0;

      leftNews = [
        // {'title' : '한덕수 국무총리가 5대 개혁 강력 추진 의지 표명',
        //   'summary': '한덕수 국무총리는 개천절 경축식에서 개혁의 중요성을 강조하며 연금, 의료, 교육, 노동, 저출생 등 5대 개혁을 강력히 추진하겠다고 밝혔습니다. 그는 또한 자유민주와 법치의 가치를 지키고 국민 통합에 힘쓰겠다는 의지를 표명했습니다.',
        //   'channel_name': 'MBCNEWS', 'bias': 'left'},
        {'title': '정부 경제정책, 양극화 심화시킨다', 'channel' : 'jtbc', 'source': '진보일보', 'url': 'https://example.com/news1', 'orientation': 'left'},
        {'title': '복지 확대 없는 성장은 의미 없어', 'channel' : 'mbn', 'source': '민중의소리', 'url': 'https://example.com/news4', 'orientation': 'left'},
        {'title': '주거 불안 여전... 서민들 고통', 'channel' : 'yonhap', 'source': '노동신문', 'url': 'https://example.com/news7', 'orientation': 'left'},
        {'title': '사회 안전망 확충이 최우선', 'channel' : 'channelA', 'source': '정의신문', 'url': 'https://example.com/news10', 'orientation': 'left'},
      ];
      rightNews = [
        {'title': '규제 완화로 경제 활성화 기대', 'channel' : 'kbs', 'source': '보수신문', 'url': 'https://example.com/news3', 'orientation': 'right'},
        {'title': '세제 개혁으로 기업 경쟁력 강화해야', 'channel' : 'sbs', 'source': '자유일보', 'url': 'https://example.com/news6', 'orientation': 'right'},
        {'title': '한미동맹 강화로 안보 확보', 'channel' : 'tvchosun', 'source': '국방일보', 'url': 'https://example.com/news9', 'orientation': 'right'},
        {'title': '과감한 규제 철폐로 혁신 이끌어야', 'channel' : 'jtbc', 'source': '미래일보', 'url': 'https://example.com/news12', 'orientation': 'right'},
      ];
      centerNews = [
        {'title': '부동산 정책 효과 미미... 보완책 필요', 'channel' : 'mbc', 'source': '중앙일보', 'url': 'https://example.com/news2', 'orientation': 'center'},
        {'title': '정부 정책, 균형적 접근 필요', 'channel' : 'news_tapa', 'source': '국민일보', 'url': 'https://example.com/news5', 'orientation': 'center'},
        {'title': '여야 협치로 정책 보완해야', 'channel' : 'ytn', 'source': '동아일보', 'url': 'https://example.com/news8', 'orientation': 'center'},
        {'title': '경제 위기 속 안정적 정책 운영 중요', 'channel' : 'ohmy_tv', 'source': '경제일보', 'url': 'https://example.com/news11', 'orientation': 'center'},
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    //키워드 워드 클라우드
    // 경쟁관계에 있는 다양한 주제로 확장할 수 있다.
    // 선정 언론들의 조회수를 통한
    // 관점 차이점 헤더로 박기
    // 트리 구조로 정리 (트리의 깊이가 한 페이지) 대표 기능 , 구성을 명시적으로, 고객 어필 포인트 -> 기능, 현재 고객의 니즈를 파악
    // 현재 정치 뉴스 사용자들의 uX 정리
    // 갈등 수치 : 성향별 대립이 심각한 이슈입니다. 대립이 거의 없는 이슈입니다.
    // 댓글들 정리 -> 아직 진보에서 제대로 답변하지 못한 부분
    // 논지 덧붙이기 / 그냥 댓글 싸지르기
    // 링크 표시
    return Stack(
      children: [
        RegScaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _videoTitle,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '2025.05.20',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey
                          ),
                        ),
                        SizedBox(height: 20),
                        // CardBiasBar(biasSpectrum: issue),
                        SizedBox(height: 10),
                        Text(
                          '관점별 보도 내용',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 10),
                        // 탭 뷰를 통한 정치적 관점 콘텐츠
                        Ink(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TabBar(
                                controller: _tabController,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.grey,
                                indicatorSize: TabBarIndicatorSize.tab,
                                splashBorderRadius: BorderRadius.circular(15),
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft:Radius.circular(15),  ),
                                  color: _tabController.index == 0? AppColors.left :
                                _tabController.index == 1?  AppColors.center : AppColors.right,),
                                // indicatorColor: _tabController.index == 0? AppColors.left :
                                // _tabController.index == 1?  AppColors.center : AppColors.right,
                                tabs: [
                                  Tab(text: '진보적 관점'),
                                  Tab(text: '중도적 관점'),
                                  Tab(text: '보수적 관점'),
                                ],
                              ),
                              Container(
                                height: 200,
                                padding: EdgeInsets.all(20),
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    SingleChildScrollView(
                                      child: Text(
                                        _leftPerspective,
                                        style: TextStyle(height: 1.6),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Text(
                                        _centerPerspective,
                                        style: TextStyle(height: 1.6),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Text(
                                        _rightPerspective,
                                        style: TextStyle(height: 1.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 30),

                        //관점 비교
                        Text(
                          '관점별 차이점 비교',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                padding: EdgeInsets.all(20),
                                child: SingleChildScrollView(
                                  child: Text(
                                    _leftPerspective,
                                    style: TextStyle(height: 1.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 30),
                        // Text(
                        //   '언론 성향별 보도율',
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold,
                        //     color: AppColors.primary,
                        //   ),
                        // ),
                        // SizedBox(height: 10),
                        // // 스펙트럼 바 차트
                        // Container(
                        //   height: 40,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(8),
                        //     // overflow: Clip.antiAlias,
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         flex: _leftPercent.toInt(),
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //             color: AppColors.left,
                        //             borderRadius: BorderRadius.only(
                        //               topLeft: Radius.circular(8),
                        //               bottomLeft: Radius.circular(8),
                        //             ),
                        //           ),
                        //           child: Center(
                        //             child: Text(
                        //               '${_leftPercent.toInt()}%',
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         flex: _centerPercent.toInt(),
                        //         child: Container(
                        //           color: Colors.grey.shade500,
                        //           child: Center(
                        //             child: Text(
                        //               '${_centerPercent.toInt()}%',
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         flex: _rightPercent.toInt(),
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //             color: AppColors.right,
                        //             borderRadius: BorderRadius.only(
                        //               topRight: Radius.circular(8),
                        //               bottomRight: Radius.circular(8),
                        //             ),
                        //           ),
                        //           child: Center(
                        //             child: Text(
                        //               '${_rightPercent.toInt()}%',
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 10),
                        // 뉴스링크
                        Column(
                          children: [
                            TabBar(
                              controller: _tabController,
                              labelColor: _tabController.index == 0? AppColors.left :
                              _tabController.index == 1?  AppColors.center : AppColors.right,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: _tabController.index == 0? AppColors.left :
                              _tabController.index == 1?  AppColors.center : AppColors.right,
                              tabs: [
                                Tab(text: '진보 언론'),
                                Tab(text: '중도 언론'),
                                Tab(text: '보수 언론'),
                              ],
                            ),
                            Container(
                              height: 250,
                              padding: EdgeInsets.all(8),
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // MediaNews(news: leftNews),MediaNews(news: centerNews), MediaNews(news: rightNews),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                // 최근 검색 섹션
                // Container(
                //   width: double.infinity,
                //   padding: EdgeInsets.symmetric(
                //     vertical: 40,
                //     horizontal: isDesktop ? 100 : (isTablet ? 50 : 20),
                //   ),
                //   // color: Colors.grey.shade100,
                //   child: Center(
                //     child: SizedBox(
                //       width: screenSize.width > 1000? 1000 : null,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Row(
                //             children: [
                //               Icon(Icons.history, size: 20),
                //               const SizedBox(width: 4,),
                //               Text(
                //                 '최근 인기 검색어',
                //                 style: TextStyle(
                //                   fontSize: 20,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           SizedBox(height: 20),
                //           _recentSearches.isEmpty
                //               ? Text('최근 검색 결과가 없습니다.')
                //               : Wrap(
                //             spacing: 10,
                //             runSpacing: 10,
                //             children: _recentSearches.map((videoId) {
                //               return ActionChip(
                //                 // avatar: Icon(Icons.history, size: 16),
                //                 label: Text(
                //                   '$videoId',
                //                   style: TextStyle(fontSize: 14),
                //                 ),
                //                 backgroundColor: Color(0xffF1F5F9),
                //                 onPressed: () {
                //                   _linkController.text = 'https://www.youtube.com/watch?v=$videoId';
                //                   _analyzeLink();
                //                 },
                //               );
                //             }).toList(),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                //커뮤니티
                MajorUserOpinionView(),
                // 서비스 소개 섹션
                // Container(
                //   width: double.infinity,
                //   padding: EdgeInsets.symmetric(
                //     vertical: 60,
                //     horizontal: isDesktop ? 100 : (isTablet ? 50 : 20),
                //   ),
                //   child: Center(
                //     child: SizedBox(
                //       width: screenSize.width > 1000? 1000 : null,
                //       child: isDesktop
                //           ? Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Expanded(
                //             child: Padding(
                //               padding: EdgeInsets.only(right: 40),
                //               child: _buildServiceInfo(),
                //             ),
                //           ),
                //           Expanded(
                //             child: _buildFeatures(),
                //           ),
                //         ],
                //       )
                //           : Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           _buildServiceInfo(),
                //           SizedBox(height: 40),
                //           _buildFeatures(),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                //
                // // 뉴스레터 구독 섹션
                // Container(
                //   width: double.infinity,
                //   padding: EdgeInsets.symmetric(
                //     vertical: 40,
                //     horizontal: isDesktop ? 100 : (isTablet ? 50 : 20),
                //   ),
                //   color: Colors.blue.shade50,
                //   child: Column(
                //     children: [
                //       Text(
                //         '뉴스레터 구독하기 & 8월 앱 출시 알림 받기',
                //         style: TextStyle(
                //           fontSize: 24,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       SizedBox(height: 16),
                //       Text(
                //         '매주 흥미로운 정치 토론과 다양한 관점의 분석 자료를 받아보세요.',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //           fontSize: 16,
                //         ),
                //       ),
                //       SizedBox(height: 24),
                //       Container(
                //         width: isDesktop ? 500 : double.infinity,
                //         child: Row(
                //           children: [
                //             Expanded(
                //               child: TextField(
                //                 controller: _emailController,
                //                 decoration: InputDecoration(
                //                   hintText: '이메일 주소',
                //                   fillColor: Colors.white,
                //                   filled: true,
                //                   border: OutlineInputBorder(
                //                     borderRadius: BorderRadius.horizontal(
                //                       left: Radius.circular(8),
                //                       right: Radius.zero,
                //                     ),
                //                     borderSide: BorderSide.none,
                //                   ),
                //                   contentPadding: EdgeInsets.symmetric(
                //                     vertical: 16,
                //                     horizontal: 16,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             ElevatedButton(
                //               onPressed: () {
                //                 // 이메일 구독 처리
                //                 if (_emailController.text.isNotEmpty) {
                //                   ScaffoldMessenger.of(context).showSnackBar(
                //                     SnackBar(
                //                       content: Text('뉴스레터 구독이 완료되었습니다.'),
                //                       backgroundColor: Colors.green,
                //                     ),
                //                   );
                //                   _emailController.clear();
                //                 }
                //               },
                //               style: ElevatedButton.styleFrom(
                //                 backgroundColor: Colors.blue.shade800,
                //                 foregroundColor: Colors.white,
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.horizontal(
                //                     left: Radius.zero,
                //                     right: Radius.circular(8),
                //                   ),
                //                 ),
                //                 padding: EdgeInsets.symmetric(
                //                   vertical: 23,
                //                   horizontal: 24,
                //                 ),
                //                 minimumSize: Size(100, 0),
                //               ),
                //               child: Text('구독하기'),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                //
                // // 푸터
                // Container(
                //   width: double.infinity,
                //   padding: EdgeInsets.symmetric(
                //     vertical: 40,
                //     horizontal: isDesktop ? 100 : (isTablet ? 50 : 20),
                //   ),
                //   color: Colors.blue.shade900,
                //   child: Center(
                //     child: SizedBox(
                //       width: screenSize.width > 1200? 1200 : null,
                //       child: isDesktop
                //           ? Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Expanded(
                //             flex: 2,
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   '쿳비',
                //                   style: TextStyle(
                //                     color: Colors.white,
                //                     fontSize: 20,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //                 SizedBox(height: 16),
                //                 Text(
                //                   '유튜브 영상의 내용을 AI가 분석하여\n다양한 정치적 관점에서 해석해 드립니다.',
                //                   style: TextStyle(
                //                     color: Colors.white.withOpacity(0.8),
                //                     height: 1.6,
                //                   ),
                //                 ),
                //                 SizedBox(height: 24),
                //                 Row(
                //                   children: [
                //                     SocialIcon(Icons.facebook),
                //                     SizedBox(width: 16),
                //                     SocialIcon(Icons.ac_unit), // X(Twitter) 아이콘 대체
                //                     SizedBox(width: 16),
                //                     SocialIcon(Icons.insert_link),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Expanded(
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 FooterTitle('서비스'),
                //                 FooterLink('소개'),
                //                 FooterLink('이용방법'),
                //                 FooterLink('가격 정책'),
                //                 FooterLink('API'),
                //               ],
                //             ),
                //           ),
                //           Expanded(
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 FooterTitle('지원'),
                //                 FooterLink('FAQ'),
                //                 FooterLink('문의하기'),
                //                 FooterLink('피드백'),
                //                 FooterLink('개인정보 처리방침'),
                //               ],
                //             ),
                //           ),
                //         ],
                //       )
                //           : Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             '쿳비 뉴스',
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 20,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           SizedBox(height: 16),
                //           Text(
                //             '유튜브 영상의 내용을 AI가 분석하여 다양한 정치적 관점에서 해석해 드립니다.',
                //             style: TextStyle(
                //               color: Colors.white.withOpacity(0.8),
                //               height: 1.6,
                //             ),
                //           ),
                //           SizedBox(height: 24),
                //           Row(
                //             children: [
                //               SocialIcon(Icons.facebook),
                //               SizedBox(width: 16),
                //               SocialIcon(Icons.ac_unit), // X(Twitter) 아이콘 대체
                //               SizedBox(width: 16),
                //               SocialIcon(Icons.insert_link),
                //             ],
                //           ),
                //           Divider(color: Colors.white.withOpacity(0.2), height: 40),
                //           Row(
                //             children: [
                //               Expanded(
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     FooterTitle('서비스'),
                //                     FooterLink('소개'),
                //                     FooterLink('이용방법'),
                //                     FooterLink('가격 정책'),
                //                   ],
                //                 ),
                //               ),
                //               Expanded(
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     FooterTitle('지원'),
                //                     FooterLink('FAQ'),
                //                     FooterLink('문의하기'),
                //                     FooterLink('피드백'),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                //
                // // 카피라이트
                // Container(
                //   width: double.infinity,
                //   padding: EdgeInsets.symmetric(
                //     vertical: 20,
                //     horizontal: isDesktop ? 100 : (isTablet ? 50 : 20),
                //   ),
                //   color: Colors.blue.shade900,
                //   child: Text(
                //     '© 2025 쿳비 뉴스. All rights reserved.',
                //     style: TextStyle(
                //       color: Colors.white.withOpacity(0.6),
                //       fontSize: 14,
                //     ),
                //     textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        // CommentView()
      ],
    );
  }

  // 서비스 소개 위젯
  Widget _buildServiceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '서비스 소개',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          '정치 스펙트럼 분석기는 유튜브 영상의 내용을 AI가 분석하여 다양한 정치적 관점에서 해석을 제공하는 서비스입니다. 정보의 편향성을 인지하고 균형 잡힌 시각을 가질 수 있도록 도와드립니다.',
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
          ),
        ),
        SizedBox(height: 16),
        Text(
          '현대 사회에서 미디어 리터러시는 매우 중요합니다. 같은 사건이라도 정치적 성향에 따라 다르게 해석될 수 있으며, 이를 이해하는 것은 균형 잡힌 시각을 형성하는 데 필수적입니다. 저희 서비스는 AI 기술을 활용하여 이러한 과정을 돕고자 합니다.',
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  // 기능 소개 위젯
  Widget _buildFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '주요 기능',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        FeatureItem(
          icon: Icons.analytics_outlined,
          title: '내용 분석',
          description: '유튜브 영상의 주요 내용을 AI가 분석하여 요약합니다.',
        ),
        FeatureItem(
          icon: Icons.compare_arrows,
          title: '다양한 관점',
          description: '좌-중-우 정치적 스펙트럼에 따른 다양한 해석을 제공합니다.',
        ),
        FeatureItem(
          icon: Icons.newspaper,
          title: '관련 뉴스',
          description: '해당 이슈에 대한 다양한 언론사의 보도 자료를 제공합니다.',
        ),
        FeatureItem(
          icon: Icons.pie_chart,
          title: '보도 경향 분석',
          description: '이슈에 대한 정치적 성향별 보도 비율을 시각화합니다.',
        ),
      ],
    );
  }
}