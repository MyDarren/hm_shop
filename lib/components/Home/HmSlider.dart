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
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  Widget _getSlider() {
    // 在Flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: screenWidth,
        );
      }),
      options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          viewportFraction: 1,
          autoPlay: true,
          height: 300, // 设置轮播图高度
          autoPlayInterval: Duration(seconds: 3),
          onPageChanged: (index, reason) {
            _currentIndex = index;
            setState(() {});
          }),
      carouselController: _controller,
    );
  }

  Widget _getSearch() {
    return Positioned(
        top: 10,
        left: 0,
        right: 0,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: 50,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  borderRadius: BorderRadius.circular(25)),
              child: Text(
                "搜索...",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )));
  }

  // 返回指示灯导航
  Widget _getDots() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 10,
        child: SizedBox(
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.bannerList.length, (index) {
              return GestureDetector(
                onTap: () {
                  _controller.animateToPage(index,
                      duration: Duration(milliseconds: 200));
                  _currentIndex = index;
                  setState(() {});
                },
                // AnimatedContainer有动画效果
                child: AnimatedContainer(
                  height: 6,
                  duration: Duration(milliseconds: 200), // 动画时长
                  width: index == _currentIndex ? 40 : 20,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      color: index == _currentIndex
                          ? Colors.white
                          : Color.fromRGBO(0, 0, 0, 0.3),
                      borderRadius: BorderRadius.circular(3)),
                ),
              );
            }),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_getSlider(), _getSearch(), _getDots()],
    );
  }
}
