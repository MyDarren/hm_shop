class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  // flutter必须强制转化，没有隐式转化
  // 扩展一个工厂函数，一般用factory来声明，一般用来创建实例对象
  // factory可以用来创建构造函数，它能控制对象的创建方式
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    // 必须返回一个BannerItem对象
    return BannerItem(
        id: json["id"]?.toString() ?? "",
        imgUrl: json["imgUrl"]?.toString() ?? "");
  }
}

// {
//     "id": "1181622001",
//     "name": "气质女装",
//     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/qznz.png",
//     "children": [
//         {
//             "id": "1191110001",
//             "name": "半裙",
//             "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_bq.png?quality=95&imageView",
//             "children": null,
//             "goods": null
//         },
//         {
//             "id": "1191110002",
//             "name": "衬衫",
//             "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_cs.png?quality=95&imageView",
//             "children": null,
//             "goods": null
//         },
//         {
//             "id": "1191110022",
//             "name": "T恤",
//             "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_tx.png?quality=95&imageView",
//             "children": null,
//             "goods": null
//         },
//         {
//             "id": "1191110023",
//             "name": "针织衫",
//             "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_zzs.png?quality=95&imageView",
//             "children": null,
//             "goods": null
//         },
//         {
//             "id": "1191110024",
//             "name": "夹克",
//             "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_jk.png?quality=95&imageView",
//             "children": null,
//             "goods": null
//         },
//         {
//             "id": "1191110025",
//             "name": "卫衣",
//             "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_wy.png?quality=95&imageView",
//             "children": null,
//             "goods": null
//         },
//         {
//             "id": "1191110028",
//             "name": "背心",
//             "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_bx.png?quality=95&imageView",
//             "children": null,
//             "goods": null
//         }
//     ],
//     "goods": null
// }

// 根据json编写class对象和工厂转化函数
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      children: json["children"] == null
          ? null
          : (json["children"] as List?)
              ?.map(
                  (item) => CategoryItem.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }
}

class SpecialRecommendResult {
  String id;
  String title;
  List<SubType> subTypes;
  SpecialRecommendResult(
      {required this.id, required this.title, required this.subTypes});
  factory SpecialRecommendResult.fromJson(Map<String, dynamic> json) {
    return SpecialRecommendResult(
        id: json["id"]?.toString() ?? "",
        title: json["title"]?.toString() ?? "",
        subTypes: (json["subTypes"] as List? ?? [])
            .map((item) => SubType.fromJson(item as Map<String, dynamic>))
            .toList());
  }
}

class SubType {
  String id;
  String title;
  GoodsItems goodsItems;
  SubType({required this.id, required this.title, required this.goodsItems});
  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json["id"]?.toString() ?? "",
      title: json["title"]?.toString() ?? "",
      goodsItems: GoodsItems.fromJson(
        json["goodsItems"] as Map<String, dynamic>,
      ),
    );
  }
}

class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: int.tryParse(json["counts"]?.toString() ?? "0") ?? 0,
      pageSize: int.tryParse(json["pageSize"]?.toString() ?? "0") ?? 0,
      pages: int.tryParse(json["pages"]?.toString() ?? "0") ?? 0,
      page: int.tryParse(json["page"]?.toString() ?? "0") ?? 0,
      items: (json["items"] as List? ?? [])
          .map((item) => GoodsItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GoodsItem {
  String id;
  String name;
  String desc;
  String price;
  String picture;
  int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
        id: json["id"]?.toString() ?? "",
        name: json["name"]?.toString() ?? "",
        desc: json["desc"]?.toString() ?? "",
        price: json["price"]?.toString() ?? "",
        picture: json["picture"]?.toString() ?? "",
        orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0);
  }
}

class GoodDetailItem extends GoodsItem {
  int payCount = 0;
  GoodDetailItem(
      {required super.id,
      required super.name,
      required super.price,
      required super.picture,
      required super.orderNum,
      required this.payCount})
      : super(desc: "");
  factory GoodDetailItem.fromJson(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}
