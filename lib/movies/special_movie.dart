import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SpecialMovie extends StatelessWidget {
  final List<String> carouselImages;
  const SpecialMovie({
    super.key,
    required this.carouselImages,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .70,
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: carouselImages.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                constraints: const BoxConstraints.expand(),
                child: Image(
                  image: AssetImage(carouselImages[index]),
                  fit: BoxFit.fill,
                  alignment: Alignment.bottomCenter,
                ),
              );
            },
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * .75,
              viewportFraction: 1.0,
              aspectRatio: 16 / 9,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              pauseAutoPlayOnTouch: true,
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      width: 6,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[400],
      ),
    );
  }
}
