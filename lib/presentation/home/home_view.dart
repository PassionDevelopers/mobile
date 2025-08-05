import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/data/data_source/cache/deep_link_storage.dart';
import 'package:could_be/presentation/issue_list/issue_type.dart';
import 'package:could_be/presentation/issue_list/main/issue_list_root.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/layouts/scaffold_layout.dart';
import '../../../ui/color.dart';
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

  StreamSubscription<Uri>? _linkSubscription;

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
    if(queryParameters.containsKey('issueId')){
      String? issueId = queryParameters['issueId'];
      if(issueId != null && issueId.isNotEmpty){
        showMyToast(msg: 'Deep link opened: $uri  Navigating to: ${uri.queryParameters}');
        context.push('${RouteNames.issueDetailFeed}/$issueId');
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = getIt<HomeViewModel>();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration.zero, () {
      viewModel.showNotice(context);
    });

    initDeepLinks();
    // final deeplinkStorage = getIt<DeepLinkStorage>();
    // final String? deepLink = deeplinkStorage.getDeepLink();
    // if(deepLink != null){
    //   deeplinkStorage.clearDeepLink();
    //   Future.delayed(Duration.zero, (){
    //     if(deepLink.contains(RouteNames.issueDetailFeed)){
    //       context.push(
    //         deepLink,
    //       );
    //     }
    //   });
    // }
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
      onNavigationChanged: widget.setCurrentIndex,
      body: Ink(color: AppColors.background, child: widget.body),
    );
  }
}
