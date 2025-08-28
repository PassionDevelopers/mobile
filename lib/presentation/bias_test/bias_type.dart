class PMTIType {
  final String code;
  final String characterName;
  final String description;
  final String exampleFigure;
  final String imageAsset;

  PMTIType({
    required this.code,
    required this.characterName,
    required this.description,
    required this.exampleFigure,
    required this.imageAsset,
  });

  static PMTIType getByCode(String code) {
    return _types.firstWhere((type) => type.code == code);
  }

  static final List<PMTIType> _types = [
    PMTIType(
      code: 'CTRP',
      characterName: '급진 진보 운동가',
      description:
      '자유로운 표현과 복지를 중시하며, 다문화 사회와 급진적인 체제 개혁을 지지합니다. 사회 정의와 국제 연대에 큰 가치를 둡니다.',
      exampleFigure: '로자 룩셈부르크',
      imageAsset: 'assets/figures/ctrp.png',
    ),
    PMTIType(
      code: 'EARS',
      characterName: '질서의 수호자',
      description:
      '시장 중심의 경제와 질서를 중시하며, 국익과 전통적 가치를 지키는 점진주의 성향입니다.',
      exampleFigure: '로널드 레이건',
      imageAsset: 'assets/figures/ears.png',
    ),
    // ... 나머지 14개 유형도 추가
  ];
}
