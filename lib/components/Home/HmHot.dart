import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmHot extends StatefulWidget {
  final SpecialRecommendResult result;
  final String type;
  const HmHot({super.key, required this.result, required this.type});

  @override
  State<HmHot> createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  // 获取前两条数据
  // 计算属性 .xxx就可以调用
  // 方法() 调用
  List<GoodsItem> get _items {
    if (widget.result.subTypes.isEmpty) {
      return [];
    }
    return widget.result.subTypes.first.goodsItems.items.take(2).toList();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == "step" ? "一站买全" : "爆款推荐",
          style: TextStyle(
              color: Color.fromARGB(255, 86, 24, 20),
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          widget.type == "step" ? "精心优选" : "最受欢迎",
          style:
              TextStyle(color: Color.fromARGB(255, 124, 63, 58), fontSize: 12),
        ),
      ],
    );
  }

  List<Widget> _getChildrenList() {
    return _items.map((item) {
      return Expanded(
          child: Container(
        // width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.picture,
                // width: 80,
                height: 100,
                fit: BoxFit.cover,
                // 当图片构建失败，返回一个新的组件替换原有图片
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "lib/assets/home_cmd_inner.png",
                    // width: 80,
                    height: 100,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "¥${item.price}",
              style: TextStyle(
                  color: Color.fromARGB(255, 86, 24, 20), fontSize: 12),
            ),
          ],
        ),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        decoration: BoxDecoration(
          color: widget.type == "step"
              ? Color.fromARGB(255, 249, 247, 219)
              : Color.fromARGB(255, 211, 228, 240),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getChildrenList(),
            ),
          ],
        ),
      ),
    );
  }
}
