import 'package:flutter/material.dart';

class MusicCover extends StatelessWidget {
  final String cover;
  final String singer;

  MusicCover({
    @required this.cover,
    @required this.singer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(image: AssetImage(cover))),
          ),
        ),
        SizedBox(
          height: 18.0,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              singer,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }
}
