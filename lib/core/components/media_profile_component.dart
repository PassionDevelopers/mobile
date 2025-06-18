import 'package:flutter/material.dart';
import '../../ui/color.dart';
import '../../ui/fonts.dart';
import 'media_components.dart';
import 'my_bottom_bar.dart';

getBiasColor(Bias bias){
  switch (bias) {
    case Bias.left:
      return AppColors.left;
    case Bias.leftCenter:
      return AppColors.leftCenter;
    case Bias.right:
      return AppColors.right;
    case Bias.rightCenter:
      return AppColors.rightCenter;
    default:
      return AppColors.center;
  }
}

getBiasName(Bias bias){
  switch (bias) {
    case Bias.left:
      return '진보';
    case Bias.leftCenter:
      return '중도 진보';
    case Bias.right:
      return '중도';
    case Bias.rightCenter:
      return '중도 보수';
    default:
      return '보수';
  }
}

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({super.key, required this.bias, required this.name});
  final Bias bias;
  final String name;

  getBiasColor(){
    switch (bias) {
      case Bias.left:
        return AppColors.left;
      case Bias.leftCenter:
        return AppColors.leftCenter;
      case Bias.right:
        return AppColors.right;
      case Bias.rightCenter:
        return AppColors.rightCenter;
      default:
        return AppColors.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double smaller = constraints.biggest.height < constraints.biggest.width ? constraints.biggest.height : constraints.biggest.width;
          return Container(
            decoration:  BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: getBiasColor())),
            child: CircleAvatar(
              radius: smaller/2,
              child: ClipOval(
                child: Image(
                  image: AssetImage('assets/images/news_logo/$name.jpeg'), fit: BoxFit.cover, height: smaller*0.9,),
              ),
            ),
          );
        }
    );
  }
}

class ProfileRect extends StatelessWidget {
  const ProfileRect({super.key, required this.bias, required this.fileName, required this.name});
  final Bias bias;
  final String fileName;
  final String name;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double smaller = constraints.biggest.height < constraints.biggest.width ? constraints.biggest.height : constraints.biggest.width;
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(smaller*0.05),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(smaller*0.1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(smaller*0.1),
                          child: Image(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/news_logo/$fileName.jpeg'), height: smaller*0.9,),
                        ),
                      ),
                    ),

                    MyText.h3(name),
                  ],
                ),
              ),
              Align(alignment: Alignment.topRight, child:
              SizedBox(height: smaller*0.4, width: smaller*0.4,
                  child: FittedBox(fit: BoxFit.fill, child: Icon(Icons.favorite_border,
                    color: AppColors.secondary, ))))
            ],
          );
        }
    );
  }
}

