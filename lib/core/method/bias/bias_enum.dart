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
        return 'center-left';
      case Bias.right:
        return 'right';
      case Bias.rightCenter:
        return 'center-right';
      default:
        return 'center';
    }
  }
}

enum BiasScorePeriod {
  weekly,
  monthly,
  yearly;

  String get displayName {
    switch (this) {
      case BiasScorePeriod.weekly:
        return '일주일';
      case BiasScorePeriod.monthly:
        return '한달';
      case BiasScorePeriod.yearly:
        return '일년';
    }
  }
}

