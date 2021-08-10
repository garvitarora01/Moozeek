import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/iconic_icons.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer? SongPlayer;
  final String audioPath;
  const AudioFile({Key? key, this.SongPlayer, required this.audioPath})
      : super(key: key);
  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool play = false;
  bool pause = false;
  bool repeat = false;
  Color _color = Colors.black;

  List<IconData> _icons = [
    Icons.play_circle_outline,
    Icons.pause_circle_outline,
  ];
  @override
  void initState() {
    super.initState();
    this.widget.SongPlayer!.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    this.widget.SongPlayer!.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    this.widget.SongPlayer!.setUrl(this.widget.audioPath);
    this.widget.SongPlayer!.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        if (repeat == true) {
          play = true;
        } else {
          play = false;
          repeat = false;
        }
      });
    });
  }

  Widget btnStart() {
    return new IconButton(
        icon: play == false ? Icon(_icons[0]) : Icon(_icons[1]),
        padding: EdgeInsets.only(top: 7),
        iconSize: 55,
        color: Colors.black,
        onPressed: () {
          if (play == false) {
            this.widget.SongPlayer!.setPlaybackRate(playbackRate: 1);
            this.widget.SongPlayer!.play(this.widget.audioPath);
            setState(() {
              play = true;
            });
          } else {
            this.widget.SongPlayer!.setPlaybackRate(playbackRate: 1);
            this.widget.SongPlayer!.pause();
            setState(() {
              play = false;
            });
          }
        });
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Color(0xFFF7F9F9),
      inactiveColor: Color(0xFF808782),
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
        });
      },
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.widget.SongPlayer!.seek(newDuration);
  }

  Widget btnFast() {
    return IconButton(
      padding: EdgeInsets.all(2),
      onPressed: () {
        this.widget.SongPlayer!.setPlaybackRate(playbackRate: 1.5);
      },
      icon: Icon(
        Icons.skip_next,
        size: 50,
        color: _color,
      ),
    );
  }

  Widget btnSlow() {
    return IconButton(
      padding: EdgeInsets.all(2),
      onPressed: () {
        this.widget.SongPlayer!.setPlaybackRate(playbackRate: 0.5);
      },
      icon: Icon(
        Icons.skip_previous,
        size: 50,
        color: _color,
      ),
    );
  }

  Widget btnRepeat() {
    return IconButton(
      padding: EdgeInsets.all(2),
      icon: repeat == false
          ? Icon(
              Entypo.cw,
              size: 35,
              color: Colors.black,
            )
          : Icon(
              Entypo.cw,
              size: 35,
              color: Color(0xFF00FFFF),
            ),
      onPressed: () {
        if (repeat == false) {
          this.widget.SongPlayer!.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            repeat = true;
          });
        } else if (repeat == true) {
          this.widget.SongPlayer!.setReleaseMode(ReleaseMode.RELEASE);
          setState(() {
            repeat = false;
          });
        }
      },
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon: Icon(
        Icons.loop,
        size: 40,
        color: _color,
      ),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().substring(2, 7),
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  _duration.toString().substring(2, 7),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          slider(),
          loadAsset(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
          ),
        ],
      ),
    );
  }
}
