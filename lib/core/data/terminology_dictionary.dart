import 'package:flutter/material.dart';

class TermDefinition {
  final String term;
  final String category;
  final String shortDef;
  final String detailedDef;
  final List<String> examples;
  final Map<String, String> statistics;
  final List<String> relatedTerms;
  final String source;
  final IconData icon;
  final Color categoryColor;

  const TermDefinition({
    required this.term,
    required this.category,
    required this.shortDef,
    required this.detailedDef,
    required this.examples,
    required this.statistics,
    required this.relatedTerms,
    required this.source,
    required this.icon,
    required this.categoryColor,
  });
}

class TerminologyDictionary {
  static const Map<String, TermDefinition> terms = {
    '재생에너지': TermDefinition(
      term: '재생 에너지',
      category: '환경/에너지',
      shortDef: '자연에서 지속적으로 얻을 수 있는 친환경 에너지',
      detailedDef: '태양광, 풍력, 수력, 지열, 바이오매스 등 자연계에 존재하는 에너지원으로부터 얻어지는 에너지입니다.',
      examples: [
        '태양광 발전소',
        '해상 풍력 단지',
        '소수력 발전',
      ],
      statistics: {
        '전세계 비중': '29.1%',
        '한국 현재': '6.5%',
        '2030 목표': '20%',
      },
      relatedTerms: ['탄소중립', 'ESG', '그린뉴딜'],
      source: '국제재생에너지기구(IRENA)',
      icon: Icons.eco,
      categoryColor: Colors.green,
    ),
    
    '탄소중립': TermDefinition(
      term: '탄소중립',
      category: '환경/기후',
      shortDef: '이산화탄소 배출량과 흡수량을 같게 만드는 것',
      detailedDef: '온실가스 배출을 최대한 줄이고, 불가피한 배출량은 산림 조성, 탄소 포집 등으로 상쇄시켜 실질적인 배출량을 0으로 만드는 것입니다.',
      examples: [
        '전기차 보급 확대',
        '재생에너지 전환',
        '탄소 포집 기술',
      ],
      statistics: {
        '한국 목표': '2050년',
        'EU 목표': '2050년',
        '중국 목표': '2060년',
      },
      relatedTerms: ['재생 에너지', '그린뉴딜', 'NET-ZERO'],
      source: '환경부',
      icon: Icons.nature,
      categoryColor: Colors.green,
    ),

    '그린뉴딜': TermDefinition(
      term: '그린뉴딜',
      category: '정책/경제',
      shortDef: '기후변화 대응과 경제성장을 동시에 추구하는 정책',
      detailedDef: '친환경 산업 육성을 통해 기후변화에 대응하면서 새로운 일자리를 창출하고 경제성장을 도모하는 종합적인 정책 패키지입니다.',
      examples: [
        '스마트 그린도시',
        '그린 모빌리티',
        '친환경 에너지',
      ],
      statistics: {
        '투자 규모': '73.4조원',
        '일자리 창출': '65만 9천개',
        '기간': '2021~2025년',
      },
      relatedTerms: ['재생 에너지', '탄소중립', 'K-뉴딜'],
      source: '기획재정부',
      icon: Icons.trending_up,
      categoryColor: Colors.blue,
    ),

    'ESG': TermDefinition(
      term: 'ESG',
      category: '경제/투자',
      shortDef: '환경, 사회, 지배구조를 고려한 경영 및 투자 방식',
      detailedDef: 'Environmental(환경), Social(사회), Governance(지배구조)의 약자로, 기업의 지속가능성을 평가하는 투자 지표입니다.',
      examples: [
        '친환경 경영',
        '사회공헌 활동',
        '투명한 경영구조',
      ],
      statistics: {
        '글로벌 ESG 투자': '35조달러',
        '한국 ESG 펀드': '19조원',
        '연평균 증가': '15%',
      },
      relatedTerms: ['지속가능경영', 'SDGs', '임팩트 투자'],
      source: '금융감독원',
      icon: Icons.account_balance,
      categoryColor: Colors.purple,
    ),

    '디지털 전환': TermDefinition(
      term: '디지털 전환',
      category: '기술/산업',
      shortDef: '디지털 기술을 활용한 업무 방식과 비즈니스 모델의 변화',
      detailedDef: 'AI, 빅데이터, 클라우드 등 디지털 기술을 도입하여 기존의 업무 프로세스와 비즈니스 모델을 혁신하는 과정입니다.',
      examples: [
        '원격근무 시스템',
        'AI 자동화',
        '디지털 헬스케어',
      ],
      statistics: {
        '투자 규모': '58.2조원',
        '디지털 일자리': '90만개',
        '기업 도입률': '67%',
      },
      relatedTerms: ['AI', '빅데이터', '클라우드', 'IoT'],
      source: '과학기술정보통신부',
      icon: Icons.computer,
      categoryColor: Colors.orange,
    ),

    '메타버스': TermDefinition(
      term: '메타버스',
      category: '기술/가상',
      shortDef: '가상과 현실이 융합된 3차원 디지털 공간',
      detailedDef: 'Meta(초월)와 Universe(우주)의 합성어로, 현실과 가상이 융합되어 경제적, 사회적 활동이 가능한 3차원 가상 세계입니다.',
      examples: [
        '가상현실 회의',
        'NFT 거래',
        '메타버스 교육',
      ],
      statistics: {
        '시장 규모': '8조원',
        '이용자 수': '4억명',
        '성장률': '47%',
      },
      relatedTerms: ['VR', 'AR', 'NFT', '블록체인'],
      source: '한국정보화진흥원',
      icon: Icons.view_in_ar,
      categoryColor: Colors.cyan,
    ),
  };

  static TermDefinition? findTerm(String text) {
    // 정확한 매칭을 먼저 시도
    for (String term in terms.keys) {
      if (text.contains(term)) {
        return terms[term];
      }
    }
    
    // 부분 매칭 시도 (공백 제거 후)
    String cleanText = text.replaceAll(' ', '');
    for (String term in terms.keys) {
      String cleanTerm = term.replaceAll(' ', '');
      if (cleanText.contains(cleanTerm)) {
        return terms[term];
      }
    }
    
    return null;
  }

  static List<String> getAllTerms() {
    return terms.keys.toList();
  }
}