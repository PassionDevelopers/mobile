import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/source/source.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';

class MediaProfileDetail extends StatelessWidget {
  const MediaProfileDetail({super.key, required this.logoUrl});

  final String logoUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(fit: BoxFit.fill, image: NetworkImage(logoUrl)),
        ),
      ),
    );
  }
}

class MediaProfileRef extends StatelessWidget {
  const MediaProfileRef({super.key, required this.source, this.toDetailPage});

  final VoidCallback? toDetailPage;
  final Source source;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: toDetailPage,
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: Card(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(source.logoUrl),
                  ),
                ),
              ),
            ),
            SizedBox(width: 6),
            Center(child: MyText.reg(source.name, fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}

class MediaProfile extends StatelessWidget {
  const MediaProfile({
    super.key,
    required this.source,
    required this.isSelected,
    required this.onShowArticles,
  });

  final bool isSelected;
  final VoidCallback onShowArticles;
  final Source source;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: MyPaddings.medium),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onShowArticles,
        child: Container(
          padding: EdgeInsets.all(4),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 로고
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 60,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ImageContainer(
                            height: 60,
                            imageUrl: source.logoUrl,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MyPaddings.extraSmall),
                  // 언론사 이름
                  MyText.small(source.name, color: isSelected? AppColors.black : AppColors.gray400),
                  // 성향 표시
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MyPaddings.small,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: getBiasColor(source.bias).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      getBiasName(source.bias),
                      style: TextStyle(
                        color: getBiasColor(source.bias),
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              // // 구독 상태 표시
              // if (onSubscribe != null)
              //   Align(
              //     alignment: Alignment.topRight,
              //     child: Container(
              //       height: 25,
              //       width: 25,
              //       decoration: BoxDecoration(
              //         color:
              //         source.isSubscribed
              //             ? AppColors.check
              //             : AppColors.gray4,
              //         shape: BoxShape.circle,
              //       ),
              //       child: Icon(
              //         source.isSubscribed ? Icons.check : Icons.add,
              //         color: AppColors.white,
              //         size: 12,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

class MediaProfileWebView extends StatelessWidget {
  const MediaProfileWebView({
    super.key,
    required this.source,
    required this.isShowingArticles,
    this.onSubscribe,
    this.onShowArticles,
  });

  final bool isShowingArticles;
  final VoidCallback? onSubscribe;
  final VoidCallback? onShowArticles;
  final Source source;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onShowArticles,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Card(
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(source.logoUrl),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (onSubscribe != null)
                      GestureDetector(
                        onTap: onSubscribe,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color:
                                  source.isSubscribed
                                      ? AppColors.check
                                      : AppColors.gray500,
                              shape: BoxShape.circle,
                            ),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Icon(
                                source.isSubscribed
                                    ? Icons.check_circle_outlined
                                    : Icons.add_circle_outline,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (isShowingArticles)
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.black.withAlpha(50),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MediaProfileHorizontal extends StatelessWidget {
  const MediaProfileHorizontal({
    super.key,
    required this.source,
    required this.isShowingArticles,
    this.onSubscribe,
    this.onShowArticles,
    required this.isFirst,
  });

  final bool isFirst;
  final bool isShowingArticles;
  final VoidCallback? onSubscribe;
  final VoidCallback? onShowArticles;
  final Source source;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.fromLTRB(
        isFirst ? MyPaddings.large : MyPaddings.extraSmall,
        MyPaddings.extraSmall,
        MyPaddings.extraSmall,
        MyPaddings.extraSmall,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          if (onSubscribe != null) {
            onSubscribe!();
          } else if (onShowArticles != null) {
            onShowArticles!();
          }
        },
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color:
            isShowingArticles
                ? getBiasColor(source.bias).withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isShowingArticles? getBiasColor(source.bias) : Colors.transparent,
              width: isShowingArticles ? 2 : 1,
            ),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 로고
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 60,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ImageContainer(
                            height: 60,
                            imageUrl: source.logoUrl,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MyPaddings.extraSmall),
                  // 언론사 이름
                  MyText.small(source.name, color: AppColors.primary,),
                  // 성향 표시
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MyPaddings.small,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: getBiasColor(source.bias).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      getBiasName(source.bias),
                      style: TextStyle(
                        color: getBiasColor(source.bias),
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              // // 구독 상태 표시
              // if (onSubscribe != null)
              //   Align(
              //     alignment: Alignment.topRight,
              //     child: Container(
              //       height: 25,
              //       width: 25,
              //       decoration: BoxDecoration(
              //         color:
              //         source.isSubscribed
              //             ? AppColors.check
              //             : AppColors.gray4,
              //         shape: BoxShape.circle,
              //       ),
              //       child: Icon(
              //         source.isSubscribed ? Icons.check : Icons.add,
              //         color: AppColors.white,
              //         size: 12,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}


