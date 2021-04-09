import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/music.dart';

import 'music_time_slider.dart';
import 'volume_slider.dart';

class MusicPlayer extends StatefulWidget {
  final int currentMusic;
  final List<Music> listOfMusic;
  final void Function(int) goToNextMusic;
  final void Function(int) goTopPreviousMusic;
  final void Function() resetListOfMusic;

  MusicPlayer({
    @required this.currentMusic,
    @required this.listOfMusic,
    @required this.goToNextMusic,
    @required this.goTopPreviousMusic,
    @required this.resetListOfMusic,
  });

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool playing = false; // at the begining wer are not playing any song
  IconData playBtn = Icons.play_arrow; // the main state of the play button icon
  double volume = 1.0;

  // Now let's start by creating our music player
  // firts let's declare some object
  AudioPlayer _player;
  AudioCache cache;

  Duration position = Duration(seconds: 0);
  Duration musicLength = Duration(seconds: 1); // fix bug slider

  // let's create the seek function that will allow us to go to a certain position of the music
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  // Now let's initialize our player
  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    // Now let's handle the audio player time

    // this function will allow you to get the music duration
    _player.onDurationChanged.listen((Duration duration) {
      setState(() {
        musicLength = duration;
      });
    });

    // this function will allow us to move the cursor of the slider while we are playing the song
    _player.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    }, onError: (e) {
      print('Erro ao obter posição');
    });

    _player.onPlayerCompletion.listen((_) {
      if (_canGoToNextMusic(widget.currentMusic, widget.listOfMusic)) {
        _onPressNextButton();
      } else {
        setState(() {
          widget.resetListOfMusic();
          position = Duration(seconds: 0);
          playing = false;
          playBtn = Icons.play_arrow;
        });
      }
    });
  }

  void _onPressPlayButton() {
    if (!playing) {
      cache.play("${widget.listOfMusic[widget.currentMusic].song}.mp3");
      setState(() {
        playBtn = Icons.pause;
        playing = true;
      });
    } else {
      _player.pause();
      setState(() {
        playBtn = Icons.play_arrow;
        playing = false;
      });
    }
  }

  bool _canGoToNextMusic(int currentMusic, List<Music> musics) {
    return currentMusic < musics.length - 1 ? true : false;
  }

  void _onPressNextButton() {
    setState(() {
      widget.goToNextMusic(widget.currentMusic);
      cache.play("${widget.listOfMusic[widget.currentMusic].song}.mp3");
    });
  }

  bool _canGoToPreviousMusic(int currentMusic) {
    return currentMusic == 0 ? false : true;
  }

  void _onPressPreviousButton() {
    setState(() {
      widget.goTopPreviousMusic(widget.currentMusic);
      cache.play("${widget.listOfMusic[widget.currentMusic].song}.mp3");
    });
  }

  void onChangeVolume(value) {
    _player.setVolume(value);
    setState(() {
      volume = value;
    });
  }

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
                  color: _canGoToPreviousMusic(widget.currentMusic)
                      ? Colors.blue
                      : Colors.grey,
                  onPressed: _onPressPreviousButton,
                  icon: Icon(
                    Icons.skip_previous,
                  ),
                ),
                IconButton(
                  iconSize: 45,
                  color: Colors.blue,
                  onPressed: _onPressPlayButton,
                  icon: Icon(
                    playBtn,
                  ),
                ),
                IconButton(
                  iconSize: 45,
                  color:
                      _canGoToNextMusic(widget.currentMusic, widget.listOfMusic)
                          ? Colors.blue
                          : Colors.grey,
                  onPressed: _onPressNextButton,
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
