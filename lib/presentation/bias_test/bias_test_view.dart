import 'package:flutter/material.dart';

import 'bias_result_view.dart';

class PMTIQuestion {
  final String text;
  final String dimension; // 예: 'E/C'
  final String leanToward; // 예: 'E' or 'C'

  PMTIQuestion({
    required this.text,
    required this.dimension,
    required this.leanToward,
  });
}


class PMTITestPage extends StatefulWidget {
  const PMTITestPage({super.key});

  @override
  State<PMTITestPage> createState() => _PMTITestPageState();
}

class _PMTITestPageState extends State<PMTITestPage> {
  final Map<int, int> answers = {};
  final List<PMTIQuestion> questions = [
    // [E/C] Economic vs. Communal
    PMTIQuestion(
      text: '부유한 사람은 더 많은 세금을 내야 하며, 그 재원은 사회적 약자를 위해 사용되어야 한다.',
      dimension: 'E/C',
      leanToward: 'C',
    ),
    PMTIQuestion(
      text: '정부는 시장에 최대한 개입하지 말고 자율적으로 운영되게 해야 한다.',
      dimension: 'E/C',
      leanToward: 'E',
    ),
    PMTIQuestion(
      text: '경제 성장은 민간 주도의 자유 경쟁이 이끌어야 한다.',
      dimension: 'E/C',
      leanToward: 'E',
    ),
    PMTIQuestion(
      text: '복지제도는 국가의 가장 중요한 역할 중 하나다.',
      dimension: 'E/C',
      leanToward: 'C',
    ),
    PMTIQuestion(
      text: '일자리를 창출하려면 기업 규제를 완화해야 한다.',
      dimension: 'E/C',
      leanToward: 'E',
    ),

    // [A/T] Authoritarian vs. Tolerant
    PMTIQuestion(
      text: '사회 질서를 유지하기 위해 표현의 자유가 어느 정도 제한되는 것은 필요하다.',
      dimension: 'A/T',
      leanToward: 'A',
    ),
    PMTIQuestion(
      text: '정부는 시민의 윤리와 도덕에 개입해서는 안 된다.',
      dimension: 'A/T',
      leanToward: 'T',
    ),
    PMTIQuestion(
      text: '정치적 올바름은 표현의 자유를 억압하는 경향이 있다.',
      dimension: 'A/T',
      leanToward: 'A',
    ),
    PMTIQuestion(
      text: '다양한 사회 집단이 자유롭게 목소리를 낼 수 있어야 건강한 사회다.',
      dimension: 'A/T',
      leanToward: 'T',
    ),
    PMTIQuestion(
      text: '전통적인 가족 가치관은 법적으로도 보호받아야 한다.',
      dimension: 'A/T',
      leanToward: 'A',
    ),

    // [N/P] Nationalist vs. Pluralist
    PMTIQuestion(
      text: '외국인 이민은 우리 문화와 정체성을 위협할 수 있다.',
      dimension: 'N/P',
      leanToward: 'N',
    ),
    PMTIQuestion(
      text: '다문화 사회는 국가를 더 창의적이고 풍요롭게 만든다.',
      dimension: 'N/P',
      leanToward: 'P',
    ),
    PMTIQuestion(
      text: '국제기구나 세계 인권 기준이 국내 법보다 우선되어야 한다.',
      dimension: 'N/P',
      leanToward: 'P',
    ),
    PMTIQuestion(
      text: '전통 문화와 민족 정체성은 절대적으로 지켜져야 한다.',
      dimension: 'N/P',
      leanToward: 'N',
    ),
    PMTIQuestion(
      text: '외국인도 우리 사회의 동등한 구성원으로 받아들여야 한다.',
      dimension: 'N/P',
      leanToward: 'P',
    ),

    // [R/S] Radical vs. Systemic
    PMTIQuestion(
      text: '지금의 정치 시스템은 근본적으로 바뀌어야 한다.',
      dimension: 'R/S',
      leanToward: 'R',
    ),
    PMTIQuestion(
      text: '제도 안에서의 점진적 개혁이 더 현실적인 방법이다.',
      dimension: 'R/S',
      leanToward: 'S',
    ),
    PMTIQuestion(
      text: '기존 정치 세력은 모두 기득권이며, 새로운 정치 세력이 필요하다.',
      dimension: 'R/S',
      leanToward: 'R',
    ),
    PMTIQuestion(
      text: '정치란 타협과 점진적인 변화로 이루어져야 한다.',
      dimension: 'R/S',
      leanToward: 'S',
    ),
    PMTIQuestion(
      text: '혁명적 변화 없이 진정한 사회 정의는 실현될 수 없다.',
      dimension: 'R/S',
      leanToward: 'R',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PMTI 테스트')),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final q = questions[index];
          return Card(
            margin: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('${index + 1}. ${q.text}'),
                ),
                Slider(
                  value: (answers[index] ?? 3).toDouble(),
                  onChanged: (val) {
                    setState(() {
                      answers[index] = val.round();
                    });
                  },
                  divisions: 4,
                  min: 1,
                  max: 5,
                  label: '${answers[index] ?? 3}',
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _calculateResult,
        label: Text('결과 보기'),
        icon: Icon(Icons.analytics),
      ),
    );
  }

  void _calculateResult() {
    final Map<String, int> dimensionScore = {
      'E': 0, 'C': 0,
      'A': 0, 'T': 0,
      'N': 0, 'P': 0,
      'R': 0, 'S': 0,
    };

    for (int i = 0; i < questions.length; i++) {
      final q = questions[i];
      final answer = answers[i] ?? 3;
      final agreeLevel = 6 - answer; // 1(매우 그렇다) → +5

      dimensionScore[q.leanToward] = (dimensionScore[q.leanToward] ?? 0) + agreeLevel;
    }

    String result = '';
    result += (dimensionScore['E']! >= dimensionScore['C']!) ? 'E' : 'C';
    result += (dimensionScore['A']! >= dimensionScore['T']!) ? 'A' : 'T';
    result += (dimensionScore['N']! >= dimensionScore['P']!) ? 'N' : 'P';
    result += (dimensionScore['R']! >= dimensionScore['S']!) ? 'R' : 'S';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PMTIResultPage(result: result),
      ),
    );
  }
}
