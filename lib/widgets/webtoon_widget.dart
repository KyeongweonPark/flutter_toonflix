import 'package:flutter/material.dart';
import 'package:flutter_toonflix/models/webtoon_model.dart';
import 'package:flutter_toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  const Webtoon(
    this.webtoon, {
    Key? key,
  }) : super(key: key);

  final WebtoonModel webtoon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(webtoon),
              fullscreenDialog: true),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: webtoon,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        offset: const Offset(5, 5),
                        color: Colors.black.withOpacity(0.5))
                  ]),
              child: Image.network(webtoon.thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            webtoon.title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
