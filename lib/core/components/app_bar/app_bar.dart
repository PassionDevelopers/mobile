import 'dart:developer';

import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../../ui/color.dart';
import '../../themes/margins_paddings.dart';
import '../../responsive/responsive_utils.dart';
import '../../responsive/responsive_layout.dart';

class MainAppBar extends StatefulWidget {
  const MainAppBar({super.key, required this.onSearchSubmitted});

  final void Function(String query) onSearchSubmitted;

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  bool _isSearchActive = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    log('Search detected!!!!!!!!!!!!!! $_isSearchActive');

    setState(() {
      if (_isSearchActive) {
        log('Search deactivated');
        _searchController.clear();
      } else {
        log('Search activated');
        _isSearchActive = true;
      }
    });
  }

  void _handleSearchSubmitted(String query) {
    if (query.trim().isNotEmpty) {
      // 나중에 검색 로직을 여기에 추가
      widget.onSearchSubmitted(query);
    }
  }

  Widget _buildLogo(bool isDesktop) {
    final toolbarHeight = isDesktop ? 80.0 : AppBar().preferredSize.height;

    return Ink(
      color: AppColors.primaryLight,
      height: toolbarHeight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical:
                isDesktop
                    ? MyPaddings.large.toDouble()
                    : MyPaddings.mediumLarge.toDouble(),
            horizontal: isDesktop ? MyPaddings.large.toDouble() : 0,
          ),
          child: Image.asset(
            'assets/images/logo/logo_black.jpeg',
            height: isDesktop ? 50 : 40,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: '검색어를 입력하세요',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.black),
          ),
          hintStyle: TextStyle(color: Colors.grey),
        ),
        style: TextStyle(color: Colors.black),
        onSubmitted: _handleSearchSubmitted,
        // onTapOutside: (event) {
        //   if (_isSearchActive) {
        //     setState(() {
        //       _isSearchActive = false;
        //     });
        //   }
        // },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final toolbarHeight = isDesktop ? 80.0 : AppBar().preferredSize.height;

    return TapRegion(
      onTapOutside: (event) {
        if (_isSearchActive) {
          setState(() {
            _isSearchActive = false;
            _searchController.clear();
            FocusScope.of(context).unfocus();
          });
        }
      },
      child: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: toolbarHeight,
        elevation: 0,
        title:
            _isSearchActive
                ? _buildSearchField(isDesktop)
                : _buildLogo(isDesktop),
        actions: [
          IconButton(
            icon: Icon(_isSearchActive ? Icons.close : Icons.search_rounded),
            onPressed: _toggleSearch,
          ),
        ],
      ),
    );
  }
}

class RegAppBar extends StatelessWidget {
  const RegAppBar({
    super.key,
    this.iconData,
    required this.title,
    this.actions,
  });

  final IconData? iconData;
  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final toolbarHeight = isDesktop ? 80.0 : AppBar().preferredSize.height;

    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: !isDesktop,
      // 데스크탑에서는 back button 숨김
      backgroundColor: AppColors.primaryLight,
      toolbarHeight: toolbarHeight,
      elevation: 0,
      title: Ink(
        color: AppColors.primaryLight,
        height: toolbarHeight,
        child: Row(
          children: [
            Icon(iconData, size: isDesktop ? 28 : 24),
            SizedBox(
              width:
                  isDesktop
                      ? MyPaddings.extraLarge.toDouble()
                      : MyPaddings.large.toDouble(),
            ),
            Expanded(child: MyText.h2(title, fontSize: isDesktop ? 20 : null)),
          ],
        ),
      ),
      actions: actions,
    );
  }
}
