import 'dart:async';

class TabReselectionEvent {
  static final StreamController<int> _controller = 
      StreamController<int>.broadcast();

  static Stream<int> get stream => _controller.stream;

  static void notifyTabReselected(int tabIndex) {
    _controller.add(tabIndex);
  }
}