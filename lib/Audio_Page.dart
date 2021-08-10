import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/Audio_file.dart';
import 'app_colors.dart' as AppColors;

class AudioPage extends StatefulWidget {
  final audioData;
  final int index;
  const AudioPage({Key? key, this.audioData, required this.index})
      : super(key: key);
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF474A48),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _height / 2,
            child: Container(
              color: Color(0xFF474A48),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Color(0xFF474A48),
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  _player.stop();
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: _height * 0.3,
            height: _height * 0.6,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppColors.audioBluishBackground,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF002642),
                    offset: Offset(0.0, 1.0),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: _height * 0.1,
                  ),
                  Text(
                    this.widget.audioData[this.widget.index]["title"],
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    this.widget.audioData[this.widget.index]["text"],
                    style: TextStyle(fontSize: 20, color: Colors.black26),
                  ),
                  AudioFile(
                      SongPlayer: _player,
                      audioPath: this.widget.audioData[this.widget.index]
                          ["audio"]),
                ],
              ),
            ),
          ),
          Positioned(
            top: _height * 0.2,
            left: (_width - 150) / 2,
            right: (_width - 150) / 2,
            height: _height * 0.18,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF909590), width: 5),
                image: DecorationImage(
                  image: AssetImage(
                      this.widget.audioData[this.widget.index]["images"]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
