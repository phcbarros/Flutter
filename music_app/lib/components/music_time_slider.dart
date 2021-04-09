import 'package:flutter/material.dart';

class MusicTimeSlider extends StatelessWidget {
  final Duration position;
  final Duration musicLength;
  final void Function(double) onChanged;

  MusicTimeSlider({
    @required this.position, 
    @required this.musicLength, 
    @required this.onChanged
  });

  // We will create a custom slider
  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
        activeColor: Colors.blue[800],
        inactiveColor: Colors.grey[350],
        value: position.inSeconds.toDouble(),
        max: musicLength.inSeconds.toDouble(),
        onChanged: onChanged),
    );
  }

  _twoDigits(int n) => n.toString().padLeft(2, "0");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${position.inMinutes.remainder(60)}:${_twoDigits(position.inSeconds.remainder(60))}",
            style: TextStyle(fontSize: 18.0),
          ),
          slider(),
          Text(
            "${musicLength.inMinutes}:${_twoDigits(musicLength.inSeconds.remainder(60))}",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
