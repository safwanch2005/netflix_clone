import 'package:flutter/material.dart';
import 'package:netflix_clone/api/api_service.dart';
import 'package:netflix_clone/api/constants.dart';
import 'package:netflix_clone/api/model_json.dart';
import 'package:netflix_clone/movies/movie_details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ApiDataModel> _searchResults = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search Movies',
            border: InputBorder.none,
          ),
          onSubmitted: _performSearch,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _performSearch(_searchController.text);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildSearchResults(),
    );
  }

  void _navigateToMovieDetails(ApiDataModel movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(movie: movie),
      ),
    );
  }

  void _performSearch(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final movies = await MovieService().searchMovies(query);
      setState(() {
        _searchResults = movies;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
        _searchResults = [];
      });
    }
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(
        child: Text('No results found.'),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final movie = _searchResults[index];
        // try {
        return InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListTile(
              leading: movie.poster == null
                  ? const SizedBox(
                      height: 8,
                      width: 8,
                    )
                  : Image.network('${ApiConfig.imagePath}${movie.poster}'),
              title: Text(
                movie.movieName ?? '',
              ),
              trailing: const Icon(Icons.play_circle_outline_sharp),
            ),
          ),
          onTap: () {
            _navigateToMovieDetails(movie);
          },
        );
        // } catch (e) {
        //   print("image not found");
        //   return InkWell(
        //     child: Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //       child: ListTile(
        //         title: Text(
        //           movie.movieName ?? '',
        //         ),
        //         trailing: const Icon(Icons.play_circle_outline_sharp),
        //       ),
        //     ),
        //     onTap: () {
        //       _navigateToMovieDetails(movie);
        //     },
        //   );
        // }
      },
    );
  }
}
