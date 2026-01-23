import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCAtegory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem> _bannerList = [
    // BannerItem(
    //     id: "1",
    //     imgUrl:
    //         "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg"),
    // BannerItem(
    //     id: "2",
    //     imgUrl:
    //         "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png"),
    // BannerItem(
    //     id: "3",
    //     imgUrl:
    //         "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg"),
  ];

  // 获取滚动容器的内容
  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(
        child: Hmslider(
          bannerList: _bannerList,
        ),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerList();
  }

  void _getBannerList() async {
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getScrollChildren(),
    ); // sliver家族的内容
  }
}
