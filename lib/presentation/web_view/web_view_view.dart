import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewView extends StatefulWidget {
  const WebViewView({super.key, required this.url});

  final String url;

  @override
  State<WebViewView> createState() => _WebViewViewState();
}

class _WebViewViewState extends State<WebViewView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    _controller =
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
          ..loadRequest(Uri.parse(widget.url));

    if (_controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          Expanded(child: WebViewWidget(controller: _controller)),
          Container(
            child: Row(
              children: [

              ],
            ),
          )
        ],
      ),
    );
  }
}
