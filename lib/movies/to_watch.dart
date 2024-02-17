import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../api/api_service.dart';
import '../api/constants.dart';
import '../api/model_json.dart';
import 'movie_card.dart';
import 'movie_details.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  // ignore: prefer_final_fields
  MovieService _movieService = MovieService();
  late ScrollController controller;
  bool _showTopBar = true, _flag = true;
  late List<ApiDataModel> discoverTv = [];
  late List<ApiDataModel> allTimeFavMovie = [];
  late List<ApiDataModel> watchlist = [];

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(() {
      _flag =
          controller.position.userScrollDirection == ScrollDirection.forward;

      if (_showTopBar != _flag) setState(() {});
      _showTopBar = _flag;
    });

    // Call the methods to load data when the widget is initialized
    loadDiscoverTv();
    loadAllTimeFav();
    loadWatchList();
  }

  Future<void> loadDiscoverTv() async {
    try {
      final movies = await _movieService.getMovies(ApiConfig.discoverTv);
      setState(() {
        discoverTv = movies;
      });
    } catch (e) {
      // Handle errors
      // ignore: avoid_print
      print('Error loading popular movies: $e');
    }
  }

  Future<void> loadAllTimeFav() async {
    try {
      final movies = await _movieService.getMovies(ApiConfig.allTimeFavMovie);
      setState(() {
        allTimeFavMovie = movies;
      });
    } catch (e) {
      // Handle errors
      // ignore: avoid_print
      print('Error loading trending movies: $e');
    }
  }

  Future<void> loadWatchList() async {
    try {
      final movies = await _movieService.getMovies(ApiConfig.watchlist);
      setState(() {
        watchlist = movies;
      });
    } catch (e) {
      // Handle errors
      // ignore: avoid_print
      print('Error loading popular movies: $e');
    }
  }

  Widget loadDiscoverOnNetflix() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Discover TV",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: discoverTv.map((movie) {
              return Padding(
                padding: const EdgeInsets.only(right: 11.0),
                child: MovieCard(
                  image: NetworkImage('${ApiConfig.imagePath}${movie.poster}'),
                  onTap: () {
                    _navigateToMovieDetails(movie);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget loadFav() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "All Time Favorites",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: allTimeFavMovie.map((movie) {
              return Padding(
                padding: const EdgeInsets.only(right: 11.0),
                child: MovieCard(
                  image: NetworkImage('${ApiConfig.imagePath}${movie.poster}'),
                  onTap: () {
                    _navigateToMovieDetails(movie);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget loadToWatch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "WatchList",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: watchlist.map((movie) {
              return Padding(
                padding: const EdgeInsets.only(right: 11.0),
                child: MovieCard(
                  image: NetworkImage('${ApiConfig.imagePath}${movie.poster}'),
                  onTap: () {
                    _navigateToMovieDetails(movie);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _navigateToMovieDetails(ApiDataModel movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: .1),
                loadDiscoverOnNetflix(),
                const SizedBox(height: .1),
                loadFav(),
                const SizedBox(height: .1),
                loadToWatch()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
