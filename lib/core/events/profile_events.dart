
import 'dart:async';

class ProfileEvents {
  static final StreamController<String?> _profileController =
      StreamController<String?>.broadcast();

  static Stream<String?> get profileStream => _profileController.stream;

  static void notifyProfileUpdated(String? imageUrl) {
    _profileController.add(imageUrl);
  }
}