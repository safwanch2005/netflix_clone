import 'package:flutter/material.dart';
import '../api/constants.dart';
import '../api/model_json.dart';

class MovieDetailsScreen extends StatelessWidget {
  final ApiDataModel movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.movieName ?? ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie.poster == null
                ? Container()
                : Image.network(
                    '${ApiConfig.imagePath}${movie.poster ?? ''}',
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Description:  ${movie.overview ?? ''}',
                    style: const TextStyle(fontSize: 16, fontFamily: "Sans"),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Rating:  ${movie.averageRating ?? 0.0}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
