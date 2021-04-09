import 'package:flutter/material.dart';

import 'music_time_slider.dart';
import 'volume_slider.dart';

class MusicPlayer extends StatelessWidget {
  final int currentMusic;
  final Duration position;
  final Duration musicLength;
  final bool isEnabledPreviousButton;
  final bool isEnabledNextButton;
  final double volume;
  final IconData playBtn;
  final void Function(double) onChangeVolume;
  final void Function(int) seekToSec;
  //final bool Function(int) canGoToPreviousMusic;
  final void Function() onPressPreviousButton;
  final void Function() onPressNextButton;
  final void Function() onPlayMusic;

  MusicPlayer({
    @required this.currentMusic,
    @required this.position,
    @required this.musicLength,
    @required this.playBtn,
    @required this.seekToSec,
    @required this.volume,
    @required this.onChangeVolume,
    //@required this.canGoToPreviousMusic,
    @required this.isEnabledPreviousButton,
    @required this.onPressPreviousButton,
    @required this.isEnabledNextButton,
    @required this.onPressNextButton,
    @required this.onPlayMusic,
  });

  // bool _canGoToPreviousMusic(int currentMusic) {
  //   return currentMusic == 0 ? false : true;
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // let's start by adding the controller
            MusicTimeSlider(
              position: position,
              musicLength: musicLength,
              onChanged: (value) => seekToSec(value.toInt()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 45,
                  color: isEnabledPreviousButton ? Colors.blue : Colors.grey,
                  onPressed: onPressPreviousButton,
                  icon: Icon(
                    Icons.skip_previous,
                  ),
                ),
                IconButton(
                  iconSize: 45,
                  color: Colors.blue,
                  onPressed: onPlayMusic,
                  icon: Icon(
                    playBtn,
                  ),
                ),
                IconButton(
                  iconSize: 45,
                  color: isEnabledNextButton ? Colors.blue : Colors.grey,
                  onPressed: onPressNextButton,
                  icon: Icon(
                    Icons.skip_next,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Text(
                  "Volume",
                  style: TextStyle(fontSize: 18.0),
                ),
                VolumeSlider(volume: volume, onVolumeChanged: onChangeVolume),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
