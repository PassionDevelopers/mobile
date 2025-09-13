import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/data/data_source/cache/deep_link_storage.dart';
import 'package:could_be/domain/useCases/fcm_use_case.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/analytics_parameter_keys.dart';
import 'package:could_be/core/analytics/analytics_screen_names.dart';
import '../../../core/components/layouts/scaffold_layout.dart';
import '../../core/themes/color.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  final Widget body;
  final int currentPageIndex;
  final void Function(int index) setCurrentIndex;

  const HomeView({
    super.key,
    required this.body,
    required this.currentPageIndex,
    required this.setCurrentIndex,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver{

  late final HomeViewModel viewModel;
  final fcmUseCase = getIt<FcmUseCase>();

  StreamSubscription<Uri>? _linkSubscription;
  
  final List<String> _tabNames = ['Home', 'Topic', 'Blind Spot', 'Media', 'My Page'];

  Future<void> initDeepLinks() async {
    // Handle links
    _linkSubscription = getIt<AppLinks>().uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      openAppLink(uri);
    });

  }

  void openAppLink(Uri uri) {
    getIt<DeepLinkStorage>().changeDeepLink(uri.path);
    Map<String, String> queryParameters = uri.queryParameters;
    debugPrint('queryParameters: $queryParameters');

    if(queryParameters.containsKey('issueId')){
      String? issueId = queryParameters['issueId'];
      if(issueId != null && issueId.isNotEmpty){
        UnifiedAnalyticsHelper.logNavigationEvent(
          fromScreen: AnalyticsScreenNames.deepLinkScreen,
          toScreen: AnalyticsScreenNames.issueDetailFeedScreen,
          parameters: {
            AnalyticsParameterKeys.issueId: issueId,
            AnalyticsParameterKeys.source: AnalyticsScreenNames.deepLinkScreen
          },
        );
        context.push('${RouteNames.issueDetailFeed}/$issueId');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = getIt<HomeViewModel>();
    fcmUseCase.initListeners(context);
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration.zero, () {
      viewModel.showNotice(context);
    });

    initDeepLinks();
  }

  @override
  void dispose() {
    viewModel.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      currentNavigationIndex: widget.currentPageIndex,
      onNavigationChanged: (index) {
        UnifiedAnalyticsHelper.logEvent(
          name: AnalyticsEventNames.tabNavigation,
          parameters: {
            AnalyticsParameterKeys.tabName: _tabNames[index],
          },
        );
        widget.setCurrentIndex(index);
      },
      body: Ink(color: AppColors.white, child: widget.body),
    );
  }
}
