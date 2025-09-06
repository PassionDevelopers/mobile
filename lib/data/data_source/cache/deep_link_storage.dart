class DeepLinkStorage{

  String? deepLink;

  void changeDeepLink(String newLink) {
    deepLink = newLink;
  }

  void clearDeepLink() {
    deepLink = null;
  }

  String? getDeepLink() {
    return deepLink;
  }
}