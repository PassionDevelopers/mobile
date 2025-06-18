import 'package:flutter/material.dart';
import '../../data/dataSource/issue_dto.dart';
import '../../domain/entities/issue.dart';
import '../../domain/models/coverage_spectrum_model.dart';
import 'cards/news_card.dart';

class DailyIssueFeed extends StatelessWidget {
  const DailyIssueFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return NewsCard(
      issue: Issue(
        id: '',
        summary: 'summary',
        title: '대한민국, 세계 경제 1위 국가로 부상',
        createdAt: DateTime.now(),
        category: 'sdf',
        keywords: ['경제'],
        imageUrl: 'https://picsum.photos/200/300',
        view: 4,
        coverageSpectrum: CoverageSpectrumModel(left: 1, right: 1, center: 1, centerLeft: 1, centerRight: 1, total: 2),
        updatedAt: DateTime.now(),
      ),
      isDailyIssue: true,
    );
  }
}
