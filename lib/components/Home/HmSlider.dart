import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmslider extends StatefulWidget {
  final List<BannerItem> bannerList;
  const Hmslider({super.key, required this.bannerList});

  @override
  State<Hmslider> createState() => _HmsliderState();
}

class _HmsliderState extends State<Hmslider> {
  Widget _getSlider() {
    // 在Flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
        items: List.generate(widget.bannerList.length, (index) {
          return Image.network(
            widget.bannerList[index].imgUrl!,
            fit: BoxFit.cover,
            width: screenWidth,
          );
        }),
        options: CarouselOptions(
            scrollDirection: Axis.horizontal,
            viewportFraction: 1,
            autoPlay: true,
            height: 300, // 设置轮播图高度
            autoPlayInterval: Duration(seconds: 5)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_getSlider()],
    );
  }
}
