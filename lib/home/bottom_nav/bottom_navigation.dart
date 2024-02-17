import 'package:flutter/material.dart';
import 'package:netflix_clone/search_screeen.dart';
import 'home/home.dart';
import 'movies/to_watch.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedBottom = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: (int index) {
          if (index == 4) {
            //  Navigate to SearchPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          } else {
            setState(() {
              _selectedBottom = index;
            });
          }
        },
        currentIndex: _selectedBottom,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset_rounded),
            label: "Games",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ondemand_video_sharp),
            label: "To Watch",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download_outlined),
            label: "Downloads",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "More",
          ),
        ],
      ),
      body: Stack(
        children: [
          Visibility(
            visible: _selectedBottom == 0,
            child: const HomeView(),
          ),
          Visibility(
            visible: _selectedBottom == 1,
            child: const Center(
              child: Text("Games View"),
            ),
          ),
          Visibility(
            visible: _selectedBottom == 2,
            child: const FavoriteView(),
          ),
          Visibility(
            visible: _selectedBottom == 3,
            child: const Center(
              child: Text("Download View"),
            ),
          ),
          Visibility(
            visible: _selectedBottom == 4,
            child: const Center(
              child: Text("More"),
            ),
          ),
        ],
      ),
    );
  }
}
