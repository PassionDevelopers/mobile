
import 'package:flutter/material.dart';

class ArticleComponents extends StatelessWidget {
  const ArticleComponents({super.key, required this.content, required this.keywords});
  final String content;
  final List<String> keywords;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Keywords: ${keywords.join(', ')}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          Text(
            content,
            style: TextStyle(height: 1.6),
          ),
        ],
      ),
    );
  }
}
