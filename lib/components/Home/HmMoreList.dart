import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmMorelist extends StatefulWidget {
  final List<GoodDetailItem> recommendList;
  const HmMorelist({super.key, required this.recommendList});

  @override
  State<HmMorelist> createState() => _HmMorelistState();
}

class _HmMorelistState extends State<HmMorelist> {
  Widget _getChildren(index) {
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(8),
            // 宽高比组件
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                widget.recommendList[index].picture,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("lib/assets/home_cmd_inner.png");
                },
              ),
            )),
        SizedBox(
          height: 6,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.recommendList[index].name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(
                  text: "¥${widget.recommendList[index].price}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                  children: [
                    TextSpan(text: " "),
                    TextSpan(
                        text: widget.recommendList[index].price,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough))
                  ])),
              Text(
                "${widget.recommendList[index].orderNum}人付款",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: widget.recommendList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: _getChildren(index),
          );
        });
  }
}
