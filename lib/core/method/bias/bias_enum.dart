enum Bias{
  left,
  leftCenter,
  right,
  rightCenter,
  center;

  String toPerspective(){
    switch (this) {
      case Bias.left:
        return 'left';
      case Bias.leftCenter:
        return 'center_left';
      case Bias.right:
        return 'right';
      case Bias.rightCenter:
        return 'center_right';
      default:
        return 'center';
    }
  }
}

enum BiasScorePeriod {
  week,
  month,
  year;

  String get displayName {
    switch (this) {
      case BiasScorePeriod.week:
        return '일주일';
      case BiasScorePeriod.month:
        return '한달';
      case BiasScorePeriod.year:
        return '일년';
    }
  }
}

