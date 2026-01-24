import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  final List<CategoryItem> categoryList;
  const HmCategory({super.key, required this.categoryList});

  @override
  State<HmCategory> createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        // ListView外层要包SizeBox或者Container确定高度
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categoryList.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 232, 234),
                  borderRadius: BorderRadius.circular(40),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      widget.categoryList[index].picture ?? "",
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      widget.categoryList[index].name ?? "",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }));
  }
}
