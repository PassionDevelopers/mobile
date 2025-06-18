import '../models/coverage_spectrum_model.dart';

class Issue{
  final String id;
  final String title;
  final String category;
  final String summary;

  final DateTime createdAt;
  final DateTime updatedAt;


  final List<String> keywords;
  final String? imageUrl;
  final int view;
  final CoverageSpectrumModel coverageSpectrum;

  Issue({
    required this.id,
    required this.summary,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.keywords,
    this.imageUrl,
    required this.view,
    required this.coverageSpectrum,
  });

  List<Object> get props => [
    id,
    title,
    category,
    summary,
    createdAt,
    updatedAt,
    keywords,
    imageUrl ?? '',
    view,
    coverageSpectrum
  ];
}