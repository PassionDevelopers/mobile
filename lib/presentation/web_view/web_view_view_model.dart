import 'package:could_be/domain/entities/issue.dart';
import 'package:could_be/domain/useCases/fetch_articles_use_case.dart';
import 'package:could_be/presentation/web_view/web_view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import '../../core/components/bias/bias_enum.dart';
import '../../domain/entities/article.dart';
import '../../domain/entities/articles.dart';
import '../../domain/entities/issue_detail.dart';

class WebViewViewModel with ChangeNotifier{
  final FetchArticlesUseCase _fetchArticlesUseCase;

  WebViewState _state = WebViewState();
  WebViewState get state => _state;

  WebViewViewModel({
    required FetchArticlesUseCase fetchArticlesUseCase,
    String? issueId,
    Article? article,
    Bias? bias,
  }) : _fetchArticlesUseCase = fetchArticlesUseCase{
    if(issueId != null) {
      _fetchArticlesByIssueId(issueId);
    }else{
      _state = state.copyWith(
        articlesGroupBySource: Articles(
          articles: [article!], hasMore: false, lastArticleId: '',
        ).toGroupBySource()
      );
      _getWebViewController();
    }
  }

  void _getWebViewController() {
    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''Page resource error:
                          code: ${error.errorCode}
                          description: ${error.description}
                          errorType: ${error.errorType}
                          isForMainFrame: ${error.isForMainFrame}
                    ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
    // ..addJavaScriptChannel(
    //   'Toaster',
    //   onMessageReceived: (JavaScriptMessage message) {
    //     ScaffoldMessenger.of(
    //       context,
    //     ).showSnackBar(SnackBar(content: Text(message.message)));
    //   },
    // )
      ..loadRequest(Uri.parse(state.articlesGroupBySource!.articlesWithSources[state.articlesGroupBySource!.sources[state.currentSourceIndex].id]![state.currentArticleIndex].url));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _state = state.copyWith(
      controller: controller,
    );
  }

  void _fetchArticlesByIssueId(String issueId) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _fetchArticlesUseCase.fetchArticlesByIssueId(issueId);

    _state = state.copyWith(
      articlesGroupBySource: result.toGroupBySource(),
      isLoading: false,
    );

    _getWebViewController();

    notifyListeners();
  }

  void changeCurrentSourceIndex(int index) {
    _state = state.copyWith(
      currentSourceIndex: index,
      currentArticleIndex: 0,
    );
    notifyListeners();
  }

  void changeCurrentArticleIndex(int index) {
    _state = state.copyWith(
      currentArticleIndex: index,
      controller: state.controller!..loadRequest(
        Uri.parse(state.articlesGroupBySource!.articlesWithSources[state.articlesGroupBySource!.sources[state.currentSourceIndex].id]![state.currentArticleIndex].url),
      ),
    );
    notifyListeners();
  }

}