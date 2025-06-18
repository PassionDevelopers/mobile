import 'package:flutter/material.dart';
import '../../core/components/media_components.dart';
import '../../core/components/media_profile_component.dart';
import '../../core/many_use.dart';
import '../themes/margins_paddings.dart';
import 'bias_tab_view.dart';

class MediaBiasView extends StatefulWidget {
  const MediaBiasView({super.key});

  @override
  State<MediaBiasView> createState() => _MediaBiasViewState();
}

class _MediaBiasViewState extends State<MediaBiasView> {
  final List<String> leftMedia = ['hani', 'kyungHyang', 'ohmyNews'];
  final List<String> leftMediaName = ['한겨레', '경향신문', '오마이뉴스'];

  final List<String> rightMedia = ['chosun', 'joongAng', 'dongA'];
  final List<String> rightMediaName = ['조선일보', '중앙일보', '동아일보'];

  final List<String> centerMedia = ['ytn', 'yna', 'kbs'];
  final List<String> centerMediaName = ['YTN', '연합뉴스', 'KBS'];

  final List<String> leftCenterMedia = ['mbc', 'jtbc', 'news1'];
  final List<String> leftCenterMediaName = ['MBC', 'JTBC', '뉴스1'];

  final List<String> rightCenterMedia = ['sbs', 'mbn', 'channelA'];
  final List<String> rightCenterMediaName = ['SBS', 'MBN', '채널A'];

  bool isAllMedia = false;

  Widget tabPage({required List<String> names, required List<String> fileNames, required Bias bias}){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: MyPaddings.small,
        mainAxisSpacing: MyPaddings.small,
      ),
      itemCount: names.length,
      itemBuilder: (context, index) {
        return ProfileRect(bias: bias, fileName: fileNames[index], name: names[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MyPaddings.medium),
      child: Column(
        children: [
          ElevatedButton(onPressed: (){
            setState(() {
              isAllMedia = !isAllMedia;
            });
          }, child: Text('한눈에 보기')),
          const SizedBox(height: 10,),
          Expanded(child: isAllMedia?
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediaBiasColumn(medias: leftMediaName, mediasName: leftMedia, bias: Bias.left),
              MediaBiasColumn(medias: leftCenterMediaName, mediasName: leftCenterMedia, bias: Bias.leftCenter),
              MediaBiasColumn(medias: centerMediaName, mediasName: centerMedia, bias: Bias.center),
              MediaBiasColumn(medias: rightCenterMediaName, mediasName: rightCenterMedia, bias: Bias.rightCenter),
              MediaBiasColumn(medias: rightMediaName, mediasName: rightMedia, bias: Bias.right),
            ],
          ) :
          BiasTabView5(
            tabTitles: ['진보', '중도 진보', '중도', '중도 보수', '보수'],
            biasContents: [
              tabPage(names: leftMediaName, fileNames: leftMedia, bias: Bias.left),
              tabPage(names: leftCenterMediaName, fileNames: leftCenterMedia, bias: Bias.leftCenter),
              tabPage(names: centerMediaName, fileNames: centerMedia, bias: Bias.center),
              tabPage(names: rightCenterMediaName, fileNames: rightCenterMedia, bias: Bias.rightCenter),
              tabPage(names: rightMediaName, fileNames: rightMedia, bias: Bias.right),
            ],
          ),)
        ],
      ),
    );
  }
}

class MediaBiasColumn extends StatelessWidget {
  const MediaBiasColumn({super.key, required this.medias, required this.mediasName, required this.bias});
  final List<String> medias;
  final List<String> mediasName;
  final Bias bias;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 30,
              child: autoSizeText(getBiasName(bias), fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(color: getBiasColor(bias), borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for(int index = 0; index < medias.length; index++)
                ProfileRect(bias: bias, name: medias[index], fileName: mediasName[index],)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
