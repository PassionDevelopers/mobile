import 'package:flutter/material.dart';

class IssueTrackerScreen extends StatefulWidget {
  @override
  _IssueTrackerScreenState createState() => _IssueTrackerScreenState();
}

class _IssueTrackerScreenState extends State<IssueTrackerScreen> {
  int selectedKeywordIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // 메인 컨텐츠
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // 헤더 카드


                  SizedBox(height: 20),

                  // 이슈 타임라인 카드들
                  Expanded(
                    child: ListView(
                      children: [
                        _buildIssueCard(),
                        SizedBox(height: 12),
                        _buildIssueCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 카드 헤더
          Row(
            children: [
              Text(
                '이슈 타이틀',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Spacer(),
              Icon(Icons.bookmark_border, color: Colors.grey, size: 20),
            ],
          ),

          SizedBox(height: 16),

          // 키워드 태그들
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF4A90E2).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '이슈 키워드1',
                  style: TextStyle(
                    color: Color(0xFF4A90E2),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF50C878).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '이슈 키워드2',
                  style: TextStyle(
                    color: Color(0xFF50C878),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // 진행바
          Container(
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
            ),
            child: LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF50C878)),
            ),
          ),

          SizedBox(height: 12),

          // 하단 정보
          Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.grey, size: 14),
              SizedBox(width: 4),
              Text(
                '13개 매체',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 16),
              Icon(Icons.access_time, color: Colors.grey, size: 14),
              SizedBox(width: 4),
              Text(
                '1주전',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              Spacer(),
              Icon(Icons.visibility, color: Colors.grey, size: 14),
              SizedBox(width: 4),
              Text(
                '조회수 14',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}