// 封装一个api，目的是返回业务侧要的数据结构
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

// 获取Banner列表
Future<List<BannerItem>> getBannerListAPI() async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List)
      .map((item) {
    return BannerItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

// 获取分类列表
Future<List<CategoryItem>> getCategoryListAPI() async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List)
      .map((item) {
    return CategoryItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

// 获取特惠推荐列表
Future<SpecialRecommendResult> getSpecialRecommendListAPI() async {
  // 返回请求
  return SpecialRecommendResult.fromJson(
      await dioRequest.get(HttpConstants.SPECIAL_RECOMMEND_LIST));
}

// 获取热榜推荐列表
Future<SpecialRecommendResult> getInVogueListAPI() async {
  // 返回请求
  return SpecialRecommendResult.fromJson(
      await dioRequest.get(HttpConstants.IN_VOGUE_LIST));
}

// 获取一站式推荐列表
Future<SpecialRecommendResult> getOneStopListAPI() async {
  // 返回请求
  return SpecialRecommendResult.fromJson(
      await dioRequest.get(HttpConstants.ONE_STOP_LIST));
}

// 获取推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
    Map<String, dynamic> params) async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
    return GoodDetailItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}
