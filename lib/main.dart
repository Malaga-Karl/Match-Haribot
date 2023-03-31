import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/screens/gameScreen.dart';
import 'package:game/screens/titleScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPLaying = false;

  Future<void> playBackgroundMusic() async {
    // await audioPlayer.setSource(AssetSource('assets/music/bg.mp3'));

    // await audioPlayer.resume();
    await audioPlayer.setReleaseMode(ReleaseMode.loop);
    if (!isPLaying) {
      await audioPlayer.play(AssetSource('music/bg.mp3'), volume: 1.0);
      setState(() {
        isPLaying = true;
      });
    } 
  }

  @override
  void initState() {
    super.initState();
    playBackgroundMusic();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TitleScreen(),
    );
  }
}
