import 'dart:developer' show log;

import 'package:flutter/material.dart';

class NestedScrollPage extends StatefulWidget {
  final Widget child;

  const NestedScrollPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<NestedScrollPage> createState() => _NestedScrollPageState();
}

class _NestedScrollPageState extends State<NestedScrollPage> {
  final ScrollController _controller = ScrollController();
  double _lastDragDelta = 0.0;
  bool _isAtTop = true;
  bool _isAtBottom = false;
  ScrollPhysics _physics = const NeverScrollableScrollPhysics();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        setState(() {
          log('NestedScrollPage: onVerticalDragStart: ${details.localPosition}');
          if(!_isAtTop && !_isAtBottom) {
            _physics = const ClampingScrollPhysics();
          }else if(_isAtTop && details.globalPosition.dy<0){
            _physics = ClampingScrollPhysics();
          }else if(_isAtBottom && details.globalPosition.dy>0) {
            _physics = ClampingScrollPhysics();
          }
          _isAtTop = _controller.position.pixels <= _controller.position.minScrollExtent + 0.5;
          _isAtBottom = _controller.position.pixels >= _controller.position.maxScrollExtent - 0.5;
        });
      },
      onVerticalDragUpdate: (details) {
        setState(() {
          log('NestedScrollPage: onVerticalDragUpdate: ${details.delta.dy}');
          if(!_isAtTop && !_isAtBottom) {
            _physics = const ClampingScrollPhysics();
          }else if(_isAtTop && details.delta.dy<0){
            log('fuckkkkkkkkkkkkkkkkkkkkk');
            _physics = ClampingScrollPhysics();
          }else if(_isAtBottom && details.delta.dy>0) {
            _physics = ClampingScrollPhysics();
          }
          _isAtTop = _controller.position.pixels <= _controller.position.minScrollExtent + 0.5;
          _isAtBottom = _controller.position.pixels >= _controller.position.maxScrollExtent - 0.5;
        });
      },
      // onVerticalDragEnd: (details) {
      //   setState(() {
      //     log('NestedScrollPage: onVerticalDragEnd: ${details.primaryVelocity}');
      //     _physics = NeverScrollableScrollPhysics();
      //   });
      // },
      // onVerticalDragCancel: () {
      //   setState(() {
      //     log('NestedScrollPage: onVerticalDragCancel');
      //     _physics = NeverScrollableScrollPhysics();
      //   });
      // },
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: _controller,
          physics: _physics,
          child: widget.child,
        ),
      ),
      // child: NotificationListener<ScrollNotification>(
      //   onNotification: (a) {
      //     // log('NestedScrollPage: onNotification: ${a.metrics}');
      //     // log('NestedScrollPage: pixels: ${a.metrics.pixels}, min: ${a.metrics.minScrollExtent}, max: ${a.metrics.maxScrollExtent}');
      //     setState(() {
      //       if(a.metrics.atEdge){
      //         if(a.metrics.pixels <= a.metrics.minScrollExtent + 0.5){
      //           _isAtTop = true;
      //           _isAtBottom = false;
      //         }else if(a.metrics.pixels >= a.metrics.maxScrollExtent - 0.5){
      //           _isAtTop = false;
      //           _isAtBottom = true;
      //         }
      //       }else{
      //         _lastDragDelta = 0.0;
      //       }
      //     });
      //     return false;
      //   },
      //   child: SingleChildScrollView(
      //     scrollDirection: Axis.vertical,
      //     controller: _controller,
      //     physics: _getDynamicPhysics(),
      //     child: widget.child,
      //   )
      // ),

    );
  }

  // ScrollPhysics _getDynamicPhysics() {
  //   // if(_isAtBottom){
  //   //   log('NestedScrollPage: _getDynamicPhysics: at bottom');
  //   // }else if(_isAtTop){
  //   //   log('NestedScrollPage: _getDynamicPhysics: at top');
  //   // }
  //   // if ((_lastDragDelta < 0 && _isAtTop) || (_lastDragDelta > 0 && _isAtBottom)) {
  //   //   return const NeverScrollableScrollPhysics(); // 내부 스크롤 막고 외부로 넘김
  //   // }
  //
  //   return const NeverScrollableScrollPhysics(); // 내부 스크롤 가능
  // }
}
