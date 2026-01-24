import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/utils/toastUtils.dart';
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

  List<GoodDetailItem> _recommendList = [];
  final ScrollController _controller = ScrollController();
  // 页码
  int _page = 1;
  // 当前正在加载状态
  bool _isLoading = false;
  // 是否还有下一页
  bool _hasMore = true;
  // GlobalKey是一个方法，可以创建一个key绑定到Widget组件上，可以操作Widget组件
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  double _paddingTop = 0;

  // 获取滚动容器的内容
  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(
        child: HmSlider(
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
        child: HmCategory(
          categoryList: _categoryList,
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 10,
        ),
      ),
      SliverToBoxAdapter(
        child: HmSuggestion(
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
                  child: HmHot(
                    result: _inVogueResult,
                    type: "hot",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: HmHot(
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
      HmMorelist(
        recommendList: _recommendList,
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _registerEvent();
    // _getBannerList();
    // _getCategoryList();
    // _getSpecialRecommendList();
    // _getInVogueList();
    // _getOneStopList();
    // _getRecommandList();

    Future.microtask(() {
      _registerEvent();
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
  }

  // 获取Banner列表
  Future<void> _getBannerList() async {
    _bannerList = await getBannerListAPI();
  }

  // 获取分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
  }

  // 获取特惠推荐列表
  Future<void> _getSpecialRecommendList() async {
    _specialRecommendResult = await getSpecialRecommendListAPI();
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }

  Future<void> _getRecommandList() async {
    // 当已经有请求正在加载或者已经没有下一页了，就放弃请求
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    int requestLimit = _page * 10;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false;
    if (_recommendList.length < requestLimit) {
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
        setState(() {});
      }
    });
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await _getBannerList();
    await _getCategoryList();
    await _getSpecialRecommendList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommandList();
    _paddingTop = 0;
    setState(() {});
    if (!mounted) return;
    ToastUtils.showToast(context, "刷新成功");
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _key,
        onRefresh: _onRefresh,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.only(top: _paddingTop),
          child: CustomScrollView(
            slivers: _getScrollChildren(),
            controller: _controller, // 绑定控制器
          ),
        )); // sliver家族的内容
  }
}
