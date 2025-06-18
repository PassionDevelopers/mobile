import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../core/many_use.dart';
import '../../ui/color.dart';

class BiasTabView extends StatefulWidget {
  const BiasTabView({super.key, required this.leftContent,
    required this.centerContent, required this.rightContent,});
  final Widget leftContent;
  final Widget centerContent;
  final Widget rightContent;

  @override
  State<BiasTabView> createState() => _BiasTabViewState();
}

class _BiasTabViewState extends State<BiasTabView> with TickerProviderStateMixin{

  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    _linkController.dispose();
    _emailController.dispose();
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            splashBorderRadius: BorderRadius.circular(15),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft:Radius.circular(15),  ),
              color: _tabController.index == 0? AppColors.left :
              _tabController.index == 1?  AppColors.center : AppColors.right,),
            // indicatorColor: _tabController.index == 0? AppColors.left :
            // _tabController.index == 1?  AppColors.center : AppColors.right,
            tabs: [
              Tab(text: '진보적 관점'),
              Tab(text: '중도적 관점'),
              Tab(text: '보수적 관점'),
            ],
          ),
          Container(
          height: 400,
          padding: EdgeInsets.all(20),
          child: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                  child: widget.leftContent
              ),
              SingleChildScrollView(
                child: widget.centerContent,
              ),
              SingleChildScrollView(
                  child: widget.rightContent
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}

class BiasTabView5 extends StatefulWidget {
  const BiasTabView5({super.key, required this.biasContents, required this.tabTitles});
  final List<Widget> biasContents;
  final List<String> tabTitles;

  @override
  State<BiasTabView5> createState() => _BiasTabView5State();
}

class _BiasTabView5State extends State<BiasTabView5> with TickerProviderStateMixin{

  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late TabController _tabController;
  late final List<Color> biasColors;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.biasContents.length == 5){
      biasColors = [
        AppColors.left,
        AppColors.leftCenter,
        AppColors.center,
        AppColors.rightCenter,
        AppColors.right,
      ];
    }else{
      biasColors = [
        AppColors.left,
        AppColors.center,
        AppColors.right,
      ];
    }
    _tabController = TabController(length: widget.biasContents.length, vsync: this, initialIndex: widget.biasContents.length == 5 ? 2 : 1);
    _tabController.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    _linkController.dispose();
    _emailController.dispose();
    _tabController.dispose();
    super.dispose();
  }
  AutoSizeGroup group = AutoSizeGroup();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: biasColors[_tabController.index],
          labelPadding: EdgeInsets.symmetric(horizontal: 5),
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          // splashBorderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft:Radius.circular(15),  ),
          indicator: BoxDecoration(
            // borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft:Radius.circular(15),  ),
            // color: biasColors[_tabController.index],
          ),
          tabs: [
            for(int i = 0; i < widget.tabTitles.length; i++)
              Tab(child: autoSizeText(widget.tabTitles[i], group: group) ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              for(int index = 0; index < widget.biasContents.length; index++)
              widget.biasContents[index],
            ],
          ),
        ),
      ],
    );
  }
}