import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../api/api_service.dart';
import '../api/constants.dart';
import '../api/model_json.dart';
import '../movies/movie_card.dart';
import '../movies/movie_details.dart';
import '../movies/special_movie.dart';
import 'top_bar/top_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ignore: prefer_final_fields
  MovieService _movieService = MovieService();
  late ScrollController controller;
  bool _showTopBar = true, _flag = true;
  late List<ApiDataModel> popularMovies = [];
  late List<ApiDataModel> trendingMovies = [];
  late List<ApiDataModel> newReleases = [];
  late List<ApiDataModel> topRated = [];

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
    loadPopularMovies();
    loadTrendingMovies();
    loadNewReleases();
    loadTopRatedTv();
  }

  Future<void> loadPopularMovies() async {
    try {
      final movies = await _movieService.getMovies(ApiConfig.popularMovies);
      setState(() {
        popularMovies = movies;
      });
    } catch (e) {
      // Handle errors
      // ignore: avoid_print
      print('Error loading popular movies: $e');
    }
  }

  Future<void> loadTrendingMovies() async {
    try {
      final movies = await _movieService.getMovies(ApiConfig.trendingMovies);
      setState(() {
        trendingMovies = movies;
      });
    } catch (e) {
      // Handle errors
      // ignore: avoid_print
      print('Error loading trending movies: $e');
    }
  }

  Future<void> loadNewReleases() async {
    try {
      final movies = await _movieService.getMovies(ApiConfig.topratedMovies);
      setState(() {
        newReleases = movies;
      });
    } catch (e) {
      // Handle errors
      // ignore: avoid_print
      print('Error loading new releases: $e');
    }
  }

  Future<void> loadTopRatedTv() async {
    try {
      final movies = await _movieService.getMovies(ApiConfig.topRatedTv);
      setState(() {
        topRated = movies;
      });
    } catch (e) {
      // Handle errors
      // ignore: avoid_print
      print('Error loading new releases: $e');
    }
  }

  Widget loadPopularOnNetflix() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Popular on Netflix",
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
            children: popularMovies.map((movie) {
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

  Widget loadTrendingNow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Trending Now",
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
            children: trendingMovies.map((movie) {
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

  Widget loadNewRelease() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "New Releases",
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
            children: newReleases.map((movie) {
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

  Widget loadRated() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Top Rated",
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
            children: topRated.map((movie) {
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
                const SpecialMovie(
                  carouselImages: [
                    "images/theplatform.jpg",
                    "images/it.jpg",
                    "images/lotr.jpg",
                    "images/number.jpg"
                  ],
                ),
                const SizedBox(height: .1),
                loadPopularOnNetflix(),
                const SizedBox(height: .1),
                loadTrendingNow(),
                const SizedBox(height: .1),
                loadNewRelease(),
                const SizedBox(height: .1),
                loadRated()
              ],
            ),
          ),
          AnimatedPositioned(
            top: _showTopBar ? 0 : -80,
            duration: const Duration(milliseconds: 300),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showTopBar ? 1 : 0,
              child: IgnorePointer(
                ignoring: !_showTopBar,
                child: const TopBar(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
