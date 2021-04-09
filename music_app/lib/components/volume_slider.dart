import 'package:flutter/material.dart';

class VolumeSlider extends StatelessWidget {
  final double volume;
  final void Function(double) onVolumeChanged;

  VolumeSlider({
    @required this.volume, 
    @required this.onVolumeChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Slider.adaptive(
        activeColor: Colors.blue[800],
        inactiveColor: Colors.grey[350],
        min: 0.0,
        value: volume,
        max: 2.0,
        onChanged: onVolumeChanged,
      ),
    );
  }
}
