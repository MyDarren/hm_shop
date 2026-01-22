import 'package:flutter/material.dart';
import 'package:hm_shop/components/Home/HmCAtegory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 获取滚动容器的内容
  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(
        child: Hmslider(),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 10,
        ),
      ),
      // SliverGrid、SliverList只能纵向排列
      SliverToBoxAdapter(
        child: Hmcategory(),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 10,
        ),
      ),
      SliverToBoxAdapter(
        child: Hmsuggestion(),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 10,
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Hmhot(),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Hmhot(),
                ),
              ],
            )),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 10,
        ),
      ),
      Hmmorelist(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getScrollChildren(),
    ); // sliver家族的内容
  }
}
