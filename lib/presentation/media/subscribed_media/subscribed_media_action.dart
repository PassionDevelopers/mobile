

sealed class SubscribedMediaAction {
  const SubscribedMediaAction();

  factory SubscribedMediaAction.onRefresh() => OnRefresh();
  factory SubscribedMediaAction.onTapWholeMedia() => OnTapWholeMedia();
  factory SubscribedMediaAction.onTapSpecificMediaArticles({required String sourceId}) => OnTapSpecificMediaArticles(sourceId: sourceId);
  factory SubscribedMediaAction.onTapMediaDetail({required String sourceId}) => OnTapMediaDetail(sourceId: sourceId);


}

final class OnRefresh extends SubscribedMediaAction {
  const OnRefresh();
}

final class OnTapWholeMedia extends SubscribedMediaAction {
  const OnTapWholeMedia();
}

final class OnTapSpecificMediaArticles extends SubscribedMediaAction {
  final String sourceId;
  const OnTapSpecificMediaArticles({required this.sourceId});
}

final class OnTapMediaDetail extends SubscribedMediaAction {
  final String sourceId;
  const OnTapMediaDetail({required this.sourceId});
}




