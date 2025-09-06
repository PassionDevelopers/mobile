import 'package:card_swiper/card_swiper.dart';
import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/onboarding/onboarding_last_page.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int currentIndex = 0;
  final PageController controller = PageController();

  late final List<Widget> pages = [
    _buildOnboardingPage(imageFileName: 'daily_issue.webp'),
    _buildOnboardingPage(imageFileName: 'major_comment.webp'),
    _buildOnboardingPage(imageFileName: 'vote.webp'),
    const OnboardingLastPage(),
  ];

  late final List<Widget> titles = [
    _buildOnboardingTitle(
      mainTitle: '데일리 이슈',
      subTitle1: '다양한 시각으로 보는',
      subTitle2: '오늘의 주요 이슈.',
    ),
    _buildOnboardingTitle(
      mainTitle: '대표 의견',
      subTitle1: '다른 사용자들과 생각을 공유하고',
      subTitle2: '함께 시야를 넓혀가요.',
    ),
    _buildOnboardingTitle(
      mainTitle: '나의 성향',
      subTitle1: '스스로 판단하는 습관을 기르고',
      subTitle2: '나의 가치관을 만들어가요.',
    ),
    _buildOnboardingTitle(
      mainTitle: '현재 나의 성향',
      subTitle1: '사용자님의 현재 성향을',
      subTitle2: '알려주세요.',
    ),
  ];

  Widget _buildOnboardingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentIndex == 0
            ? const SizedBox(height: 48)
            : IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  if (currentIndex != 0) {
                    controller.previousPage(
                      duration: Duration(milliseconds: 500),
                    curve: Curves.ease,);
                  }
                });
              },
            ),
        currentIndex == pages.length-1?
            TextButton(
              onPressed: (){
                context.go(RouteNames.home);
              },
              child: MyText.h2('둘러보기', fontWeight: FontWeight.w100, color: AppColors.gray2),
            ) : const SizedBox(),
      ],
    );
  }

  Widget _buildOnboardingTitle({
    required String mainTitle,
    required String subTitle1,
    required String subTitle2,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.h0(mainTitle),
          const SizedBox(height: MyPaddings.large),
          MyText.h2(subTitle1, maxLines: 1, color: AppColors.gray2),
          MyText.h2(subTitle2, maxLines: 1, color: AppColors.gray2),

        ],
      ),
    );
  }

  Widget _buildOnboardingPage({required String imageFileName}) {
    return Container(
      margin: const EdgeInsets.all(MyPaddings.large),
      // decoration: BoxDecoration(
      //   color: Colors.grey.shade300,
      //   borderRadius: BorderRadius.circular(16),
      // ),
      width: double.infinity,
      child: Image.asset('assets/images/gif/$imageFileName', fit: BoxFit.contain),

    );
  }

  Widget _buildOnboardingBody() {
    return Expanded(
      child: PageView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: pages
      ),
    );
  }

  Widget _buildIndicator() {
    return PageIndicator(
      size: 10,
      color: AppColors.gray4,
      activeColor: AppColors.primary,
      count: pages.length,
      controller: controller,
    );
  }

  Widget _buildOnboardingButton() {
    return BigButton(
      backgroundColor: AppColors.primary,
      widget: Center(
        child: MyText.h2(
          currentIndex < pages.length-1 ? '다음' : '시작하기',
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: () {
        if (currentIndex < pages.length - 1) {
          controller.nextPage(duration: Duration(
            milliseconds: 500,
          ), curve: Curves.ease);
          return;
        }
        context.go(RouteNames.home);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegScaffold(
      isScrollPage: false,
      body: Ink(
        color: AppColors.primaryLight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: MyPaddings.large),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MyPaddings.large),
                child: _buildOnboardingHeader(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MyPaddings.large),
                child: titles[currentIndex]
              ),
              _buildOnboardingBody(),
              _buildIndicator(),
              const SizedBox(height: MyPaddings.large),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MyPaddings.large),
                child: _buildOnboardingButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
