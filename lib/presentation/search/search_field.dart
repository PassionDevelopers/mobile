
import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';

import '../../core/analytics/analytics_event_names.dart';
import '../../core/analytics/analytics_parameter_keys.dart';
import '../../core/analytics/analytics_screen_names.dart';
import '../../core/analytics/unified_analytics_helper.dart';

class MySearchField extends StatefulWidget {
  const MySearchField({super.key, this.backButtonVisible = false,
    required this.onSearchSubmitted});

  final void Function(String query) onSearchSubmitted;
  final bool backButtonVisible;

  @override
  State<MySearchField> createState() => _MySearchFieldState();
}

class _MySearchFieldState extends State<MySearchField> {
  final TextEditingController _searchController = TextEditingController();

  void closeSearch() {
    FocusScope.of(context).unfocus();
  }

  void _toggleSearch() {
    setState(() {
      if(_searchController.text.isNotEmpty){
        _searchController.clear();
        UnifiedAnalyticsHelper.logEvent(
          name: AnalyticsEventNames.clearSearch,
        );
      }
    });
  }

  void _handleSearchSubmitted(String query) {
    if(query.trim().isEmpty){
      showMyToast(msg: '검색어를 입력하세요',);
    }else if(query.trim().length >20){
      showMyToast(msg: '검색어는 20자 이내로 입력해주세요');
    }else{
      UnifiedAnalyticsHelper.logEvent(
        name: AnalyticsEventNames.search,
        parameters: {
          AnalyticsParameterKeys.searchTerm: query.trim(),
          AnalyticsParameterKeys.searchType: AnalyticsParameterKeys.searchTypeIssue,
        },
      );
      widget.onSearchSubmitted(query);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (event) {
        closeSearch();
      },
      child: SizedBox(
        height: 46,
        child: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            fillColor: AppColors.gray50,
            hintText: '검색어를 입력하세요',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.black),
            ),
            hintStyle: TextStyle(color: AppColors.gray400),
            suffixIcon: GestureDetector(
              onTap: _toggleSearch,
              child: Icon(_searchController.text.isNotEmpty ? Icons.close : Icons.search_rounded),
            ),
          ),
          style: TextStyle(color: AppColors.black, fontSize: 14),

          onSubmitted: _handleSearchSubmitted,
        ),
      ),
    );
  }
}