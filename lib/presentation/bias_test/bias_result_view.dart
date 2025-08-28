import 'package:flutter/material.dart';

import 'bias_type.dart';

class PMTIResultPage extends StatelessWidget {
  final String result;
  PMTIResultPage({required this.result});

  @override
  Widget build(BuildContext context) {
    final pmti = PMTIType.getByCode('EARS');

    return Scaffold(
      appBar: AppBar(title: Text('당신의 정치 성향')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '당신의 PMTI 유형은',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              result,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Image.asset(pmti.imageAsset), // 유형별 대표 인물 이미지
            SizedBox(height: 16),
            Text(
              pmti.characterName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              pmti.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Divider(),
            Text(
              '당신과 비슷한 인물',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              pmti.exampleFigure,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

