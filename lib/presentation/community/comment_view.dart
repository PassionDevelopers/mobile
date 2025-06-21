import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import '../../core/many_use.dart';

class CommentView extends StatefulWidget {
  const CommentView({super.key});

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final ScrollController scrollController = ScrollController();
  final SlidingUpPanelController panelController = SlidingUpPanelController();
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanelWidget(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [BoxShadow(blurRadius: 5.0,spreadRadius: 2.0,color: const Color(0x11000000))],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Icon(Icons.menu,size: 30,),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0,),
                  ),
                  autoSizeText('사용자 의견', fontWeight: FontWeight.bold, fontSize: 16,),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            Divider(
              height: 0.5,
              color: Colors.grey[300],
            ),
            Flexible(
              child: Container(
                child: ListView.separated(
                  controller: scrollController,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('list item $index'),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 0.5,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: 20,
                ),
                color: Colors.white,
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
      controlHeight: 50.0,
      anchor: 0.4,
      panelController: panelController,
      onTap: (){
        ///Customize the processing logic
        if(SlidingUpPanelStatus.expanded==panelController.status){
          panelController.collapse();
        }else{
          panelController.expand();
        }
      },  //Pass a onTap callback to customize the processing logic when user click control bar.
      enableOnTap: true,//Enable the onTap callback for control bar.
      dragDown: (details){
        print('dragDown');
      },
      dragStart: (details){
        print('dragStart');
      },
      dragCancel: (){
        print('dragCancel');
      },
      dragUpdate: (details){
        print('dragUpdate,${panelController.status==SlidingUpPanelStatus.dragging?'dragging':''}');
      },
      dragEnd: (details){
        print('dragEnd');
      },
    );
  }
}


