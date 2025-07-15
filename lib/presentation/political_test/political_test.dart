// main.dart
import 'package:flutter/material.dart';

// 질문 데이터 모델
class Question {
  final int id;
  final String question;
  final List<String> options;

  Question({
    required this.id,
    required this.question,
    required this.options,
  });
}

// 질문 데이터
class PoliticalTestData {
  static final List<Question> questions = [
    Question(
        id: 1,
        question: "경제 정책에 있어 다음 중 어떤 입장에 가장 동의하십니까?",
        options: [
          "정부의 시장 개입을 최소화하고 자유 경쟁을 통해 경제를 성장시켜야 한다.",
          "정부가 적극적으로 시장에 개입하여 소득 재분배와 복지를 강화해야 한다.",
          "기업의 사회적 책임을 강조하며 환경 보호를 우선해야 한다.",
          "경제 성장을 위해 규제를 완화하고 기업 활동의 자유를 보장해야 한다."
        ]
    ),
    Question(
        id: 2,
        question: "사회 문제 해결을 위해 어떤 가치에 더 중점을 두어야 한다고 생각하십니까?",
        options: [
          "강력한 법 집행과 질서 유지를 통해 사회 안정을 최우선해야 한다.",
          "소수자 인권 보호와 다양성 존중을 통해 포용적인 사회를 만들어야 한다.",
          "시민 사회의 자율적인 참여와 협력을 증진해야 한다.",
          "전통적인 가치를 유지하고 공동체의 중요성을 강조해야 한다."
        ]
    ),
    Question(
        id: 3,
        question: "외교 및 통일 정책에 있어 다음 중 어떤 입장이 가장 바람직하다고 보십니까?",
        options: [
          "안보 강화를 위해 한미동맹을 더욱 굳건히 하고 자주국방력을 증대해야 한다.",
          "남북 대화와 협력을 통해 평화적인 통일을 지향해야 한다.",
          "국제 사회와의 다자 외교를 강화하고 글로벌 이슈에 적극적으로 참여해야 한다.",
          "경제적 실리를 최우선으로 하여 국익에 도움이 되는 외교를 추구해야 한다."
        ]
    ),
    Question(
        id: 4,
        question: "사회 변화의 방향성에 대해 어떤 입장에 가장 가깝습니까?",
        options: [
          "과거의 경험과 전통을 존중하며 점진적인 변화를 추구해야 한다.",
          "사회 구조의 불평등을 개선하기 위해 근본적인 개혁을 추진해야 한다.",
          "개인의 자유와 창의성을 최대한 보장해야 한다.",
          "효율성과 실용성을 바탕으로 한 정책 결정이 중요하다."
        ]
    ),
    Question(
        id: 5,
        question: "정부의 역할은 어디까지여야 한다고 생각하십니까?",
        options: [
          "국민 개개인의 자율적 선택과 책임이 중요하다.",
          "정부의 역할은 사회적 약자를 보호하고 평등을 증진하는 것이다.",
          "공동체의 이익을 위해 개인의 희생이 필요할 수도 있다.",
          "시민 사회 단체의 역할이 더욱 중요해져야 한다."
        ]
    ),
    Question(
        id: 6,
        question: "부의 분배 문제에 대해 어떤 입장을 지지하십니까?",
        options: [
          "개인의 노력과 능력에 따라 부의 축적은 정당하다.",
          "부의 양극화를 해소하기 위해 부유세 강화 등 적극적인 재분배 정책이 필요하다.",
          "경제 성장을 통해 자연스럽게 부의 분배가 이루어진다.",
          "세금 감면을 통해 기업 투자를 유도해야 한다."
        ]
    ),
    Question(
        id: 7,
        question: "국방 및 안보 정책에 있어 가장 중요하게 생각하는 것은 무엇입니까?",
        options: [
          "국가 안보와 주권 유지를 위해 강력한 군사력 유지가 필수적이다.",
          "군축과 평화 협정을 통해 국제적 긴장 완화를 모색해야 한다.",
          "경제 협력을 통해 주변국과의 관계를 돈독히 해야 한다.",
          "인도적 지원과 문화 교류를 확대해야 한다."
        ]
    ),
    Question(
        id: 8,
        question: "범죄 처벌에 대한 다음 입장 중 어떤 것에 동의하십니까?",
        options: [
          "범죄자에 대한 엄정한 처벌과 법치주의 확립이 중요하다.",
          "범죄의 원인을 사회 구조적 문제에서 찾고 교화 및 재활에 힘써야 한다.",
          "피해자 보호와 지원을 더욱 강화해야 한다.",
          "사법 시스템의 투명성과 공정성을 높여야 한다."
        ]
    ),
    Question(
        id: 9,
        question: "사회적 가치관의 변화에 대해 어떤 입장을 가지고 계십니까?",
        options: [
          "기존의 전통적 가치와 가족 제도를 유지하고 보존해야 한다.",
          "젠더 평등과 성 소수자 인권 등 새로운 가치와 다양성을 존중해야 한다.",
          "개인의 행복 추구가 사회 전체의 행복으로 이어진다.",
          "세대 간의 조화와 소통을 강화해야 한다."
        ]
    ),
    Question(
        id: 10,
        question: "국가 재정 운영에 있어 어떤 방향을 선호하십니까?",
        options: [
          "국민 개개인의 세금 부담을 줄이고 정부의 지출을 효율화해야 한다.",
          "필요한 경우 재정 확대를 통해 공공 서비스와 복지를 강화해야 한다.",
          "재정 건전성을 유지하기 위해 균형 재정을 지향해야 한다.",
          "국민의 의견을 수렴하여 재정 정책을 결정해야 한다."
        ]
    ),
  ];
}

