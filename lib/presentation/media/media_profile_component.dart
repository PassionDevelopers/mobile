import 'package:could_be/domain/entities/source.dart';
import 'package:flutter/material.dart';
import '../../ui/color.dart';
import '../../ui/fonts.dart';
import '../../core/components/bias/bias_enum.dart';
import '../../core/method/bias/bias_method.dart';
import 'media_components.dart';

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({super.key, required this.bias, required this.name});

  final Bias bias;
  final String name;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double smaller =
            constraints.biggest.height < constraints.biggest.width
                ? constraints.biggest.height
                : constraints.biggest.width;
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: getBiasColor(bias)),
          ),
          child: CircleAvatar(
            radius: smaller / 2,
            child: ClipOval(
              child: Image(
                image: AssetImage('assets/images/news_logo/$name.jpeg'),
                fit: BoxFit.cover,
                height: smaller * 0.9,
              ),
            ),
          ),
        );
      },
    );
  }
}

class MediaProfile extends StatelessWidget {
  const MediaProfile({
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
                            height: 70,
                            width: 70,
                            child: Card(
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(source.logoUrl),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          height: 20,
                          width: 70,
                          // padding: EdgeInsets.symmetric(horizontal: 4),
                          // decoration: BoxDecoration(
                          //   color: getBiasColor(bias).withAlpha(70),
                          //   borderRadius: BorderRadius.circular(10),
                          //   border: Border.all(color: getBiasColor(bias)),
                          // ),
                          child: Center(child: MyText.reg(source.name, )),
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
                              color: source.isSubscribed? AppColors.check : AppColors.gray3,
                              shape: BoxShape.circle,
                            ),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Icon(
                                source.isSubscribed? Icons.check_circle_outlined : Icons.add_circle_outline,
                                color: AppColors.primaryLight,
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
                width: 74,
                height: 106,
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
                              color: source.isSubscribed? AppColors.check : AppColors.gray3,
                              shape: BoxShape.circle,
                            ),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Icon(
                                source.isSubscribed? Icons.check_circle_outlined : Icons.add_circle_outline,
                                color: AppColors.primaryLight,
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
