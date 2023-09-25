import 'dart:async';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:siri_wave/siri_wave.dart';
import '../../../core/utils/app_colors.dart';

class AudioPlayer2 extends StatefulWidget {
  final String source;
  final VoidCallback onDelete;
  final void Function()? nextPressed;
  final void Function()? previousPressed;

  const AudioPlayer2(
      {Key? key,
      required this.source,
      required this.onDelete,
      required this.nextPressed,
      required this.previousPressed})
      : super(key: key);

  @override
  AudioPlayer2State createState() => AudioPlayer2State();
}

class AudioPlayer2State extends State<AudioPlayer2> {
  static const double _controlSize = 0.5;
  static const double _deleteBtnSize = 24;

  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<void> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  Duration? _position;
  Duration? _duration;

  @override
  void initState() {
    print('AudioPlayer2State');
    _playerStateChangedSubscription =
        _audioPlayer.onPlayerComplete.listen((state) async {
      await stop();
      setState(() {});
    });
    _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
      (position) => setState(() {
        _position = position;
      }),
    );
    _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
      (duration) => setState(() {
        _duration = duration;
      }),
    );

    super.initState();
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(child: _buildSlider(MediaQuery.of(context).size.width)),
        _buildControl(),
      ],
    );
  }

  Widget _buildControl() {
    Icon icon;
    if (_audioPlayer.state == ap.PlayerState.playing) {
      icon =
          Icon(Icons.pause, color: AppColors.white, size: getSize(context) / 8);
      setState(() {});
    } else {
      icon = Icon(Icons.play_arrow,
          color: AppColors.white, size: getSize(context) / 8);
      setState(() {});
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: widget.nextPressed,
            icon: InkWell(
              onTap: () {
                setState(() {
                  _position = null;
                  _duration = null;
                  pause();
                });
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
                size: getSize(context) / 8,
              ),
            )),
        IconButton(
          onPressed: () {
            if (_audioPlayer.state == ap.PlayerState.playing) {
              pause();
            } else {
              play();
            }
          },
          icon: icon,
        ),
        InkWell(
          onTap: () {
            setState(() {
              _position = null;
              _duration = null;
              pause();
            });
          },
          child: IconButton(
              onPressed: widget.previousPressed,
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
                size: getSize(context) / 8,
              )),
        ),
      ],
    );
  }

  Widget _buildSlider(double widgetWidth) {
    bool canSetValue = false;
    final duration = _duration;
    final position = _position;
    if (duration != null && position != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    double width = widgetWidth - _controlSize - _deleteBtnSize;
    width -= _deleteBtnSize;

    return Container(
        height: getSize(context) / 4,
        width: width,
        child: Column(
          children: [
            // Flexible(
            //   fit: FlexFit.tight,
            //   child: SiriWaveform.ios9(
            //     controller: IOS9SiriWaveformController(
            //       amplitude:
            //           (_audioPlayer.state == ap.PlayerState.playing) ? 0.8 : 0,
            //       speed: 0.15,
            //     ),
            //     options: IOS9SiriWaveformOptions(
            //       height: 180,
            //       width: double.infinity,
            //     ),
            //   ),
            // ),
            Slider(
              activeColor: AppColors.white,
              inactiveColor: AppColors.hint,
              onChanged: (v) {
                if (duration != null) {
                  final position = v * duration.inMilliseconds;
                  _audioPlayer.seek(Duration(milliseconds: position.round()));
                }
              },
              value: canSetValue && duration != null && position != null
                  ? position.inMilliseconds / duration.inMilliseconds
                  : 0.0,
            ),
          ],
        ));
  }

  Future<void> play() {
    return _audioPlayer.play(
      kIsWeb ? ap.UrlSource(widget.source) : ap.DeviceFileSource(widget.source),
    );
  }

  Future pause() {
    return _audioPlayer.pause();
  }

  Future<void> stop() => _audioPlayer.stop();
}
