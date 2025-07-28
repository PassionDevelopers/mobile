
import 'package:could_be/core/components/alert/dialog.dart';
import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({super.key, this.backButtonVisible = false, required this.appBar,
    required this.onSearchSubmitted, this.onNoticePressed});

  final void Function(String query) onSearchSubmitted;
  final void Function()? onNoticePressed;
  final Widget appBar;
  final bool backButtonVisible;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool _isSearchActive = false;
  final TextEditingController _searchController = TextEditingController();

  void closeSearch() {
    if (_isSearchActive) {
      setState(() {
        _isSearchActive = false;
        _searchController.clear();
        FocusScope.of(context).unfocus();
      });
    }
  }

  void _toggleSearch() {
    setState(() {
      if (_isSearchActive) {
        if(_searchController.text.isNotEmpty){
          _searchController.clear();
        }else{
          closeSearch();
        }
      } else {
        _isSearchActive = true;
      }
    });
  }

  void _handleSearchSubmitted(String query) {
    if(query.trim().isEmpty){
      showMyToast(msg: '검색어를 입력하세요',);
    }else if(query.trim().length >20){
      showMyToast(msg: '검색어는 20자 이내로 입력해주세요');
    }else{
      widget.onSearchSubmitted(query);
    }
  }

  Widget _buildSearchField() {
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
    return TapRegion(
      onTapOutside: (event) {
        closeSearch();
      },
      child: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: widget.backButtonVisible,
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: AppBar().preferredSize.height,
        elevation: 0,
        title:
        _isSearchActive
            ? _buildSearchField()
            : widget.appBar,
        actions: [
          IconButton(
            icon: Icon(_isSearchActive ? Icons.close : Icons.search_rounded),
            onPressed: _toggleSearch,
          ),
          if(widget.onNoticePressed != null && _isSearchActive) GestureDetector(
            onTap: widget.onNoticePressed,
            child: Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
    );
  }
}