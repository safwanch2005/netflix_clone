import 'package:flutter/material.dart';
import 'package:netflix_clone/movies/movie_card.dart';
import 'package:netflix_clone/movies/movie_details.dart';
import 'api/api_service.dart';
import 'api/constants.dart';
import 'api/model_json.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final MovieService _movieService = MovieService();
  List<ApiDataModel> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search Movies',
            border: InputBorder.none,
          ),
          onChanged: (query) => _searchMovies(query),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              setState(() {
                searchResults.clear();
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return MovieCard(
            image: NetworkImage(
                '${ApiConfig.imagePath}${searchResults[index].poster}'),
            onTap: () {
              _navigateToMovieDetails(searchResults[index]);
            },
          );
        },
      ),
    );
  }

  Future<void> _searchMovies(String query) async {
    if (query.isNotEmpty) {
      try {
        final movies = await _movieService.getMovies(ApiConfig.searchMovies);
        setState(() {
          searchResults = movies;
        });
      } catch (e) {
        // Handle errors
        // ignore: avoid_print
        print('Error searching movies: $e');
      }
    } else {
      setState(() {
        searchResults.clear();
      });
    }
  }

  void _navigateToMovieDetails(ApiDataModel movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(movie: movie),
      ),
    );
  }
}
