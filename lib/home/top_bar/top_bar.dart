import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.green,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(.8),
            Colors.black.withOpacity(.7),
            Colors.black.withOpacity(0),
          ],
        ),
      ),
      child: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                    height: 33,
                    child: Image(
                      image: AssetImage("images/netfologo.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 11,
                        ),
                        Text("TV Shows"),
                        SizedBox(
                          width: 38,
                        ),
                        Text("Movies"),
                        SizedBox(
                          width: 38,
                        ),
                        Text("My List"),
                        SizedBox(
                          width: 38,
                        ),
                      ],
                    ),
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
