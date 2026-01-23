import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
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

  List<CategoryItem> _categoryList = [];
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 获取热榜推荐列表
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 获取一站式推荐列表
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

  List<GoodDetailItem> _recommandList = [];
  final ScrollController _controller = ScrollController();
  // 页码
  int _page = 1;
  // 当前正在加载状态
  bool _isLoading = false;
  // 是否还有下一页
  bool _hasMore = true;

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
        child: Hmcategory(
          categoryList: _categoryList,
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 10,
        ),
      ),
      SliverToBoxAdapter(
        child: Hmsuggestion(
          specialRecommendResult: _specialRecommendResult,
        ),
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
                  child: Hmhot(
                    result: _inVogueResult,
                    type: "hot",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Hmhot(
                    result: _oneStopResult,
                    type: "step",
                  ),
                ),
              ],
            )),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 10,
        ),
      ),
      Hmmorelist(
        recommandList: _recommandList,
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getSpecialRecommendList();
    _getInVogueList();
    _getOneStopList();
    _getRecommandList();
    _registerEvent();
  }

  // 获取Banner列表
  void _getBannerList() async {
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  // 获取分类列表
  void _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  // 获取特惠推荐列表
  void _getSpecialRecommendList() async {
    _specialRecommendResult = await getSpecialRecommendListAPI();
    setState(() {});
  }

  // 获取热榜推荐列表
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  void _getRecommandList() async {
    // 当已经有请求正在加载或者已经没有下一页了，就放弃请求
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    int requestLimit = _page * 10;
    _recommandList = await getRecommandListAPI({"limit": requestLimit});
    _isLoading = false;
    setState(() {});
    if (_recommandList.length < requestLimit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  // 监听滚动到底部的事件
  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        _getRecommandList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getScrollChildren(),
      controller: _controller, // 绑定控制器
    ); // sliver家族的内容
  }
}
