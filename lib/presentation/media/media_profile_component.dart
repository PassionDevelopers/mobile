import 'package:flutter/material.dart';
import '../../ui/color.dart';
import '../../ui/fonts.dart';
import '../../core/components/bias/bias_enum.dart';
import '../../core/components/bias/bias_method.dart';
import 'media_components.dart';

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({super.key, required this.bias, required this.name});
  final Bias bias;
  final String name;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double smaller = constraints.biggest.height < constraints.biggest.width ? constraints.biggest.height : constraints.biggest.width;
          return Container(
            decoration:  BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: getBiasColor(bias))),
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
                  child: FittedBox(fit: BoxFit.fill, child: Icon(Icons.add_circle,
                    color: AppColors.secondary, ))))
            ],
          );
        }
    );
  }
}

