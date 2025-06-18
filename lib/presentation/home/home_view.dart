import '../../../core/components/layouts/scaffold_layout.dart';
import '../../../ui/color.dart';
import 'package:flutter/material.dart';
import '../themes/margins_paddings.dart';
import '../views/blind_home_view.dart';
import '../views/media_bias_view.dart';
import '../views/myPage/my_page_view.dart';
import '../views/topic_home_view.dart';
import 'feed_view.dart';

class HomeView extends StatefulWidget {

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>{

  int currentIndex = 0;

  final List<Widget> _pages = [
    FeedView(),
    TopicHomeView(),
    BlindHomeView(),
    MediaBiasView(),
    MyPageView(),
  ];

  final List<String?> appBarTitles = [
    null,
    '토픽',
    '사각지대',
    '매체 성향',
    '마이페이지'

  ];

  setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: currentIndex == 0? AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: AppBar().preferredSize.height,
        elevation: 0,
        title: Ink(
            color: AppColors.primaryLight,
            height: AppBar().preferredSize.height,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: MyPaddings.mediumLarge),
                  child: Image.asset('assets/images/logo/logo_black.jpeg'),
                ))
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_none_rounded, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ) : null,
      appBarTitle: appBarTitles[currentIndex],
      body: Ink(
        color: AppColors.background,
        child: _pages[currentIndex]
      ),
      currentIndex: 0,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index){
          setCurrentIndex(index);
        },
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryLight,
            icon: Icon(Icons.home_filled), label: '홈', ),
          BottomNavigationBarItem(icon: Icon(Icons.numbers), label: '토픽'),
          BottomNavigationBarItem(icon: Icon(Icons.visibility_off_outlined), label: '사각지대'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper_rounded), label: '매체'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지')
        ]),
    );
  }
}