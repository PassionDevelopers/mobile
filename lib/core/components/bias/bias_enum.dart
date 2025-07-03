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

