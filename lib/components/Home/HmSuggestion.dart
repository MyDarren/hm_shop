import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  final SpecialRecommendResult specialRecommendResult;
  const HmSuggestion({super.key, required this.specialRecommendResult});

  @override
  State<HmSuggestion> createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  List<GoodsItem> _getDisplayItems() {
    if (widget.specialRecommendResult.subTypes.isEmpty) return [];
    return widget.specialRecommendResult.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  Widget _buildHeader() {
    return Row(children: [
      Text(
        "特惠推荐",
        style: TextStyle(
            color: Color.fromARGB(255, 86, 24, 20),
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        "精选省攻略",
        style: TextStyle(color: Color.fromARGB(255, 124, 63, 58), fontSize: 12),
      )
    ]);
  }

  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/home_cmd_inner.png"))),
    );
  }

  List<Widget> _getChildrenList() {
    List<GoodsItem> list = _getDisplayItems();
    return List.generate(list.length, (index) {
      return Expanded(
          child: Column(
        children: [
          // ClipRRect可以包裹子元素，裁剪图片设置圆角
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              list[index].picture,
              // width: 100,
              height: 140,
              fit: BoxFit.cover,
              // 当图片构建失败，返回一个新的组件替换原有图片
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "lib/assets/home_cmd_inner.png",
                  // width: 100,
                  height: 140,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 96, 12),
                borderRadius: BorderRadius.circular(12)),
            child: Text("¥${list[index].price}",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("lib/assets/home_cmd_sm.png"))),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _buildLeft(),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Row(
                  // spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _getChildrenList(),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