// 시작 화면
class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.poll,
                size: 100,
                color: Colors.blue[700],
              ),
              SizedBox(height: 32),
              Text(
                '한국인의 정치성향 테스트',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                '10개의 질문을 통해\n당신의 정치적 성향을 알아보세요',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    '테스트 시작하기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 질문 화면
class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  Map<int, int> answers = {};
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    final question = PoliticalTestData.questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / PoliticalTestData.questions.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (currentQuestionIndex > 0) {
              setState(() {
                currentQuestionIndex--;
                selectedOption = answers[question.id - 1];
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          '질문 ${currentQuestionIndex + 1} / ${PoliticalTestData.questions.length}',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 진행 바
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
              minHeight: 4,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text(
                    question.question,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 32),
                  Expanded(
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedOption == index;
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedOption = index;
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected ? Colors.blue[700]! : Colors.grey[300]!,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: isSelected ? Colors.blue[50] : Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected ? Colors.blue[700]! : Colors.grey[400]!,
                                        width: 2,
                                      ),
                                      color: isSelected ? Colors.blue[700] : Colors.white,
                                    ),
                                    child: isSelected
                                        ? Icon(Icons.check, size: 16, color: Colors.white)
                                        : null,
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      question.options[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.4,
                                        color: isSelected ? Colors.blue[900] : Colors.black87,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: selectedOption != null ? () {
                  answers[question.id] = selectedOption!;

                  if (currentQuestionIndex < PoliticalTestData.questions.length - 1) {
                    setState(() {
                      currentQuestionIndex++;
                      selectedOption = answers[PoliticalTestData.questions[currentQuestionIndex].id];
                    });
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(answers: answers),
                      ),
                    );
                  }
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedOption != null ? Colors.blue[700] : Colors.grey[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  currentQuestionIndex < PoliticalTestData.questions.length - 1 ? '다음' : '결과 보기',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 결과 화면
class ResultScreen extends StatelessWidget {
  final Map<int, int> answers;

  ResultScreen({required this.answers});

  Map<String, double> calculateResult() {
    double conservative = 0; // 보수
    double progressive = 0;  // 진보
    double economic_right = 0; // 경제우파
    double economic_left = 0;  // 경제좌파

    // 간단한 점수 계산 로직 (실제로는 더 정교한 분석이 필요)
    answers.forEach((questionId, answerIndex) {
      switch (questionId) {
        case 1: // 경제 정책
          if (answerIndex == 0 || answerIndex == 3) economic_right += 2;
          if (answerIndex == 1) economic_left += 2;
          if (answerIndex == 2) progressive += 1;
          break;
        case 2: // 사회 문제
          if (answerIndex == 0) conservative += 2;
          if (answerIndex == 1) progressive += 2;
          if (answerIndex == 3) conservative += 1;
          break;
        case 4: // 사회 변화
          if (answerIndex == 0) conservative += 2;
          if (answerIndex == 1) progressive += 2;
          break;
        case 9: // 사회적 가치관
          if (answerIndex == 0) conservative += 2;
          if (answerIndex == 1) progressive += 2;
          break;
      // 다른 질문들도 유사하게 점수 부여
        default:
        // 기본적으로 0,3번은 보수성향, 1,2번은 진보성향으로 가정
          if (answerIndex == 0 || answerIndex == 3) conservative += 1;
          if (answerIndex == 1 || answerIndex == 2) progressive += 1;
      }
    });

    return {
      'conservative': conservative,
      'progressive': progressive,
      'economic_right': economic_right,
      'economic_left': economic_left,
    };
  }

  String getPoliticalType(Map<String, double> scores) {
    bool isProgressive = scores['progressive']! > scores['conservative']!;
    bool isEconomicLeft = scores['economic_left']! > scores['economic_right']!;

    if (isProgressive && isEconomicLeft) {
      return "진보 좌파";
    } else if (isProgressive && !isEconomicLeft) {
      return "진보 우파";
    } else if (!isProgressive && isEconomicLeft) {
      return "보수 좌파";
    } else {
      return "보수 우파";
    }
  }

  Color getTypeColor(String type) {
    switch (type) {
      case "진보 좌파": return Colors.red[600]!;
      case "진보 우파": return Colors.blue[600]!;
      case "보수 좌파": return Colors.orange[600]!;
      case "보수 우파": return Colors.green[600]!;
      default: return Colors.grey[600]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scores = calculateResult();
    final politicalType = getPoliticalType(scores);
    final typeColor = getTypeColor(politicalType);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(),
        title: Text(
          '테스트 결과',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_events,
                    size: 80,
                    color: typeColor,
                  ),
                  SizedBox(height: 24),
                  Text(
                    '당신의 정치성향은',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: typeColor, width: 2),
                    ),
                    child: Text(
                      politicalType,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: typeColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        _buildScoreBar('보수성향', scores['conservative']!, Colors.blue[600]!),
                        SizedBox(height: 12),
                        _buildScoreBar('진보성향', scores['progressive']!, Colors.red[600]!),
                        SizedBox(height: 12),
                        _buildScoreBar('경제우파', scores['economic_right']!, Colors.green[600]!),
                        SizedBox(height: 12),
                        _buildScoreBar('경제좌파', scores['economic_left']!, Colors.orange[600]!),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    '이 결과는 참고용이며, 실제 정치적 성향과\n다를 수 있습니다.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => StartScreen()),
                            (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: typeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '다시 테스트하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                      // 결과 공유 기능 (추후 구현)
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: typeColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '결과 공유하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: typeColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreBar(String label, double score, Color color) {
    final maxScore = 10.0; // 최대 점수 가정
    final normalizedScore = (score / maxScore).clamp(0.0, 1.0);

    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: normalizedScore,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Text(
          '${score.toInt()}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}