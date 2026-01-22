import 'package:flutter/material.dart';

class Hmmorelist extends StatefulWidget {
  const Hmmorelist({super.key});

  @override
  State<Hmmorelist> createState() => _HmmorelistState();
}

class _HmmorelistState extends State<Hmmorelist> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              "商品",
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }
}
