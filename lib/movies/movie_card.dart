import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
