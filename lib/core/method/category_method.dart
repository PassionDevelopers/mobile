String getCategoryDisplayName(String category) {
  return switch(category) {
    'politics' => '정치',
    'economy' => '경제',
    'society' => '사회',
    'culture' => '문화',
    'international' => '세계',
    'technology' => '기술',
    _ => category,
  };
}