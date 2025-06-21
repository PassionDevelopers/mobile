class CoverageSpectrum {
  final int left;
  final int right;
  final int centerLeft;
  final int centerRight;
  final int center;
  final int total;

  CoverageSpectrum({
    required this.left,
    required this.right,
    required this.center,
    required this.total,
    required this.centerLeft,
    required this.centerRight,
  });

  const CoverageSpectrum.empty()
      : left = 0,
        right = 0,
        center = 0,
        total = 0,
        centerLeft = 0,
        centerRight = 0;
} 