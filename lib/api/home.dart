// 封装一个api，目的是返回业务侧要的数据结构
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/dioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

// 获取Banner列表
Future<List<BannerItem>> getBannerListAPI() async {
  // 返回请求
  return ((await diorequest.get(HttpConstants.BANNER_LIST)) as List)
      .map((item) {
    return BannerItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

// 获取分类列表
Future<List<CategoryItem>> getCategoryListAPI() async {
  // 返回请求
  return ((await diorequest.get(HttpConstants.CATEGORY_LIST)) as List)
      .map((item) {
    return CategoryItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}
